import Foundation
import CommonCrypto

enum SecureHashUtil {
    static func clearSecureHash(secretKey: String, data: inout [String: Any?]) -> String {
        data.removeValue(forKey: "secureHashValue")
        let concatenatedString = composeData(requestParameters: data)
        return generateSecureHash(message: concatenatedString, secretKey: secretKey)
    }

    private static func composeData(requestParameters: [String: Any?]) -> String {
        guard !requestParameters.isEmpty else { return "" }

        let sortedParameters = requestParameters
            .filter { $0.value != nil }
            .sorted { $0.key < $1.key }

        return sortedParameters
            .map { "\($0.key)=\($0.value!)" }
            .joined(separator: "&")
    }

    private static func generateSecureHash(message: String, secretKey: String) -> String {
        guard let keyData = secretKey.hexToBytes() else { return "" }
        guard let messageData = message.data(using: .utf8) else { return "" }

        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        keyData.withUnsafeBytes { keyBytes in
            messageData.withUnsafeBytes { messageBytes in
                CCHmac(
                    CCHmacAlgorithm(kCCHmacAlgSHA256),
                    keyBytes.baseAddress,
                    keyBytes.count,
                    messageBytes.baseAddress,
                    messageBytes.count,
                    &digest
                )
            }
        }

        return digest.map { String(format: "%02x", $0) }.joined().uppercased()
    }
}

extension String {
    func hexToBytes() -> [UInt8]? {
        var hex = self
        if hex.count % 2 != 0 { hex = "0" + hex }

        var bytes = [UInt8]()
        var index = hex.startIndex
        while index < hex.endIndex {
            let nextIndex = hex.index(index, offsetBy: 2)
            if let byte = UInt8(hex[index..<nextIndex], radix: 16) {
                bytes.append(byte)
            } else {
                return nil
            }
            index = nextIndex
        }
        return bytes
    }
}

