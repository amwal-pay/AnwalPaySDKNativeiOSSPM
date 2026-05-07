// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "amwalsdk",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(name: "amwalsdk", targets: ["amwalsdk"]),
    ],
    targets: [
        .binaryTarget(
            name: "amwalsdk",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/amwalsdk-spm-1.1.88/amwalsdk-spm.zip",
            checksum: "f70bdb85777962782b34076ccfd16016798cab9d773a0b346a8169b745b269e5"
        ),
    ]
)

