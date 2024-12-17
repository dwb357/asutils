// swift-tools-version: 5.9
//  ASUtils
//
//  © Copyright 2024 David W. Berry. All Rights Reserved.
//

import PackageDescription

let package = Package(
    name: "asutils",
    platforms: [.iOS(.v15), .macOS(.v13)],
    products: [
        .library(name: "mockables", targets: [ "mockables" ]),
        .library(name: "asutils-core", targets: [ "asutils-core" ]),
        .library(name: "asutils-ui", targets: [ "asutils-ui" ])
    ],
    dependencies: [
        .package(url: "https://github.com/Kolos65/Mockable", from: "0.1.1"),
        .package(url: "https://github.com/realm/SwiftLint", from: "0.57.1"),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "asutils-core",
            dependencies: [
                .product(name: "Mockable", package: "Mockable")
            ],
            path: "Sources/core",
            swiftSettings: [
                .define("MOCKING", .when(configuration: .debug))
            ],
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint")
            ]
        ),
        .target(
            name: "asutils-ui",
            path: "Sources/ui",
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint")
            ]
        ),
        .target(
            name: "mockables",
            dependencies: [
                .product(name: "Mockable", package: "Mockable")
            ],
            path: "Sources/mockables",
            swiftSettings: [
                .define("MOCKING", .when(configuration: .debug))
            ],
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint")
            ]
        ),
        .testTarget(
            name: "asutils-core-tests",
            dependencies: [
                "asutils-core",
                .product(name: "Mockable", package: "Mockable")
            ],
            path: "Tests/core",
            swiftSettings: [
                .define("MOCKING", .when(configuration: .debug))
            ],
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint")
            ]
        ),
        .testTarget(
            name: "asutils-ui-tests",
            dependencies: ["asutils-ui"],
            path: "Tests/ui",
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint")
            ]
        )
    ],
    swiftLanguageVersions: [.version("6"), .v5]
)
