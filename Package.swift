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
            dependencies: ["amwal_pay_sdk", "App", "Flutter", "FlutterPluginRegistrant", "pay_ios", "share_plus", "shared_preferences_foundation", "webview_flutter_wkwebview"],
            path: "amwalsdk_local/amwalsdk",
            exclude: ["amwalsdk.docc", "Readme.md", "amwalsdk.h", "Flutter"]
        ),
        .binaryTarget(
            name: "amwal_pay_sdk",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/v1.1.91/amwal_pay_sdk.zip",
            checksum: "78833d8e885f09f8eb66b85b60aaa713850095d797e423dc5b945ff11d75a478"
        ),
        .binaryTarget(
            name: "App",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/v1.1.91/App.zip",
            checksum: "18a7f95e41f0197072efde15a227748441f9aec5a2bb292089f66239d948a63d"
        ),
        .binaryTarget(
            name: "Flutter",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/v1.1.91/Flutter.zip",
            checksum: "b970079c5b3d2d02d972b70507c31dad80d163178881fca0e6c684a49ecdca02"
        ),
        .binaryTarget(
            name: "FlutterPluginRegistrant",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/v1.1.91/FlutterPluginRegistrant.zip",
            checksum: "bbdcfa0a66ff5b7682e5c646d0c772991c1c714f74bde365ac6ce6ef9f502a61"
        ),
        .binaryTarget(
            name: "pay_ios",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/v1.1.91/pay_ios.zip",
            checksum: "16345fa712448365bf2570cd621dd3e45bb6d642a92007dad0c4fa7fd03eaf44"
        ),
        .binaryTarget(
            name: "share_plus",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/v1.1.91/share_plus.zip",
            checksum: "ea0978f3d650c98bcc2d3a9363da426aa58e6bb7c318adca07856106d8286f3e"
        ),
        .binaryTarget(
            name: "shared_preferences_foundation",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/v1.1.91/shared_preferences_foundation.zip",
            checksum: "149cf147f7157355f79c59653d86910e03a73d78bdd34929a0000f3de35ff338"
        ),
        .binaryTarget(
            name: "webview_flutter_wkwebview",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/v1.1.91/webview_flutter_wkwebview.zip",
            checksum: "7f587029b07ce78fc8331d35f6c8686c20dd72b59152dc00e79082732b446127"
        ),
    ]
)
