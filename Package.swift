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
            name: "asutils-core",
            targets: [ "asutils-core" ]
        ),
        .library(
            name: "asutils-ui",
            targets: [ "asutils-ui" ]
        ),
    ],
    targets: [
        .target(
            name: "asutils-core",
            path: "Sources/core"
        ),
        .testTarget(
            name: "asutils-core-tests",
            dependencies: ["asutils-core"],
            path: "Tests/core"
        ),
        .target(
            name: "asutils-ui",
            path: "Sources/ui"
        ),
        .testTarget(
            name: "asutils-ui-tests",
            dependencies: ["asutils-ui"],
            path: "Tests/ui"
        )
    ]
)
