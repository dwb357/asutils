//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

/// A ``LogWriter`` that formats the message before passing it on
/// - parameter writer: Target ``LogWriter``
/// - parameter formatter: ``LogFormatter`` to use for message formatting
private struct LogFormatterWriter: LogWriter {
    let writer: LogWriter
    let formatter: LogFormatter

    /// Implement ``LogWriter.log(record:)``
    /// - parameter record: message details to record``
    func log(record: LogRecord) {
        writer.log(record: formatter(record: record))
    }
}

public extension LogWriter {
    /// Attach a formatter to the receiving ``LogWriter``
    /// - parameter formatter: ``LogFormatter`` to use formatting messages
    /// to the receiver.
    func format(_ formatter: LogFormatter) -> LogWriter {
        LogFormatterWriter(writer: self, formatter: formatter)
    }

    /// Attach a formatting function to the receiving ``LogWriter``
    /// - parameter formatter: function to use formatting messages
    /// to the receiver.
    func format(_ formatter: @escaping (LogRecord) -> String) -> LogWriter {
        format(LogFormatter(formatter: formatter))
    }
}
