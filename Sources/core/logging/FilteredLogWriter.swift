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
    public typealias Predicate = (String, String?, LogLevel, StaticString, StaticString, UInt) -> Bool

    let predicate: Predicate
    let writer: LogWriter

    public func log( // swiftlint:disable:this function_parameter_count
        _ message: String,
        level: LogLevel,
        category: String?,
        file: StaticString,
        fun: StaticString,
        line: UInt
    ) {
        if predicate(message, category, level, file, fun, line) {
            writer.log(
                message,
                level: level,
                category: category,
                file: file,
                fun: fun,
                line: line
            )
        }
    }
}

public extension LogWriter {
    /// Apply a filter to a ``LogWriter``. The receiver `LogWriter` will only log messages that match `predicate`
    /// - parameter predicate: Predicate to match.
    func filter(
        _ predicate: @escaping FilteredLogWriter.Predicate
    ) -> LogWriter {
        FilteredLogWriter(predicate: predicate, writer: self)
    }

    /// Apply a filter to a ``LogWriter``. The receiver `LogWriter` will only log messages with a level >= `level`
    /// - parameter minLevel: Minimum `LogLevel` to log
    func filter(level minLevel: LogLevel) -> LogWriter {
        filter { _, _, level, _, _, _ in
            level >= minLevel
        }
    }
}
