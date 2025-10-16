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
        ),
        .executable(
            name: "fluidaudio",
            targets: ["FluidAudioCLI"]
        ),
    ],
    dependencies: [],
    targets: [
        // ESpeakNG can stay as a binaryTarget (local path).
        // We just won't *depend* on it for visionOS builds.
        .binaryTarget(
            name: "ESpeakNG",
            path: "Sources/FluidAudio/Frameworks/ESpeakNG.xcframework"
        ),
        .target(
            name: "FluidAudio",
            dependencies: [
                // ✅ Link ESpeakNG only on iOS/macOS. Excluded on visionOS so Vision Pro builds succeed.
                .target(name: "ESpeakNG", condition: .when(platforms: [.iOS, .macOS]))
            ],
            path: "Sources/FluidAudio",
            exclude: []
        ),
        .executableTarget(
            name: "FluidAudioCLI",
            dependencies: ["FluidAudio"],
            path: "Sources/FluidAudioCLI",
            exclude: ["README.md"],
            resources: [
                .process("Utils/english.json")
            ]
        ),
        .testTarget(
            name: "FluidAudioTests",
            dependencies: ["FluidAudio"]
        ),
    ]
)