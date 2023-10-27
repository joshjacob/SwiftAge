// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftAge",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftAge",
            targets: ["SwiftAge"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/vapor/postgres-nio.git", from: "1.18.1"),
        // .package(url: "https://github.com/antlr/antlr4", from: "4.12.0")
        .package(url: "https://github.com/joshjacob/antlr4", branch: "dev")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftAge",
            dependencies: [
                .product(name: "PostgresNIO", package: "postgres-nio"),
                .product(name: "Antlr4", package: "antlr4")
            ],
            resources: [.copy("Antlr4/Agtype.tokens"),
                        .copy("Antlr4/AgtypeLexer.interp"),
                        .copy("Antlr4/AgtypeLexer.tokens"),
                        .copy("Antlr4/Agtype.interp"),
                        .copy("Antlr4/Agtype.g4")] 
        ),
        .testTarget(
            name: "SwiftAgeTests",
            dependencies: ["SwiftAge"]),
    ]
)
