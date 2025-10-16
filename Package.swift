// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "FluidAudio",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .visionOS(.v2)
    ],
    products: [
        // Library product only (visionOS cannot consume executable products)
        .library(
            name: "FluidAudio",
            targets: ["FluidAudio"]
        )
    ],
    dependencies: [],
    targets: [
        // Keep ESpeakNG as a binary target (local path),
        // but we'll only link it on iOS/macOS (see conditional dep below).
        .binaryTarget(
            name: "ESpeakNG",
            path: "Sources/FluidAudio/Frameworks/ESpeakNG.xcframework"
        ),

        // Core library. ESpeakNG is NOT linked on visionOS.
        .target(
            name: "FluidAudio",
            dependencies: [
                .target(name: "ESpeakNG", condition: .when(platforms: [.iOS, .macOS]))
            ],
            path: "Sources/FluidAudio",
            exclude: []
        ),

        // Unit tests (safe to keep)
        .testTarget(
            name: "FluidAudioTests",
            dependencies: ["FluidAudio"]
        )
    ]
)