//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

/// ``LogWriter`` that logs messages by appending them to a file
/// - parameter path: File path to write messages
public struct FileLogWriter: LogWriter {
    let path: URL

    /// Implement
    public func logMessage(_ message: String, level: LogLevel, file: StaticString, line: UInt) {
        let formatted = format(message, level: level, file: file, line: line)

        OutputStream(url: path, append: true)?.use { stream in
            do {
                try stream.write(formatted).write("\n\r")
            } catch {
                print("An error occured writing to url: \(path)")
            }
        }
    }
}
