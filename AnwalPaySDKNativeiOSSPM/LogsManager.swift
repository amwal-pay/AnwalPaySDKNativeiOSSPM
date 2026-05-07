import Foundation
import SwiftUI

final class LogsManager: ObservableObject {
    static let shared = LogsManager()

    @Published var logs: [LogEntry] = []

    private init() {}

    func addLog(_ message: String, type: LogType) {
        let entry = LogEntry(message: message, type: type, timestamp: Date())
        DispatchQueue.main.async {
            self.logs.append(entry)
        }
    }

    func clearLogs() {
        DispatchQueue.main.async {
            self.logs.removeAll()
        }
    }
}

enum LogType: CaseIterable {
    case response
    case cancelled
    case customerId
    case error
    case info
    case debug

    var displayName: String {
        switch self {
        case .response: return "Response"
        case .cancelled: return "Cancelled"
        case .customerId: return "Customer ID"
        case .error: return "Error"
        case .info: return "Info"
        case .debug: return "Debug"
        }
    }

    var icon: String {
        switch self {
        case .response: return "checkmark.circle"
        case .cancelled: return "xmark.circle"
        case .customerId: return "person.circle"
        case .error: return "exclamationmark.triangle"
        case .info: return "info.circle"
        case .debug: return "ladybug"
        }
    }

    var color: Color {
        switch self {
        case .response: return .green
        case .cancelled: return .orange
        case .customerId: return .blue
        case .error: return .red
        case .info: return .blue
        case .debug: return .gray
        }
    }
}

struct LogEntry: Identifiable {
    let id = UUID()
    let message: String
    let type: LogType
    let timestamp: Date

    var formattedTimestamp: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter.string(from: timestamp)
    }
}

