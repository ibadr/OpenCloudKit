// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "OpenCloudKit",
    dependencies: [
        .package(url: "https://github.com/vapor/clibressl.git", from: "1.0.0"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "1.0.0"),
        .package(url: "https://github.com/ibadr/Jay.git", .branch("master"))
        ]
)

#if os(Linux)
    package.exclude.append("Sources/CLLocation+OpenCloudKit.swift")
#endif
 
