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
            checksum: "bc59671c9cbe7d6619d3ffd6d5a21dd7228b1c9e92bc949ea435075856baf337"
        ),
        .binaryTarget(
            name: "Flutter",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/1.1.91/Flutter.zip",
            checksum: "170dbad74ddee6347375442a596f6feb0f824fa32741411603dd21f91945bc60"
        ),
        .binaryTarget(
            name: "FlutterPluginRegistrant",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/1.1.91/FlutterPluginRegistrant.zip",
            checksum: "8c01adeac3eae7635053dea6913649ce51e9fbadbe24ee745e7461c8f40566b4"
        ),
        .binaryTarget(
            name: "amwal_pay_sdk",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/1.1.91/amwal_pay_sdk.zip",
            checksum: "28c90e6c61a53f6e5418dd937ea6a366c30f1504f4c0270e2ed20eead473bc77"
        ),
        .binaryTarget(
            name: "path_provider_foundation",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/1.1.91/path_provider_foundation.zip",
            checksum: "8e2ca18a47c773f902b174bde4c08676ebe7e50e456d9c98ed6456a41841e802"
        ),
        .binaryTarget(
            name: "pay_ios",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/1.1.91/pay_ios.zip",
            checksum: "3b1417e1c080d385a8f35c32327415022ab36970e6e2556081bbf27eb734b74d"
        ),
        .binaryTarget(
            name: "share_plus",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/1.1.91/share_plus.zip",
            checksum: "3c482e4d385fe48b790a2d418ff28ea28bee609b1d6dd24a142676a56cf0bafe"
        ),
        .binaryTarget(
            name: "shared_preferences_foundation",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/1.1.91/shared_preferences_foundation.zip",
            checksum: "83c9ae12a40bbd7135ddf60ab13b55d46171259e55dbcc25493d84550233f4ae"
        ),
        .binaryTarget(
            name: "webview_flutter_wkwebview",
            url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM/releases/download/1.1.91/webview_flutter_wkwebview.zip",
            checksum: "adf5bf38c2b057f441095347bb21d9a4e14a2e80433687c1e4e19203888353e5"
        ),
    ]
)
