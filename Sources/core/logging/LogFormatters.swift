//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

/// `LogFormatter` definitions with varying levels of detail
public enum LogFormatters {
    /// Generate an internally consistent time stamp
    private static var timeStamp: String {
        dateFormatter.string(from: Date())
    }

    /// Formatter instance used to format ``timeStamp``
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm:ss dd.MM.yyyy"

        return formatter
    }()

    /// Default LogFormatter
    public static let `default` = Self.medium

    /// Format log messages with just the level, category, and message
    static func simple( // swiftlint:disable:this function_parameter_count
        message: String,
        level: LogLevel,
        category: String?,
        file _: StaticString,
        fun _: StaticString,
        line _: UInt
    ) -> String {
        let category = category.map { "[\($0)]" } ?? ""

        return "\(timeStamp) \(level): \(category)\(message)"
    }

    /// Format log messages with level, category, message, and function name
    static func medium( // swiftlint:disable:this function_parameter_count
        message: String,
        level: LogLevel,
        category: String?,
        file _: StaticString,
        fun: StaticString,
        line _: UInt
    ) -> String {
        let category = category.map { "[\($0)]" } ?? ""
        let fun = fun.withoutParameters

        return "\(timeStamp) \(level): \(category) \(fun): \(message)"
    }

    /// Format log messages with level, category, message, function name, and file location
    static func full( // swiftlint:disable:this function_parameter_count
        message: String,
        level: LogLevel,
        category: String?,
        file: StaticString,
        fun: StaticString,
        line: UInt
    ) -> String {
        let category = category.map { "[\($0)]" } ?? ""
        let file = file.lastPathComponent
        let fun = fun.withoutParameters

        return "\(timeStamp) \(level): \(category) [\(file):\(line)]: \(fun): \(message)"
    }
}

private extension StaticString {
    var lastPathComponent: String {
        guard let url = URL(string: self.description) else {
            LogManager
                .error(
                    "lastPathComponent failed: could not init URL from string - \(self)",
                    category: "LOGGER"
                )
            return self.description
        }

        return url.lastPathComponent
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
