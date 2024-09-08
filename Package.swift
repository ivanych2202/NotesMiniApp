// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NotesMiniApp",
    products: [
        .library(
            name: "NotesMiniApp",
            targets: ["NotesMiniApp"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-swift.git", from: "10.25.0")
    ],
    targets: [
        .target(
            name: "NotesMiniApp",
            dependencies: [
                .product(name: "RealmSwift", package: "realm-swift")
            ]),
        .testTarget(
            name: "NotesMiniAppTests",
            dependencies: ["NotesMiniApp"]),
    ]
)
