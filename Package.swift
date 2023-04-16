// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "feather",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .executable(name: "feather", targets: ["Feather"]),
        .executable(name: "feather-test", targets: ["FeatherTest"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser",
            from: "1.2.0"
        ),
        .package(
            url: "https://github.com/binarybirds/shell-kit",
            from: "1.0.0"
        ),
    ],
    targets: [
        .executableTarget(name: "FeatherTest", dependencies: [
            .product(
                name: "ArgumentParser",
                package: "swift-argument-parser"
            ),
        ]),
        .executableTarget(name: "Feather", dependencies: [
            
            .product(name: "ShellKit", package: "shell-kit"),
        ]),
    ]
)
