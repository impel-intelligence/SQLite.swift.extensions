// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SQLite.swift.extensions",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "SQLite.swift.extensions", targets: ["SQLite.swift.extensions"]),
        .library(name: "Dynamic.SQLite.swift.extensions", type: .dynamic, targets: ["SQLite.swift.extensions"]),
    ],
    dependencies: [
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", from: "0.14.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SQLite.swift.extensions", dependencies: [
                .product(name: "SQLite", package: "SQLite.swift"),
            ]),
        .testTarget(
            name: "SQLite.swift.extensionsTests",
            dependencies: ["SQLite.swift.extensions"]),
    ]
)
