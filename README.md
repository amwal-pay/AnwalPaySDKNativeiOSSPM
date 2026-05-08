# Amwal Pay SDK — iOS (Swift Package Manager)

Accept payments in your native iOS app with a single view controller. The SDK handles the entire payment flow via an embedded Flutter engine.

## Requirements

- iOS 14.0+
- Xcode 14+
- Swift 5.7+

## Installation

### Xcode (recommended)

1. Open your project in Xcode.
2. Go to **File → Add Package Dependencies…**
3. Enter the repository URL:
   ```
   https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM
   ```
4. Select **Exact Version** `1.1.91` (or the latest tag).
5. Add **amwalsdk** to your app target.

### Package.swift

```swift
dependencies: [
    .package(
        url: "https://github.com/amwal-pay/AnwalPaySDKNativeiOSSPM",
        exact: "1.1.91"
    )
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "amwalsdk", package: "AnwalPaySDKNativeiOSSPM")
        ]
    )
]
```

## Quick Start

### 1. Build a `Config`

```swift
import amwalsdk

let config = Config(
    environment: .UAT,          // .UAT | .SIT | .PROD
    sessionToken: "your-session-token",
    currency: .OMR,
    amount: "1.000",            // decimal string, e.g. "10.500"
    merchantId: "your-merchant-id",
    terminalId: "your-terminal-id",
    customerId: nil,            // optional, pass to link the transaction to a customer
    locale: .en,                // .en | .ar
    isSoftPOS: false
)
```

### 2. SwiftUI

The SDK ships a ready-made `AmwalPayView` modifier pattern. Use `AmwalSDK` directly inside a `UIViewControllerRepresentable`, or adopt the pattern from the example app:

```swift
import SwiftUI
import amwalsdk

struct CheckoutView: View {
    @State private var showPayment = false
    @State private var paymentResult: String?

    var body: some View {
        VStack {
            Button("Pay Now") { showPayment = true }
        }
        .fullScreenCover(isPresented: $showPayment) {
            PaymentControllerWrapper(
                config: config,
                onResponse: { result in
                    paymentResult = result
                    showPayment = false
                },
                onCustomerId: { customerId in
                    // store customerId if needed
                }
            )
            .ignoresSafeArea()
        }
    }
}

// Thin UIViewControllerRepresentable bridge
private struct PaymentControllerWrapper: UIViewControllerRepresentable {
    let config: Config
    let onResponse: (String?) -> Void
    let onCustomerId: (String) -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        (try? AmwalSDK().createViewController(
            config: config,
            onResponse: onResponse,
            onCustomerId: onCustomerId
        )) ?? UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
```

### 3. UIKit

```swift
import UIKit
import amwalsdk

class CheckoutViewController: UIViewController {

    private let sdk = AmwalSDK()

    func startPayment() {
        let config = Config(
            environment: .PROD,
            sessionToken: "your-session-token",
            currency: .OMR,
            amount: "5.000",
            merchantId: "your-merchant-id",
            terminalId: "your-terminal-id",
            locale: .en,
            isSoftPOS: false
        )

        guard let paymentVC = try? sdk.createViewController(
            config: config,
            onResponse: { [weak self] result in
                // result is the raw JSON string from the payment gateway
                self?.dismiss(animated: true)
                self?.handleResult(result)
            },
            onCustomerId: { customerId in
                // called when the SDK resolves a customer ID
                print("Customer ID:", customerId)
            }
        ) else { return }

        present(paymentVC, animated: true)
    }

    private func handleResult(_ result: String?) {
        print("Payment result:", result ?? "dismissed")
    }
}
```

## Config Reference

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `environment` | `Environment` | ✓ | `.UAT`, `.SIT`, or `.PROD` |
| `sessionToken` | `String` | ✓ | Session token issued by your backend |
| `currency` | `Currency` | ✓ | `.OMR` (Omani Rial) |
| `amount` | `String` | ✓ | Payment amount as a decimal string, e.g. `"1.500"` |
| `merchantId` | `String` | ✓ | Your merchant ID |
| `terminalId` | `String` | ✓ | Your terminal ID |
| `customerId` | `String?` | — | Optional customer identifier |
| `locale` | `Locale` | ✓ | `.en` (English) or `.ar` (Arabic) |
| `isSoftPOS` | `Bool` | ✓ | `true` for SoftPOS terminals, `false` for regular |

## Callbacks

| Callback | When it fires | Argument |
|----------|--------------|----------|
| `onResponse` | Payment completes or is dismissed | JSON result string, or `nil` on dismiss |
| `onCustomerId` | SDK resolves a customer ID during the session | Customer ID string |

## Environments

| Value | Use for |
|-------|---------|
| `.UAT` | Development and QA testing |
| `.SIT` | System integration testing |
| `.PROD` | Live production payments |

Always use `.UAT` or `.SIT` during development. Switch to `.PROD` only in your App Store build.

## Example App

The `AnwalPaySDKNativeiOSSPM` Xcode project in this repository is a fully working example app. Open `AnwalPaySDKNativeiOSSPM.xcodeproj`, fill in your credentials in `ContentView.swift`, and run it on a simulator or device.

## Support

For integration help or to report issues, contact [support@amwal-pay.com](mailto:support@amwal-pay.com).
