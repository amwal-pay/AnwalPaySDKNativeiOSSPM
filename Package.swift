// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "amwalsdk",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "amwalsdk",
            targets: ["amwalsdk"]
        )
    ],
    targets: [
        .target(
            name: "amwalsdk",
            dependencies: [
                "App", "Flutter", "FlutterPluginRegistrant",
                "amwal_pay_sdk", "path_provider_foundation", "pay_ios",
                "share_plus", "shared_preferences_foundation", "webview_flutter_wkwebview"
            ],
            path: "amwalsdk_local/amwalsdk",
            exclude: ["amwalsdk.docc", "Readme.md", "amwalsdk.h", "Flutter"]
        ),
        .binaryTarget(
            name: "App",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/1.1.91/App.zip",
            checksum: "a536e37b2f62fd0f0db4cc51aa21fed18bb0c31823168c7a6b0e30f57c45b649"
        ),
        .binaryTarget(
            name: "Flutter",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/1.1.91/Flutter.zip",
            checksum: "b15fac3ed3116be1d319aecee9aea9861bf18da1c87626760afd125c5180c711"
        ),
        .binaryTarget(
            name: "FlutterPluginRegistrant",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/1.1.91/FlutterPluginRegistrant.zip",
            checksum: "bbc62aa180f00e94dff4fa16a021ec72b32840ba13485e7281abd4b95f5ac03e"
        ),
        .binaryTarget(
            name: "amwal_pay_sdk",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/1.1.91/amwal_pay_sdk.zip",
            checksum: "04d6878863b6fd340dd046c4e48e477e3d3d63f98a8b5d81e784eaebedf70640"
        ),
        .binaryTarget(
            name: "path_provider_foundation",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/1.1.91/path_provider_foundation.zip",
            checksum: "22818154a2dbc3d927b59e8096476edd95b0dfa873ab2a58f85cccfba10fd4ec"
        ),
        .binaryTarget(
            name: "pay_ios",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/1.1.91/pay_ios.zip",
            checksum: "75ba0f4a6b419dfbcbb5f6d01e2a5315cfbcad0d938e54218469d8ea193f64b8"
        ),
        .binaryTarget(
            name: "share_plus",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/1.1.91/share_plus.zip",
            checksum: "6dfb358a40267ce7795cac3f9288f4ec4dde4afa78887fc930c39db908a46a29"
        ),
        .binaryTarget(
            name: "shared_preferences_foundation",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/1.1.91/shared_preferences_foundation.zip",
            checksum: "51e73ba2bf6f4a84a6dd0e5b3d57a9ec770d32e5d15816e013dba23c08cdfec8"
        ),
        .binaryTarget(
            name: "webview_flutter_wkwebview",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/1.1.91/webview_flutter_wkwebview.zip",
            checksum: "a479523a1dc5b970fd2397700a2cb49eb95dca3f4df60b30a2b39e2e41789252"
        ),
    ]
)
