import Foundation
import UIKit
import amwalsdk

final class NetworkClient {
    private var urlSession = URLSession.shared

    func fetchSessionToken(
        env: Config.Environment,
        merchantId: String,
        customerId: String?,
        secureHashValue: String,
        completion: @escaping (String?) -> Void
    ) {
        let webhookUrl: String
        switch env {
        case .SIT:
            webhookUrl = "https://test.amwalpg.com:24443/"
        case .UAT:
            webhookUrl = "https://test.amwalpg.com:14443/"
        case .PROD:
            webhookUrl = "https://webhook.amwalpg.com/"
        }

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                var dataMap: [String: Any?] = [
                    "merchantId": merchantId,
                    "customerId": customerId,
                ]

                let secureHash = SecureHashUtil.clearSecureHash(secretKey: secureHashValue, data: &dataMap)

                var jsonBody: [String: Any] = [
                    "merchantId": merchantId,
                    "secureHashValue": secureHash,
                ]
                if let customerId {
                    jsonBody["customerId"] = customerId
                }

                guard let url = URL(string: "\(webhookUrl)Membership/GetSDKSessionToken") else {
                    DispatchQueue.main.async {
                        self.showErrorDialog(message: "Invalid URL")
                        completion(nil)
                    }
                    return
                }

                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("text/plain", forHTTPHeaderField: "accept")
                request.addValue("en-US,en;q=0.9", forHTTPHeaderField: "accept-language")
                request.addValue("application/json", forHTTPHeaderField: "content-type")

                let jsonData = try JSONSerialization.data(withJSONObject: jsonBody, options: .prettyPrinted)
                request.httpBody = jsonData

                let task = self.urlSession.dataTask(with: request) { data, _, error in
                    if let error {
                        DispatchQueue.main.async {
                            self.showErrorDialog(message: "Something Went Wrong")
                            completion(nil)
                        }
                        print("Error: \(error.localizedDescription)")
                        return
                    }

                    guard
                        let data,
                        let response = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                    else {
                        DispatchQueue.main.async {
                            self.showErrorDialog(message: "Invalid response")
                            completion(nil)
                        }
                        return
                    }

                    if let success = response["success"] as? Bool, success,
                       let data = response["data"] as? [String: Any],
                       let sessionToken = data["sessionToken"] as? String
                    {
                        DispatchQueue.main.async { completion(sessionToken) }
                    } else {
                        let errorMessage = (response["errorList"] as? [String])?.joined(separator: ",") ?? "Unknown error"
                        DispatchQueue.main.async {
                            self.showErrorDialog(message: errorMessage)
                            completion(nil)
                        }
                    }
                }

                task.resume()
            } catch {
                DispatchQueue.main.async {
                    self.showErrorDialog(message: "Something Went Wrong")
                    completion(nil)
                }
            }
        }
    }

    private func showErrorDialog(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))

            let scene = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .first(where: { $0.activationState == .foregroundActive })

            let root = scene?.windows.first(where: { $0.isKeyWindow })?.rootViewController
            let top = root?.topMostViewController() ?? root
            top?.present(alert, animated: true)
        }
    }
}

private extension UIViewController {
    func topMostViewController() -> UIViewController {
        if let presented = presentedViewController {
            return presented.topMostViewController()
        }
        if let nav = self as? UINavigationController, let visible = nav.visibleViewController {
            return visible.topMostViewController()
        }
        if let tab = self as? UITabBarController, let selected = tab.selectedViewController {
            return selected.topMostViewController()
        }
        return self
    }
}

