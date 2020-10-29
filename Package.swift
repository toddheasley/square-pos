// swift-tools-version:5.3

import PackageDescription

let package = Package(name: "square-pos",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "SquarePOS", targets: [
            "SquarePOS"
        ])
    ],
    targets: [
        .target(name: "SquarePOS"),
        .testTarget(name: "SquarePOSTests", dependencies: [
            "SquarePOS"
        ])
    ])
