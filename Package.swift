// swift-tools-version: 6.0
//  ASUtils
//
//  © Copyright 2024 David W. Berry. All Rights Reserved.
//

import PackageDescription

let package = Package(
    name: "asutils",
    platforms: [.iOS(.v15), .macOS(.v13)],
    products: [
        .library(
            name: "asutils-ui",
            targets: [ "asutils-ui" ]
        ),
    ],
    targets: [
        .target(
            name: "asutils-ui",
            path: "Sources/ui"
        ),
        .testTarget(
            name: "asutils-ui-unittests",
            dependencies: ["asutils-ui"],
            path: "Tests/ui-unittests"
        )
    ]
)
