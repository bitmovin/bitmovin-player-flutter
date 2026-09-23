// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "bitmovin_player",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "bitmovin-player", targets: ["bitmovin_player"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        .package(url: "https://github.com/bitmovin/player-ios.git", exact: "3.124.0")
    ],
    targets: [
        .target(
            name: "bitmovin_player",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "BitmovinPlayer", package: "player-ios")
            ]
        )
    ]
)
