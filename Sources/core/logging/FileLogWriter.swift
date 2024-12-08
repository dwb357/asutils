//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

/// ``LogWriter`` that logs messages by appending them to a file
/// - parameter path: File path to write messages
public struct FileLogWriter: LogWriter {
    let path: URL

    /// Construct a new `FileLogWriter` to log to ``path``.
    /// - parameter path: file path for logging
    public init(path: URL) {
        assert(path.isFileURL)

        self.path = path
    }

    /// Implement ``LogWriter.log(record:)``
    /// - parameter record: message details to record``
    public func log(record: LogRecord) {
        try? OutputStream(url: path, append: true)?.use { stream in
            do {
                try stream.write(record.formatted).write("\n\r")
            } catch {
                print("An error occured writing to url: \(path)")
            }
        }
    }
}
