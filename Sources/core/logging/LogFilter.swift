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
public struct LogFilter: LogWriter {
    public typealias Predicate = (LogRecord) -> Bool

    let predicate: Predicate
    let writer: LogWriter

    public func log(record: LogRecord) {
        if predicate(record) {
            writer.log(record: record)
        }
    }
}

public extension LogWriter {
    /// Apply a filter to a ``LogWriter``. The receiver `LogWriter` will only log messages that match `predicate`
    /// - parameter predicate: Predicate to match.
    func filter(
        _ predicate: @escaping LogFilter.Predicate
    ) -> LogWriter {
        LogFilter(predicate: predicate, writer: self)
    }

    /// Apply a filter to a ``LogWriter``. The receiver `LogWriter` will only log messages with a level >= `level`
    /// - parameter minLevel: Minimum `LogLevel` to log
    func filter(level minLevel: LogLevel) -> LogWriter {
        filter { record in
            record.level >= minLevel
        }
    }

    /// Apply a filter to a ``LogWriter`` based on only passing messages in a list of categories.
    /// - parameter categories: list of categories to be logged
    func filter(categories: String...) -> LogWriter {
        filter { record in
            record.category.map(categories.contains) ?? false
        }
    }
}
