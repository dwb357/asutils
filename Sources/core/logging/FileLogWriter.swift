//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

/// ``LogWriter`` that logs messages by appending them to a file
/// - parameter path: File path to write messages
public struct FileLogWriter: LogWriter {
    let path: URL
    let format: LogFormatter

    init(path: URL, format: LogFormatter = .default) {
        self.path = path
        self.format = format
    }

    /// Implement
    public func log( // swiftlint:disable:this function_parameter_count
        _ message: String,
        level: LogLevel,
        category: String?,
        file: StaticString,
        fun: StaticString,
        line: UInt
    ) {
        let formatted = format(
            message,
            level: level,
            category: category,
            file: file,
            fun: fun,
            line: line
        )

        try? OutputStream(url: path, append: true)?.use { stream in
            do {
                try stream.write(formatted).write("\n\r")
            } catch {
                print("An error occured writing to url: \(path)")
            }
        }
    }
}
