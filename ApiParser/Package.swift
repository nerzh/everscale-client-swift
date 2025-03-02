// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ApiParser",
    platforms: [
        .macOS(SupportedPlatform.MacOSVersion.v10_13)
    ],
    products: [
        .executable(name: "ApiParser", targets: ["ApiParser"])
    ],
    dependencies: [
        .package(url: "https://github.com/nerzh/swift-regular-expression.git", .upToNextMajor(from: "0.2.4")),
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.4.3")),
        .package(url: "https://github.com/nerzh/SwiftFileUtils", .upToNextMinor(from: "1.3.0")),
    ],
    targets: [
        .executableTarget(
            name: "ApiParser",
            dependencies: [
                .product(name: "SwiftRegularExpression", package: "swift-regular-expression"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "FileUtils", package: "SwiftFileUtils"),
            ]),
    ]
)
