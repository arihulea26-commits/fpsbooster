// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "PerfBooster",
    platforms: [.iOS(.v15)],
    products: [
        .executable(name: "PerfBooster", targets: ["PerfBooster"])
    ],
    targets: [
        .executableTarget(
            name: "PerfBooster",
            path: "Sources"
        )
    ]
)
