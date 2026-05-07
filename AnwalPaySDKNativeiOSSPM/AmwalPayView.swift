import SwiftUI
import amwalsdk

struct AmwalPayView<Content: View>: View {
    @Binding var isPresented: Bool
    let config: Config?
    let onDismiss: () -> Void
    let onCustomerId: (String) -> Void
    @ViewBuilder let content: () -> Content

    var body: some View {
        content()
            .fullScreenCover(isPresented: $isPresented, onDismiss: onDismiss) {
                if let config = config {
                    SDKControllerWrapper(
                        config: config,
                        onResponse: { _ in isPresented = false },
                        onCustomerId: onCustomerId
                    )
                    .ignoresSafeArea()
                }
            }
    }
}

private struct SDKControllerWrapper: UIViewControllerRepresentable {
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
