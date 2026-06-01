// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let ctonSDKXCFrameworkPath = "Sources/CTonSDKBinary/CTonSDK.xcframework"

#if os(macOS)
func makeAppleCTonSDKTarget() -> Target {
    .binaryTarget(
        name: "CTonSDK",
        path: ctonSDKXCFrameworkPath
    )
}

let ctonSDKTarget: Target = makeAppleCTonSDKTarget()

let nativeLinkerSettings: [LinkerSetting] = [
    .linkedFramework("Security", .when(platforms: [.macOS, .iOS])),
    .linkedFramework("CoreFoundation", .when(platforms: [.macOS, .iOS])),
    .linkedFramework("SystemConfiguration", .when(platforms: [.macOS, .iOS])),
    .linkedLibrary("iconv", .when(platforms: [.macOS, .iOS])),
]
#elseif os(Linux)
let ctonSDKTarget: Target = .systemLibrary(
    name: "CTonSDK",
    path: "Sources/CTonSDK/include",
    pkgConfig: "ctonsdk")

let nativeLinkerSettings: [LinkerSetting] = []
#else
let ctonSDKTarget: Target = .target(
    name: "CTonSDK",
    path: "Sources/CTonSDK",
    sources: ["src/CTonSDK.c"],
    publicHeadersPath: "include")

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
