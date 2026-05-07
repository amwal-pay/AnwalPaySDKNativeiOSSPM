import SwiftUI
import amwalsdk

@main
struct AmwalPayApp: App {
    private let networkClient = NetworkClient()
    @State private var config: Config?
    @State private var showSDK = false

    var body: some Scene {
        WindowGroup {
            AmwalPayView(
                isPresented: $showSDK,
                config: config,
                onDismiss: {
                    showSDK = false
                    config = nil
                    LogsManager.shared.addLog("SDK dismissed", type: .info)
                },
                onCustomerId: { customerId in
                    StorageClient.saveCustomerId(customerId)
                    LogsManager.shared.addLog("Customer ID received: \(customerId)", type: .customerId)
                }
            ) {
                NavigationStack {
                    FormView(onSubmit: { viewModel in
                        startSdk(viewModel: viewModel)
                    })
                }
            }
        }
    }

    private func startSdk(viewModel: PaymentFormViewModel) {
        LogsManager.shared.addLog("Starting SDK initialization", type: .info)

        let storedCustomerId = StorageClient.getCustomerId()
        LogsManager.shared.addLog("Getting session token for merchant: \(viewModel.merchantId)", type: .info)

        networkClient.fetchSessionToken(
            env: viewModel.selectedEnv,
            merchantId: viewModel.merchantId,
            customerId: storedCustomerId,
            secureHashValue: viewModel.secureHash
        ) { sessionToken in
            guard let token = sessionToken else {
                LogsManager.shared.addLog("Failed to fetch session token", type: .error)
                return
            }

            LogsManager.shared.addLog("Session token received, initializing SDK", type: .info)

            config = Config(
                environment: viewModel.selectedEnv,
                sessionToken: token,
                currency: viewModel.currency,
                amount: viewModel.amount,
                merchantId: viewModel.merchantId,
                terminalId: viewModel.terminalId,
                customerId: storedCustomerId,
                locale: viewModel.language,
                isSoftPOS: false
            )
            showSDK = true
        }
    }
}
