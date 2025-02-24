// swift-tools-version: 6.0
//  ASUtils
//
//  © Copyright 2024 David W. Berry. All Rights Reserved.
//

import PackageDescription

@MainActor extension [Target.Dependency] {
    static let common: Self = [
        .product(name: "Mockable", package: "Mockable"),
    ]
}

@MainActor extension [Target.PluginUsage] {
    static let common: Self = [
        .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint"),
    ]
}

@MainActor extension [SwiftSetting] {
    static let common: Self = [
        .define("MOCKING", .when(configuration: .debug)),
    ]
}

@MainActor extension Target {
    static func library(
        name: String,
        dependencies: [PackageDescription.Target.Dependency] = [],
        path: String? = nil,
        exclude: [String] = [],
        sources: [String]? = nil,
        resources: [PackageDescription.Resource]? = nil,
        publicHeadersPath: String? = nil,
        packageAccess: Bool = true,
        cSettings: [PackageDescription.CSetting]? = nil,
        cxxSettings: [PackageDescription.CXXSetting]? = nil,
        swiftSettings: [PackageDescription.SwiftSetting]? = nil,
        linkerSettings: [PackageDescription.LinkerSetting]? = nil,
        plugins: [PackageDescription.Target.PluginUsage]? = nil
    ) -> PackageDescription.Target {
        .target(
            name: name,
            dependencies: .common + dependencies,
            path: path,
            exclude: exclude,
            sources: sources,
            resources: resources,
            publicHeadersPath: publicHeadersPath,
            packageAccess: packageAccess,
            cSettings: cSettings,
            cxxSettings: cxxSettings,
            swiftSettings: .common + (swiftSettings ?? []),
            linkerSettings: linkerSettings,
            plugins: plugins
        )
    }

    public static func test(
        name: String,
        dependencies: [PackageDescription.Target.Dependency] = [],
        path: String? = nil,
        exclude: [String] = [],
        sources: [String]? = nil,
        resources: [PackageDescription.Resource]? = nil,
        packageAccess: Bool = true,
        cSettings: [PackageDescription.CSetting]? = nil,
        cxxSettings: [PackageDescription.CXXSetting]? = nil,
        swiftSettings: [PackageDescription.SwiftSetting]? = nil,
        linkerSettings: [PackageDescription.LinkerSetting]? = nil,
        plugins: [PackageDescription.Target.PluginUsage]? = nil
    ) -> PackageDescription.Target {
        .testTarget(
            name: name + "-tests",
            dependencies: [ .byName(name: name) ] + dependencies,
            path: path ?? "Tests/\(name)",
            exclude: exclude,
            sources: sources,
            resources: resources,
            packageAccess: packageAccess,
            cSettings: cSettings,
            cxxSettings: cxxSettings,
            swiftSettings: swiftSettings,
            linkerSettings: linkerSettings,
            plugins: plugins
        )
    }
}

let package = Package(
    name: "asutils",
    platforms: [.iOS(.v15), .macOS(.v13)],
    products: [
        .library(name: "ASCore", targets: [ "ASCore" ]),
        .library(name: "Logging", targets: [ "Logging" ]),
        .library(name: "Mockables", targets: [ "Mockables" ]),
        .library(name: "ASUIKit", targets: [ "ASUIKit" ])
    ],
    dependencies: [
        .package(url: "https://github.com/Kolos65/Mockable", from: "0.1.1"),
        .package(url: "https://github.com/realm/SwiftLint", from: "0.57.1"),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        .library(
            name: "ASCore",
            path: "Sources/core"
        ),
        .library(
            name: "Logging",
            dependencies: [
                "ASCore",
            ]
        ),
        .library(
            name: "Mockables"
        ),
        .library(
            name: "ASUIKit",
            path: "Sources/ui"
        ),
        .test(
            name: "ASCore",
            path: "Tests/core"
        ),
        .test(
            name: "Logging"
        ),
        .test(
            name: "ASUIKit",
            path: "Tests/ui"
        ),
    ]
)
