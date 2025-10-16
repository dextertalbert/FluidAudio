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
        .library(
            name: "FluidAudio",
            targets: ["FluidAudio"]
        )
    ],
    dependencies: [],
    targets: [
        // No ESpeakNG at all — visionOS won’t try to resolve a missing xcframework.
        .target(
            name: "FluidAudio",
            dependencies: [],
            path: "Sources/FluidAudio",
            exclude: []
        ),
        .testTarget(
            name: "FluidAudioTests",
            dependencies: ["FluidAudio"]
        )
    ]
)