import SwiftUI
import amwalsdk

struct ContentView: View {
    @State private var isShowingPayment = false
    @State private var paymentResult: String?

    private let config = Config(
        environment: .UAT,
        sessionToken: "your-session-token-here",
        currency: .OMR,
        amount: "1.000",
        merchantId: "your-merchant-id",
        terminalId: "your-terminal-id",
        locale: .en,
        isSoftPOS: false
    )

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Image(systemName: "creditcard.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)

                Text("Amwal Pay SDK")
                    .font(.largeTitle.bold())

                Text("SPM Integration Example")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Divider()

                VStack(alignment: .leading, spacing: 10) {
                    Label("Environment: UAT", systemImage: "server.rack")
                    Label("Amount: 1.000 OMR", systemImage: "dollarsign.circle")
                    Label("Locale: English", systemImage: "globe")
                }
                .font(.callout)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                Spacer()

                if let result = paymentResult {
                    HStack {
                        Image(systemName: result.lowercased().contains("error") ? "xmark.circle.fill" : "checkmark.circle.fill")
                            .foregroundColor(result.lowercased().contains("error") ? .red : .green)
                        Text(result)
                            .font(.callout)
                    }
                    .padding()
                    .background(
                        (result.lowercased().contains("error") ? Color.red : Color.green).opacity(0.1)
                    )
                    .cornerRadius(10)
                }

                Button {
                    isShowingPayment = true
                } label: {
                    Label("Start Payment", systemImage: "arrow.right.circle.fill")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .font(.headline)
                }
            }
            .padding()
            .navigationTitle("Amwal Pay")
        }
        .fullScreenCover(isPresented: $isShowingPayment) {
            PaymentView(config: config) { result in
                paymentResult = result ?? "Payment dismissed"
                isShowingPayment = false
            }
        }
    }
}

struct PaymentView: UIViewControllerRepresentable {
    let config: Config
    let onResult: (String?) -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        let sdk = AmwalSDK()
        do {
            return try sdk.createViewController(
                config: config,
                onResponse: { response in onResult(response) },
                onCustomerId: { id in print("Customer ID: \(id)") }
            )
        } catch {
            let vc = UIViewController()
            vc.view.backgroundColor = .systemBackground
            return vc
        }
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

#Preview {
    ContentView()
}
