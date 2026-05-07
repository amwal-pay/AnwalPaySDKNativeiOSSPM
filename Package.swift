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
        .binaryTarget(name: "App",                          path: "amwalsdk_local/Frameworks/App.xcframework"),
        .binaryTarget(name: "Flutter",                      path: "amwalsdk_local/Frameworks/Flutter.xcframework"),
        .binaryTarget(name: "FlutterPluginRegistrant",      path: "amwalsdk_local/Frameworks/FlutterPluginRegistrant.xcframework"),
        .binaryTarget(name: "amwal_pay_sdk",                path: "amwalsdk_local/Frameworks/amwal_pay_sdk.xcframework"),
        .binaryTarget(name: "path_provider_foundation",     path: "amwalsdk_local/Frameworks/path_provider_foundation.xcframework"),
        .binaryTarget(name: "pay_ios",                      path: "amwalsdk_local/Frameworks/pay_ios.xcframework"),
        .binaryTarget(name: "share_plus",                   path: "amwalsdk_local/Frameworks/share_plus.xcframework"),
        .binaryTarget(name: "shared_preferences_foundation",path: "amwalsdk_local/Frameworks/shared_preferences_foundation.xcframework"),
        .binaryTarget(name: "webview_flutter_wkwebview",    path: "amwalsdk_local/Frameworks/webview_flutter_wkwebview.xcframework"),
    ]
)

