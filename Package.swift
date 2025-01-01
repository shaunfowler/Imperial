// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "Imperial",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(name: "ImperialCore", targets: ["ImperialCore"]),
        .library(name: "ImperialGoogle", targets: ["ImperialCore", "ImperialGoogle"]),
        .library(
            name: "Imperial",
            targets: [
                "ImperialCore",
                "ImperialGoogle",
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/jwt-kit.git", from: "5.0.0"),
    ],
    targets: [
        .target(
            name: "ImperialCore",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "JWTKit", package: "jwt-kit"),
            ],
            swiftSettings: swiftSettings
        ),
        .target(name: "ImperialGoogle", dependencies: ["ImperialCore"], swiftSettings: swiftSettings),
        .testTarget(
            name: "ImperialTests",
            dependencies: [
                .target(name: "ImperialCore"),
                .target(name: "ImperialGoogle"),
                .product(name: "XCTVapor", package: "vapor"),
            ],
            swiftSettings: swiftSettings
        ),
    ]
)

var swiftSettings: [SwiftSetting] {
    [
        .enableUpcomingFeature("ExistentialAny")
    ]
}
