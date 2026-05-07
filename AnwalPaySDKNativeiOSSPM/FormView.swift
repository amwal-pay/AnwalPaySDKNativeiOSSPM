import SwiftUI
import amwalsdk

struct FormView: View {
    var onSubmit: (PaymentFormViewModel) -> Void

    @StateObject private var viewModel = PaymentFormViewModel()
    @State private var showLogsViewer = false

    var body: some View {
        VStack {
            HStack {
                Text("Amwal Pay Demo")
                    .font(.title)
                Spacer()
                Button {
                    showLogsViewer = true
                } label: {
                    Image(systemName: "ladybug")
                        .foregroundColor(.blue)
                }
                Button {
                    StorageClient.removeCustomerId()
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
            .padding()

            ScrollView {
                VStack(spacing: 16) {
                    CustomTextField(label: "Merchant Id", text: $viewModel.merchantId)
                    CustomTextField(label: "Terminal Id", text: $viewModel.terminalId)
                    CustomTextField(label: "Amount", text: $viewModel.amount)
                    CustomTextField(label: "Secret Key", text: $viewModel.secureHash)
                    CustomTextField(label: "Merchant Reference (Optional)", text: $viewModel.merchantReference)

                    CustomDropdown(
                        title: "Currency",
                        options: Config.Currency.allCases.map { $0.rawValue },
                        selectedValue: viewModel.currency.rawValue,
                        onValueChange: { newValue in
                            viewModel.currency = Config.Currency(rawValue: newValue) ?? .OMR
                        }
                    )

                    CustomDropdown(
                        title: "Language",
                        options: Config.Locale.allCases.map { $0.rawValue },
                        selectedValue: viewModel.language.rawValue,
                        onValueChange: { newValue in
                            viewModel.language = Config.Locale(rawValue: newValue) ?? .en
                        }
                    )

                    CustomDropdown(
                        title: "Environment",
                        options: Config.Environment.allCases.map { $0.rawValue },
                        selectedValue: viewModel.selectedEnv.rawValue,
                        onValueChange: { newValue in
                            viewModel.selectedEnv = Config.Environment(rawValue: newValue) ?? .UAT
                        }
                    )

                    Spacer(minLength: 16)

                    Button {
                        onSubmit(viewModel)
                    } label: {
                        Text("Initiate Payment Demo")
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
                .navigationTitle("Payment Form")
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $showLogsViewer) {
            LogsViewer()
        }
    }
}

struct CustomTextField: View {
    var label: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
            TextField("Enter \(label)", text: $text)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.gray, lineWidth: 1))
                .padding(.bottom, 8)
        }
    }
}

struct CustomDropdown: View {
    var title: String
    var options: [String]
    var selectedValue: String
    var onValueChange: (String) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            Picker(title, selection: Binding(
                get: { selectedValue },
                set: { onValueChange($0) }
            )) {
                ForEach(options, id: \.self) { Text($0).tag($0) }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .pickerStyle(MenuPickerStyle())
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.gray, lineWidth: 1))
            .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NavigationStack {
        FormView(onSubmit: { _ in })
    }
}
