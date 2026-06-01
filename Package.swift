// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let packageRootURL = URL(fileURLWithPath: #filePath).deletingLastPathComponent()
let environment = ProcessInfo.processInfo.environment
let ctonSDKXCFrameworkPath = "Dependencies/ever-sdk/prebuilt/CTonSDK.xcframework"

func nonEmptyEnv(_ key: String) -> String? {
    guard let value = environment[key]?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty else {
        return nil
    }
    return value
}

func absoluteURL(_ path: String, relativeTo root: URL) -> URL {
    path.hasPrefix("/") ? URL(fileURLWithPath: path) : root.appendingPathComponent(path)
}

func capture(_ executable: String, _ arguments: [String] = []) -> String {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    process.arguments = [executable] + arguments
    let stdout = Pipe()
    process.standardOutput = stdout
    process.standardError = Pipe()
    do {
        try process.run()
        process.waitUntilExit()
    } catch {
        return ""
    }
    guard process.terminationStatus == 0 else { return "" }
    let data = stdout.fileHandleForReading.readDataToEndOfFile()
    return String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
}

func hostMachine() -> String {
    let machine = capture("uname", ["-m"])
    return machine.isEmpty ? "unknown" : machine
}

func selectedAppleArch() -> String {
    let candidates = [
        nonEmptyEnv("CURRENT_ARCH"),
        nonEmptyEnv("NATIVE_ARCH_ACTUAL"),
        nonEmptyEnv("ARCHS")?.split(separator: " ").first.map(String.init),
        hostMachine()
    ]
    return candidates.compactMap { $0 }.first { $0 != "undefined_arch" } ?? hostMachine()
}

func localFileExists(_ relativePath: String) -> Bool {
    FileManager.default.fileExists(atPath: packageRootURL.appendingPathComponent(relativePath).path)
}

func localEverSdkLinkerFlags() -> [String] {
    if let override = nonEmptyEnv("EVERSCALE_CLIENT_SWIFT_EVER_CLIENT_STATIC_LIB") {
        return [absoluteURL(override, relativeTo: packageRootURL).path]
    }

    let machine = hostMachine()
    return localEverSdkLibraryFlags(platformID: "linux-\(machine)")
}

func localEverSdkLibraryURL(platformID: String) -> URL {
    packageRootURL
        .appendingPathComponent("Dependencies")
        .appendingPathComponent("ever-sdk")
        .appendingPathComponent("prebuilt")
        .appendingPathComponent(platformID)
        .appendingPathComponent("libever_client.a")
}

func localEverSdkLibraryFlags(platformID: String) -> [String] {
    return [localEverSdkLibraryURL(platformID: platformID).path]
}

func localEverSdkLibraryFlags(platformID: String, preferredPlatformID: String) -> [String] {
    let preferredURL = localEverSdkLibraryURL(platformID: preferredPlatformID)
    if FileManager.default.fileExists(atPath: preferredURL.path) {
        return [preferredURL.path]
    }

    return localEverSdkLibraryFlags(platformID: platformID)
}

func appleEverSdkLinkerFlags() -> [String] {
    if let override = nonEmptyEnv("EVERSCALE_CLIENT_SWIFT_EVER_CLIENT_STATIC_LIB") {
        return [absoluteURL(override, relativeTo: packageRootURL).path]
    }

    let platformName = nonEmptyEnv("PLATFORM_NAME") ?? ""
    let sdkRoot = nonEmptyEnv("SDKROOT") ?? ""
    let arch = selectedAppleArch()

    if platformName.contains("iphoneos") || sdkRoot.contains("iPhoneOS") {
        return localEverSdkLibraryFlags(platformID: "ios-arm64")
    }

    if platformName.contains("iphonesimulator") || sdkRoot.contains("iPhoneSimulator") {
        let platformID = arch == "x86_64" ? "ios-simulator-x86_64" : "ios-simulator-arm64"
        return localEverSdkLibraryFlags(
            platformID: platformID,
            preferredPlatformID: "ios-simulator-universal"
        )
    }

    let platformID = arch == "x86_64" ? "macos-x86_64" : "macos-arm64"
    return localEverSdkLibraryFlags(
        platformID: platformID,
        preferredPlatformID: "macos-universal"
    )
}

#if os(macOS)
func makeAppleCTonSDKTarget() -> Target {
    if localFileExists(ctonSDKXCFrameworkPath) {
        return .binaryTarget(
            name: "CTonSDK",
            path: ctonSDKXCFrameworkPath
        )
    }

    return .target(
        name: "CTonSDK",
        path: "Sources/CTonSDK",
        sources: ["src/CTonSDK.c"],
        publicHeadersPath: "include",
        linkerSettings: [
            .unsafeFlags(appleEverSdkLinkerFlags()),
        ])
}

let ctonSDKTarget: Target = makeAppleCTonSDKTarget()

let nativeLinkerSettings: [LinkerSetting] = [
    .linkedFramework("Security", .when(platforms: [.macOS, .iOS])),
    .linkedFramework("CoreFoundation", .when(platforms: [.macOS, .iOS])),
    .linkedFramework("SystemConfiguration", .when(platforms: [.macOS, .iOS])),
    .linkedLibrary("iconv", .when(platforms: [.macOS, .iOS])),
]
#elseif os(Linux)
let ctonSDKTarget: Target = .target(
    name: "CTonSDK",
    path: "Sources/CTonSDK",
    sources: ["src/CTonSDK.c"],
    publicHeadersPath: "include",
    linkerSettings: [
        .unsafeFlags(localEverSdkLinkerFlags()),
        .linkedLibrary("dl", .when(platforms: [.linux])),
        .linkedLibrary("pthread", .when(platforms: [.linux])),
        .linkedLibrary("m", .when(platforms: [.linux])),
    ])

let nativeLinkerSettings: [LinkerSetting] = []
#else
let ctonSDKTarget: Target = .target(
    name: "CTonSDK",
    path: "Sources/CTonSDK",
    sources: ["src/CTonSDK.c"],
    publicHeadersPath: "include",
    linkerSettings: [
        .unsafeFlags(localEverSdkLibraryFlags(platformID: "unsupported")),
    ])

let nativeLinkerSettings: [LinkerSetting] = []
#endif

let package = Package(
    name: "EverscaleClientSwift",
    platforms: [
        .macOS(.v12),
        .iOS(.v13)
    ],
    products: [
        .library(name: "EverscaleClientSwift", targets: ["EverscaleClientSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nerzh/swift-regular-expression.git", .upToNextMajor(from: "0.2.4")),
        .package(url: "https://github.com/nerzh/SwiftFileUtils", .upToNextMajor(from: "1.3.0")),
        .package(url: "https://github.com/bytehubio/BigInt", exact: "5.3.0"),
        .package(url: "https://github.com/nerzh/swift-extensions-pack", .upToNextMajor(from: "2.0.0")),
    ],
    targets: [
        ctonSDKTarget,
        .target(
            name: "EverscaleClientSwift",
            dependencies: [
                .byName(name: "CTonSDK"),
                .product(name: "SwiftRegularExpression", package: "swift-regular-expression"),
                .product(name: "BigInt", package: "BigInt"),
                .product(name: "SwiftExtensionsPack", package: "swift-extensions-pack"),
            ],
            linkerSettings: nativeLinkerSettings),
        .testTarget(
            name: "EverscaleClientSwiftTests",
            dependencies: [
                .product(name: "SwiftRegularExpression", package: "swift-regular-expression"),
                .byName(name: "EverscaleClientSwift"),
                .product(name: "FileUtils", package: "SwiftFileUtils"),
                .product(name: "BigInt", package: "BigInt"),
                .product(name: "SwiftExtensionsPack", package: "swift-extensions-pack"),
            ]),
    ]
)
