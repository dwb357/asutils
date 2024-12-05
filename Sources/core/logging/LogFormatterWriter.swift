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

extension LogWriter {
    /// Attach a formatter to the receiving ``LogWriter``
    func format(_ formatter: LogFormatter) -> LogWriter {
        LogFormatterWriter(writer: self, formatter: formatter)
    }

    func format(_ formatter: @escaping (LogRecord) -> String) -> LogWriter {
        format(LogFormatter(formatter: formatter))
    }
}
