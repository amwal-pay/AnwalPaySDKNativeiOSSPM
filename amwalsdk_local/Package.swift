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
            path: "amwalsdk",
            exclude: ["amwalsdk.docc", "Readme.md", "amwalsdk.h", "Flutter"]
        ),
        .binaryTarget(name: "App",                          path: "Frameworks/App.xcframework"),
        .binaryTarget(name: "Flutter",                      path: "Frameworks/Flutter.xcframework"),
        .binaryTarget(name: "FlutterPluginRegistrant",      path: "Frameworks/FlutterPluginRegistrant.xcframework"),
        .binaryTarget(name: "amwal_pay_sdk",                path: "Frameworks/amwal_pay_sdk.xcframework"),
        .binaryTarget(name: "path_provider_foundation",     path: "Frameworks/path_provider_foundation.xcframework"),
        .binaryTarget(name: "pay_ios",                      path: "Frameworks/pay_ios.xcframework"),
        .binaryTarget(name: "share_plus",                   path: "Frameworks/share_plus.xcframework"),
        .binaryTarget(name: "shared_preferences_foundation",path: "Frameworks/shared_preferences_foundation.xcframework"),
        .binaryTarget(name: "webview_flutter_wkwebview",    path: "Frameworks/webview_flutter_wkwebview.xcframework"),
    ]
)
