// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Joe Blau",
    products: [
        .executable(
            name: "JoeBlau",
            targets: ["JoeBlau"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.6.0")
    ],
    targets: [
        .target(
            name: "JoeBlau",
            dependencies: ["Publish"]
        )
    ]
)