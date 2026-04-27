// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "CoordinateFormatStyle",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .watchOS(.v9),
        .tvOS(.v16)
    ],
    products: [
        .library(
            name: "CoordinateFormatStyle",
            targets: ["CoordinateFormatStyle"]),
    ],
    dependencies: [
        .package(url: "https://github.com/designedbyclowns/UTMConversion.git", branch: "15-invalid-coordinate-fix"),
        .package(url: "https://github.com/apple/swift-numerics.git", from: "1.0.0"),
        .package(url: "https://github.com/designedbyclowns/GeoURI.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "CoordinateFormatStyle",
            dependencies: [
                .product(name: "UTMConversion", package: "UTMConversion"),
                .product(name: "GeoURI", package: "GeoURI"),
            ],
//            swiftSettings: [
//                .defaultIsolation(MainActor.self),
//                .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
//                .enableUpcomingFeature("InferIsolatedConformances"),
//            ]
        ),
        .testTarget(
            name: "CoordinateFormatStyleTests",
            dependencies: [
                "CoordinateFormatStyle",
                .product(name: "Numerics", package: "swift-numerics"),
            ]
        ),
    ]
)

for target in package.targets {
    var settings = target.swiftSettings ?? []
    settings.append(contentsOf: [
//        .defaultIsolation(MainActor.self),
//        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
//        .enableUpcomingFeature("InferIsolatedConformances"),
//        .enableUpcomingFeature("InternalImportsByDefault")
    ])
    target.swiftSettings = settings
}
