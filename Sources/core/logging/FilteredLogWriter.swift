//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

/// A ``LogWriter`` that filters messages to be output based on a predicate.
///
/// Most easily used via `LogWriter.filter`:
///
///     let writer = FileLogWriter(url: URL).filter(level: .warning)
///
/// - parameters
///     - predicate: predicate filter to be applied to every message to send. Only if `predicate` returns true
///     will the message be written via `writer`.
///     - writer: underlying writer to use. Messages matching `predicate` will be output using `writer`
public struct FilteredLogWriter: LogWriter {
    let predicate: (String, LogLevel, StaticString, UInt) -> Bool
    let writer: LogWriter

    public func logMessage(_ message: String, level: LogLevel, file: StaticString, line: UInt) {
        if predicate(message, level, file, line) {
            writer.logMessage(message, level: level, file: file, line: line)
        }
    }
}

public extension LogWriter {
    /// Apply a filter to a ``LogWriter``. The receiver `LogWriter` will only log messages that match `predicate`
    /// - parameter predicate: Predicate to match.
    func filter(_ predicate: @escaping (String, LogLevel, StaticString, UInt) -> Bool) -> LogWriter {
        FilteredLogWriter(predicate: predicate, writer: self)
    }

    /// Apply a filter to a ``LogWriter``. The receiver `LogWriter` will only log messages with a level >= `level`
    /// - parameter level: Minimum `LogLevel` to log
    func filter(level minLevel: LogLevel) -> LogWriter {
        filter { _, level, _, _ in
            level >= minLevel
        }
    }
}
