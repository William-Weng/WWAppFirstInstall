// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWAppFirstInstall",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "WWAppFirstInstall", targets: ["WWAppFirstInstall"]),
    ],
    dependencies: [
        .package(url: "https://github.com/William-Weng/WWKeychain", from: "1.0.4")
    ],
    targets: [
        .target(name: "WWAppFirstInstall", dependencies: ["WWKeychain"], resources: [.copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
