// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TonClientSwift",
    platforms: [
        .macOS(SupportedPlatform.MacOSVersion.v10_12),
        .iOS(SupportedPlatform.IOSVersion.v10)
    ],
    products: [
        .library(name: "TonClientSwift", targets: ["TonClientSwift"]),
        .executable(name: "ApiParser", targets: ["ApiParser"])
    ],
    dependencies: [
        .package(name: "SwiftRegularExpression", url: "https://github.com/nerzh/swift-regular-expression.git", .upToNextMajor(from: "0.2.3")),
        .package(name: "swift-argument-parser", url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.4.3")),
        .package(name: "FileUtils", url: "https://github.com/nerzh/SwiftFileUtils", .upToNextMinor(from: "1.3.0")),
    ],
    targets: [
        .systemLibrary(name: "CTonSDK", pkgConfig: "libton_client"),
        .target(
            name: "TonClientSwift",
            dependencies: [
                .byName(name: "CTonSDK"),
                .product(name: "SwiftRegularExpression", package: "SwiftRegularExpression"),
            ]),
        .executableTarget(
            name: "ApiParser",
            dependencies: [
                .product(name: "SwiftRegularExpression", package: "SwiftRegularExpression"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "FileUtils", package: "FileUtils"),
            ]),
        .testTarget(
            name: "TonClientSwiftTests",
            dependencies: [
                .product(name: "SwiftRegularExpression", package: "SwiftRegularExpression"),
                .byName(name: "TonClientSwift")
            ]),
    ],
    swiftLanguageVersions: [
        SwiftVersion.v5
    ]
)
