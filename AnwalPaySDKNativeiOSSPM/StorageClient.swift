import Foundation

enum StorageClient {
    private static let defaults = UserDefaults.standard
    private static let customerIdKey = "customer_id"

    static func saveCustomerId(_ customerId: String?) {
        if let customerId {
            defaults.set(customerId, forKey: customerIdKey)
        } else {
            defaults.removeObject(forKey: customerIdKey)
        }
    }

    static func getCustomerId() -> String? {
        defaults.string(forKey: customerIdKey)
    }

    static func removeCustomerId() {
        defaults.removeObject(forKey: customerIdKey)
    }
}

