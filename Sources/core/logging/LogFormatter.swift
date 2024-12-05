//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

/// A function that formats log messages
public struct LogFormatter {
    /// Formatter instance used to format ``timeStamp``
    private static let logDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm:ss dd.MM.yyyy"

        return formatter
    }()

    /// Generate an internally consistent time stamp
    private static var timeStamp: String {
        logDateFormatter.string(from: Date.provided)
    }

    /// Default formatter to use
    nonisolated(unsafe) public static var `default` = Self.medium

    /// Format log messages with just the level, category, and message
    nonisolated(unsafe) static let simple = Self { record in
        let category = record.category.map { "[\($0)] " } ?? ""

        return "\(record.level): \(category)\(record.message)"
    }

    /// Format log messages with level, category, message, and function name
    nonisolated(unsafe) static let medium = Self { record in
        let category = record.category.map { "[\($0)] " } ?? ""

        return "\(timeStamp) \(record.level): \(category)\(record.message)"
    }

    /// Format log messages with level, category, message, function name, and file location
    nonisolated(unsafe) static let full = Self { record in
        let category = record.category.map { "[\($0)] " } ?? ""

        return "\(timeStamp) \(record.level): \(category) \(record.file):\(record.line): \(record.message)"
    }

    let formatter: (_ record: LogRecord) -> String

    /// Format a message to be written to the logger.
    /// - parameters:
    ///     - record: message details to log
    /// - returns: updated ``LogRecord`` to log
    func callAsFunction(record: LogRecord) -> LogRecord {
        record.copy(formatted: formatter(record))
    }
}

private extension StaticString {
    var lastPathComponent: String {
        let string = self.description

        return string.split(separator: "/").last.map(String.init) ?? string
    }

    var withoutParameters: String {
        var text = self.description

        guard let lhs = text.firstIndex(of: "("), let rhs = text.lastIndex(of: ")") else {
            return text
        }

        text.removeSubrange(text.index(after: lhs)..<rhs)

        return String(text)
    }
}
