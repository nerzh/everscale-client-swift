// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EverscaleClientSwift",
    platforms: [
        .macOS(SupportedPlatform.MacOSVersion.v12),
        .iOS(SupportedPlatform.IOSVersion.v11)
    ],
    products: [
        .library(name: "EverscaleClientSwift", targets: ["EverscaleClientSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nerzh/swift-regular-expression.git", .upToNextMajor(from: "0.2.4")),
        .package(url: "https://github.com/nerzh/SwiftFileUtils", .upToNextMajor(from: "1.3.0")),
        .package(url: "https://github.com/bytehubio/BigInt", exact: "5.3.0"),
        .package(url: "https://github.com/nerzh/swift-extensions-pack", .upToNextMajor(from: "1.3.6")),
    ],
    targets: [
        .systemLibrary(name: "CTonSDK", pkgConfig: "libton_client"),
        .target(
            name: "EverscaleClientSwift",
            dependencies: [
                .byName(name: "CTonSDK"),
                .product(name: "SwiftRegularExpression", package: "swift-regular-expression"),
                .product(name: "BigInt", package: "BigInt"),
                .product(name: "SwiftExtensionsPack", package: "swift-extensions-pack"),
            ]),
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
