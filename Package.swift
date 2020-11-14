// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TonSDK",
    platforms: [
        .macOS(SupportedPlatform.MacOSVersion.v10_12),
        .iOS(SupportedPlatform.IOSVersion.v10)
    ],
    products: [
        .library(name: "TonSDK", targets: ["TonSDK"])
    ],
    dependencies: [
        .package(name: "SwiftRegularExpression", url: "https://github.com/nerzh/swift-regular-expression.git", .upToNextMajor(from: "0.2.3")),
    ],
    targets: [
        .systemLibrary(name: "CTonSDK", pkgConfig: "libton_client"),
        .target(
            name: "TonSDK",
            dependencies: [
                .byName(name: "CTonSDK"),
                .product(name: "SwiftRegularExpression", package: "SwiftRegularExpression"),
            ]),
        .testTarget(
            name: "TonSDKTests",
            dependencies: [
                .byName(name: "TonSDK")
            ]),
    ],
    swiftLanguageVersions: [
        SwiftVersion.v5
    ]
)
