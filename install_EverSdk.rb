#!/usr/bin/env ruby

require "fileutils"
require "open3"
require "optparse"
require "rbconfig"
require "shellwords"
require "tempfile"

ROOT = File.expand_path(__dir__)

DEFAULT_REPO_URL = "https://github.com/everx-labs/ever-sdk"
DEFAULT_REF = "master"
DEFAULT_TOOLCHAIN = "stable"
DEFAULT_CARGO_PACKAGE = "ever_client"
DEFAULT_FEATURES = "std,rustls-tls-webpki-roots"

APPLE_TARGETS = {
  "macos-arm64" => {
    rust_target: "aarch64-apple-darwin",
    sdk: "macosx",
    env: { "MACOSX_DEPLOYMENT_TARGET" => "12.0" }
  },
  "macos-x86_64" => {
    rust_target: "x86_64-apple-darwin",
    sdk: "macosx",
    env: { "MACOSX_DEPLOYMENT_TARGET" => "12.0" }
  },
  "ios-arm64" => {
    rust_target: "aarch64-apple-ios",
    sdk: "iphoneos",
    env: { "IPHONEOS_DEPLOYMENT_TARGET" => "13.0" }
  },
  "ios-simulator-arm64" => {
    rust_target: "aarch64-apple-ios-sim",
    sdk: "iphonesimulator",
    env: { "IPHONEOS_DEPLOYMENT_TARGET" => "13.0" }
  },
  "ios-simulator-x86_64" => {
    rust_target: "x86_64-apple-ios",
    sdk: "iphonesimulator",
    env: { "IPHONEOS_DEPLOYMENT_TARGET" => "13.0" }
  }
}.freeze

options = {
  platform: "auto",
  repo_url: ENV.fetch("EVER_SDK_REPO_URL", DEFAULT_REPO_URL),
  ref: ENV.fetch("EVER_SDK_REF", DEFAULT_REF),
  toolchain: ENV.fetch("EVER_SDK_RUST_TOOLCHAIN", DEFAULT_TOOLCHAIN),
  cargo_package: ENV.fetch("EVER_SDK_CARGO_PACKAGE", DEFAULT_CARGO_PACKAGE),
  features: ENV.fetch("EVER_SDK_FEATURES", DEFAULT_FEATURES),
  sdk_dir: File.expand_path(ENV.fetch("EVER_SDK_DIR", File.join(ROOT, "Dependencies", "ever-sdk"))),
  update: true,
  clean: false,
  skip_build: false
}

OptionParser.new do |parser|
  parser.banner = "Usage: ruby install_EverSdk.rb [options]"

  parser.on(
    "-p",
    "--platform PLATFORM",
    "auto, current, apple, macos, ios, ios-simulator, linux, or exact platform id"
  ) { |value| options[:platform] = value }

  parser.on("--repo-url URL", "ever-sdk repository URL") { |value| options[:repo_url] = value }
  parser.on("--ref REF", "ever-sdk branch, tag, or commit") { |value| options[:ref] = value }
  parser.on("--sdk-dir PATH", "checkout/output directory") { |value| options[:sdk_dir] = File.expand_path(value) }
  parser.on("--toolchain NAME", "Rust toolchain") { |value| options[:toolchain] = value }
  parser.on("--features LIST", "Cargo features") { |value| options[:features] = value }
  parser.on("--cargo-package NAME", "Cargo package name") { |value| options[:cargo_package] = value }
  parser.on("--no-update", "do not fetch/pull an existing checkout") { options[:update] = false }
  parser.on("--clean", "remove existing target/prebuilt outputs before build") { options[:clean] = true }
  parser.on("--skip-build", "reuse existing prebuilt libraries and only refresh headers/XCFramework") { options[:skip_build] = true }
  parser.on("-h", "--help", "show help") do
    puts parser
    exit 0
  end
end.parse!

ENV["PATH"] = [
  File.join(Dir.home, ".cargo", "bin"),
  "/opt/homebrew/bin",
  "/opt/homebrew/sbin",
  "/usr/local/bin",
  "/usr/local/sbin",
  "/opt/local/bin",
  "/opt/local/sbin",
  ENV.fetch("PATH", "")
].join(File::PATH_SEPARATOR)

def say(message = "")
  puts(message)
end

def section(title)
  say
  say("==> #{title}")
end

def printable_command(cmd, env = {})
  env_prefix = env.compact.map { |key, value| "#{key}=#{Shellwords.escape(value.to_s)}" }.join(" ")
  command = cmd.map { |part| Shellwords.escape(part.to_s) }.join(" ")
  env_prefix.empty? ? command : "#{env_prefix} #{command}"
end

def run(*cmd, chdir: ROOT, env: {})
  say("$ #{printable_command(cmd, env)}")
  ok = system(env, *cmd.map(&:to_s), chdir: chdir)
  raise("Command failed: #{printable_command(cmd, env)}") unless ok
end

def capture(*cmd, chdir: ROOT, env: {})
  stdout, stderr, status = Open3.capture3(env, *cmd.map(&:to_s), chdir: chdir)
  raise("Command failed: #{printable_command(cmd, env)}\n#{stderr}\n#{stdout}") unless status.success?
  stdout.strip
end

def command_exists?(name)
  ENV.fetch("PATH", "").split(File::PATH_SEPARATOR).any? do |directory|
    path = File.join(directory, name)
    File.file?(path) && File.executable?(path)
  end
end

def macos?
  RUBY_PLATFORM.include?("darwin")
end

def linux?
  RUBY_PLATFORM.include?("linux")
end

def host_machine
  capture("uname", "-m")
rescue
  RbConfig::CONFIG["host_cpu"]
end

def current_macos_platform_id
  host_machine == "x86_64" ? "macos-x86_64" : "macos-arm64"
end

def current_linux_platform
  {
    id: "linux-#{host_machine}",
    rust_target: nil,
    sdk: nil,
    env: {}
  }
end

def selected_platforms(selection)
  case selection
  when "auto", "all", "apple"
    return APPLE_TARGETS.map { |id, info| info.merge(id: id) } if macos?
    return [current_linux_platform] if linux?
  when "current"
    return [APPLE_TARGETS.fetch(current_macos_platform_id).merge(id: current_macos_platform_id)] if macos?
    return [current_linux_platform] if linux?
  when "macos"
    return %w[macos-arm64 macos-x86_64].map { |id| APPLE_TARGETS.fetch(id).merge(id: id) } if macos?
  when "ios"
    return [APPLE_TARGETS.fetch("ios-arm64").merge(id: "ios-arm64")] if macos?
  when "ios-simulator"
    return %w[ios-simulator-arm64 ios-simulator-x86_64].map { |id| APPLE_TARGETS.fetch(id).merge(id: id) } if macos?
  when "linux"
    return [current_linux_platform] if linux?
  else
    if APPLE_TARGETS.key?(selection)
      raise("#{selection} can only be built on macOS.") unless macos?
      return [APPLE_TARGETS.fetch(selection).merge(id: selection)]
    end

    if selection.start_with?("linux-")
      current = current_linux_platform
      raise("#{selection} can only be built natively on matching Linux host #{current[:id]}.") unless linux? && selection == current[:id]
      return [current]
    end
  end

  raise("Unsupported platform selection: #{selection}")
end

def ensure_commands(names)
  missing = names.reject { |name| command_exists?(name) }
  return if missing.empty?

  raise("Missing required commands: #{missing.join(", ")}")
end

def rust_toolchain_installed?(toolchain)
  capture("rustup", "toolchain", "list").lines.any? { |line| line.start_with?(toolchain) }
rescue
  false
end

def rust_target_installed?(toolchain, target)
  capture("rustup", "target", "list", "--installed", "--toolchain", toolchain).lines.map(&:strip).include?(target)
rescue
  false
end

def ensure_rust(toolchain, targets)
  section("Rust")
  unless rust_toolchain_installed?(toolchain)
    run("rustup", "toolchain", "install", toolchain)
  end

  missing_targets = targets.compact.uniq.reject { |target| rust_target_installed?(toolchain, target) }
  run("rustup", "target", "add", "--toolchain", toolchain, *missing_targets) unless missing_targets.empty?

  still_missing = targets.compact.uniq.reject { |target| rust_target_installed?(toolchain, target) }
  raise("Missing Rust targets: #{still_missing.join(", ")}") unless still_missing.empty?
end

def ensure_ever_sdk_checkout(options)
  section("ever-sdk checkout")
  sdk_dir = options[:sdk_dir]
  FileUtils.mkdir_p(File.dirname(sdk_dir))

  if File.directory?(File.join(sdk_dir, ".git"))
    if options[:update]
      run("git", "fetch", "--tags", "origin", chdir: sdk_dir)
      run("git", "checkout", options[:ref], chdir: sdk_dir)
      branch = capture("git", "rev-parse", "--abbrev-ref", "HEAD", chdir: sdk_dir)
      run("git", "pull", "--ff-only", chdir: sdk_dir) unless branch == "HEAD"
    else
      say("Using existing checkout: #{sdk_dir}")
    end
  elsif File.file?(File.join(sdk_dir, "Cargo.toml"))
    say("Using existing source directory: #{sdk_dir}")
  else
    FileUtils.rm_rf(sdk_dir)
    run("git", "clone", options[:repo_url], sdk_dir)
    run("git", "checkout", options[:ref], chdir: sdk_dir)
  end
end

def generated_include_dir(sdk_dir)
  File.join(sdk_dir, "prebuilt", "include")
end

def generated_tonclient_header_path(sdk_dir)
  File.join(generated_include_dir(sdk_dir), "CTonSDK", "tonclient.h")
end

def copy_tonclient_header(sdk_dir)
  section("CTonSDK header")
  candidates = [
    File.join(sdk_dir, "ever_client", "tonclient.h"),
    File.join(sdk_dir, "ton_client", "tonclient.h"),
    File.join(sdk_dir, "ton_client", "client", "tonclient.h")
  ]
  source = candidates.find { |path| File.file?(path) }

  unless source
    raise("tonclient.h was not found in ever-sdk checkout. Checked:\n#{candidates.join("\n")}")
  end

  output = generated_tonclient_header_path(sdk_dir)
  FileUtils.mkdir_p(File.dirname(output))
  FileUtils.cp(source, output)
  say("Copied #{source}")
  say("to     #{output}")
end

def xcrun_sdk_path(sdk)
  capture("xcrun", "--sdk", sdk, "--show-sdk-path")
end

def cargo_env(platform)
  env = {
    "CARGO_NET_GIT_FETCH_WITH_CLI" => "true",
    "LIBRARY_PATH" => nil,
    "CPATH" => nil,
    "C_INCLUDE_PATH" => nil,
    "CPLUS_INCLUDE_PATH" => nil,
    "OBJC_INCLUDE_PATH" => nil,
    "DYLD_LIBRARY_PATH" => nil,
    "LD_LIBRARY_PATH" => nil,
    "PKG_CONFIG_PATH" => nil,
    "PKG_CONFIG_LIBDIR" => nil,
    "PKG_CONFIG_SYSROOT_DIR" => nil
  }

  if platform[:sdk]
    env["SDKROOT"] = xcrun_sdk_path(platform[:sdk])
  end

  env.merge(platform[:env] || {})
end

def cargo_build_command(options, platform)
  command = [
    "cargo",
    "+#{options[:toolchain]}",
    "build",
    "--release",
    "-p",
    options[:cargo_package],
    "--no-default-features",
    "--features",
    options[:features]
  ]
  command += ["--target", platform[:rust_target]] if platform[:rust_target]
  command
end

def built_library_path(sdk_dir, platform)
  if platform[:rust_target]
    File.join(sdk_dir, "target", platform[:rust_target], "release", "libever_client.a")
  else
    File.join(sdk_dir, "target", "release", "libever_client.a")
  end
end

def prebuilt_library_path(sdk_dir, platform_id)
  File.join(sdk_dir, "prebuilt", platform_id, "libever_client.a")
end

def package_xcframework_path
  File.join(ROOT, "Sources", "CTonSDKBinary", "CTonSDK.xcframework")
end

def pkg_config_search_paths
  return [] unless command_exists?("pkg-config")

  capture("pkg-config", "--variable", "pc_path", "pkg-config")
    .split(File::PATH_SEPARATOR)
    .map(&:strip)
    .reject(&:empty?)
rescue
  []
end

def multiarch_triplet
  if command_exists?("gcc")
    value = capture("gcc", "-print-multiarch")
    return value unless value.empty?
  end

  if command_exists?("cc")
    value = capture("cc", "-print-multiarch")
    return value unless value.empty?
  end

  nil
rescue
  nil
end

def default_pkg_config_dir
  override = ENV["CTONSDK_PKG_CONFIG_DIR"]&.strip
  return File.expand_path(override) unless override.nil? || override.empty?

  paths = pkg_config_search_paths
  triplet = multiarch_triplet
  preferred = []
  preferred << "/usr/local/lib/#{triplet}/pkgconfig" if triplet
  preferred << "/usr/local/lib/pkgconfig"
  preferred << "/usr/local/share/pkgconfig"
  preferred += paths

  preferred.uniq.find { |path| paths.empty? || paths.include?(path) } || "/usr/local/lib/pkgconfig"
end

def write_file_or_sudo(path, content)
  dir = File.dirname(path)
  begin
    FileUtils.mkdir_p(dir)
    File.write(path, content)
  rescue Errno::EACCES, Errno::EROFS
    raise("Cannot write #{path}; sudo is not available.") unless command_exists?("sudo")

    Tempfile.create("ctonsdk-pkgconfig") do |file|
      file.write(content)
      file.flush
      run("sudo", "mkdir", "-p", dir)
      run("sudo", "cp", file.path, path)
      run("sudo", "chmod", "0644", path)
    end
  end
end

def install_linux_pkg_config(sdk_dir, platforms)
  platform = platforms.find { |item| item[:id].start_with?("linux-") }
  return unless platform

  library = prebuilt_library_path(sdk_dir, platform[:id])
  raise("Missing Linux library for pkg-config: #{library}") unless File.file?(library)
  header = generated_tonclient_header_path(sdk_dir)
  raise("Missing Linux header for pkg-config: #{header}") unless File.file?(header)

  section("CTonSDK pkg-config")
  pkg_config_dir = default_pkg_config_dir
  pkg_config_file = File.join(pkg_config_dir, "ctonsdk.pc")
  content = <<~PC
    libdir=#{File.dirname(library)}
    modulemapdir=#{File.join(ROOT, "Sources", "CTonSDK", "include")}
    includedir=#{generated_include_dir(sdk_dir)}
    ctonsdkincludedir=${includedir}/CTonSDK

    Name: CTonSDK
    Description: Everscale Client Swift native library
    Version: 1
    Libs: -L${libdir} -lever_client -ldl -lpthread -lm
    Cflags: -I${modulemapdir} -I${includedir} -I${ctonsdkincludedir}
  PC

  write_file_or_sudo(pkg_config_file, content)
  say("Installed #{pkg_config_file}")
end

def build_platform(options, platform)
  section("Build #{platform[:id]}")
  run(*cargo_build_command(options, platform), chdir: options[:sdk_dir], env: cargo_env(platform))

  source = built_library_path(options[:sdk_dir], platform)
  raise("Cargo did not create #{source}") unless File.file?(source)

  output = prebuilt_library_path(options[:sdk_dir], platform[:id])
  FileUtils.mkdir_p(File.dirname(output))
  FileUtils.cp(source, output)
  say("Copied #{output}")
end

def create_universal_library(sdk_dir, output_id, input_ids)
  return unless macos?
  return unless command_exists?("lipo")

  inputs = input_ids.map { |id| prebuilt_library_path(sdk_dir, id) }
  return unless inputs.all? { |path| File.file?(path) }

  output = prebuilt_library_path(sdk_dir, output_id)
  FileUtils.mkdir_p(File.dirname(output))
  run("lipo", "-create", *inputs, "-output", output)
  say("Created #{output}")
end

def prepare_xcframework_headers(sdk_dir)
  headers_dir = File.join(sdk_dir, "prebuilt", "CTonSDKHeaders")
  FileUtils.rm_rf(headers_dir)
  FileUtils.mkdir_p(File.join(headers_dir, "CTonSDK"))

  module_map = File.join(ROOT, "Sources", "CTonSDK", "include", "module.modulemap")
  shim_header = File.join(ROOT, "Sources", "CTonSDK", "include", "CTonSDK", "shim.h")
  tonclient_header = generated_tonclient_header_path(sdk_dir)

  [module_map, shim_header, tonclient_header].each do |path|
    raise("Missing XCFramework header input: #{path}") unless File.file?(path)
  end

  FileUtils.cp(module_map, File.join(headers_dir, "module.modulemap"))
  FileUtils.cp(shim_header, File.join(headers_dir, "CTonSDK", "shim.h"))
  FileUtils.cp(tonclient_header, File.join(headers_dir, "CTonSDK", "tonclient.h"))
  headers_dir
end

def best_existing_library(sdk_dir, preferred_ids)
  preferred_ids
    .map { |id| prebuilt_library_path(sdk_dir, id) }
    .find { |path| File.file?(path) }
end

def create_apple_xcframework(sdk_dir)
  return unless macos?

  section("CTonSDK XCFramework")
  headers_dir = prepare_xcframework_headers(sdk_dir)
  libraries = [
    { id: "ios-arm64", path: best_existing_library(sdk_dir, %w[ios-arm64]) },
    { id: "ios-simulator", path: best_existing_library(sdk_dir, %w[ios-simulator-universal ios-simulator-arm64 ios-simulator-x86_64]) },
    { id: "macos", path: best_existing_library(sdk_dir, %w[macos-universal macos-arm64 macos-x86_64]) }
  ].select { |library| library[:path] }

  if libraries.empty?
    say("No Apple prebuilt libraries found; skipping XCFramework.")
    return
  end

  output = package_xcframework_path
  legacy_output = File.join(sdk_dir, "prebuilt", "CTonSDK.xcframework")
  staging_root = File.join(sdk_dir, "prebuilt", "CTonSDKXcframeworkLibraries")
  FileUtils.rm_rf(output)
  FileUtils.rm_rf(legacy_output) unless legacy_output == output
  FileUtils.rm_rf(staging_root)
  FileUtils.mkdir_p(File.dirname(output))

  command = ["xcodebuild", "-create-xcframework"]
  libraries.each do |library|
    staged_dir = File.join(staging_root, library[:id])
    staged_library = File.join(staged_dir, "libCTonSDK.a")
    FileUtils.mkdir_p(staged_dir)
    FileUtils.cp(library[:path], staged_library)
    command += ["-library", staged_library, "-headers", headers_dir]
  end
  command += ["-output", output]
  run(*command)
  FileUtils.rm_rf(staging_root)
  say("Created #{output}")
end

def verify_outputs(sdk_dir, platforms)
  section("Verification")
  missing = platforms.map { |platform| prebuilt_library_path(sdk_dir, platform[:id]) }.reject { |path| File.file?(path) }
  raise("Missing native libraries:\n#{missing.join("\n")}") unless missing.empty?
  if macos?
    xcframework = package_xcframework_path
    raise("Missing native XCFramework: #{xcframework}") unless File.directory?(xcframework)
  end
  say("Native libraries are ready under #{File.join(sdk_dir, "prebuilt")}")
end

begin
  platforms = selected_platforms(options[:platform])

  section("EverscaleClientSwift native dependency")
  say("Package root: #{ROOT}")
  say("ever-sdk dir: #{options[:sdk_dir]}")
  say("Platforms: #{platforms.map { |platform| platform[:id] }.join(", ")}")

  required = %w[git]
  required += %w[rustup cargo] unless options[:skip_build]
  required += %w[xcrun lipo xcodebuild] if macos?
  required += %w[pkg-config] if linux?
  ensure_commands(required)

  ensure_rust(options[:toolchain], platforms.map { |platform| platform[:rust_target] }) unless options[:skip_build]
  ensure_ever_sdk_checkout(options)

  if options[:clean] && options[:skip_build]
    raise("--clean cannot be used together with --skip-build")
  elsif options[:clean]
    FileUtils.rm_rf(File.join(options[:sdk_dir], "target"))
    FileUtils.rm_rf(File.join(options[:sdk_dir], "prebuilt"))
  end

  copy_tonclient_header(options[:sdk_dir])

  if options[:skip_build]
    section("Build")
    say("Skipping Cargo build; using existing prebuilt libraries.")
  else
    platforms.each { |platform| build_platform(options, platform) }
  end

  create_universal_library(options[:sdk_dir], "macos-universal", %w[macos-arm64 macos-x86_64])
  create_universal_library(options[:sdk_dir], "ios-simulator-universal", %w[ios-simulator-arm64 ios-simulator-x86_64])
  create_apple_xcframework(options[:sdk_dir])
  install_linux_pkg_config(options[:sdk_dir], platforms)
  verify_outputs(options[:sdk_dir], platforms)

  section("Done")
  say("Run Swift build again. Package.swift uses #{package_xcframework_path} on Apple and ctonsdk.pc on Linux.")
rescue => error
  warn
  warn("ERROR: #{error.message}")
  exit 1
end
