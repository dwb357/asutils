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
    nonisolated(unsafe) static let simple = Self { message, level, category, _, _, _ in
        let category = category.map { "[\($0)]" } ?? ""

        return "\(timeStamp) \(level): \(category)\(message)"
    }

    /// Format log messages with level, category, message, and function name
    nonisolated(unsafe) static let medium = Self { message, level, category, _, fun, _ in
        let category = category.map { "[\($0)]" } ?? ""
        let fun = fun.withoutParameters

        return "\(timeStamp) \(level): \(category) \(fun): \(message)"
    }

    /// Format log messages with level, category, message, function name, and file location
    nonisolated(unsafe) static let full = Self { message, level, category, file, fun, line in
        let category = category.map { "[\($0)]" } ?? ""
        let file = file.lastPathComponent
        let fun = fun.withoutParameters

        return "\(timeStamp) \(level): \(category) [\(file):\(line)]: \(fun): \(message)"
    }

    private let format: (
        _ message: String,
        _ level: LogLevel,
        _ category: String?,
        _ file: StaticString,
        _ fun: StaticString,
        _ line: UInt
    ) -> String

    /// Format a message to be written to the logger.
    /// - parameters:
    ///     - message: message to log
    ///     - level: `LogLevel` for this message
    ///     - category: category for this message
    ///     - file: file where message was generated
    ///     - line: line where message was generated
    /// - returns: Formatted message to log
    func callAsFunction( // swiftlint:disable:this function_parameter_count
        _ message: String,
        level: LogLevel,
        category: String?,
        file: StaticString,
        fun: StaticString,
        line: UInt
    ) -> String {
        format(message, level, category, file, fun, line)
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
