//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

/// Simplified access to logging functionality via a default ``LogWriter``.
///
/// Example usage:
///
///     LogManager(logger: SystemLogWriter().filter(minLevel: .warning))
///
/// or to log to both a file and the print console:
///
///     LogManager.logger = SharedLogWriter(
///         FileLogWriter("log"),
///         PrintLogWriter()
///     ).filter(minLevel: .warning)
///
/// `SharedLogWriter` and `filter` can also be combined to log different categories of messages
/// using different loggers:
///
///     LogManager(logger: SharedLogWriter(
///         FileLogWriter("log"),
///         SystemLogWriter().filter(categories: "CORE")
///     ))
///
/// The optional `category` parameter can be used to distinguish between messages arising
/// in different modules:
///
///     class Log {
///         static let manager = LogManager(logger: SystemLogWriter())
///         static let category = "CORE"
///
///         static func error(
///             _ message: String,
///             file: StaticString = #file,
///             line: UInt = #line
///         ) {
///             manager.error(message, category: category, file: file, line: line)
///         }
///     }
///
///     Log.error("An error occured")
///
/// The format of logged messages can be set with the ``LogWriter.format`` function:
///
///     LogManager(logger: SystemLogWriter().format(.simple))
///
/// As with filter, different loggers can use different formats:
///
///     LogManager(logger: SharedLogWriter(
///         FileLogWriter("log").format(.full),
///         PrintLogWriter().format(.simple)
///     ))
///
public struct LogManager {
    private let logger: LogWriter

    /// Construct a new `LogManager` writing to ``logger``
    /// - parameter logger: Target ``LogWriter`` for messages logged
    /// using this manager.
    public init(logger: LogWriter = PrintLogWriter()) {
        self.logger = logger
    }

    /// Write a message to this log
    /// - parameters:
    ///     - message: message to log
    ///     - level: `LogLevel` for this message
    ///     - category: category with which to tag the message
    ///     - file: file where message was generated
    ///     - fun: function where message was generated
    ///     - line: line where message was generated
    public func log(
        _ message: String,
        level: LogLevel,
        category: String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        logger.log(
            record: LogRecord(
                message: message,
                level: level,
                category: category,
                file: file,
                line: line
            )
        )
    }

    /// Log a message at level ``LogLevel/trace``.
    /// - Parameters:
    ///   - message: message to log
    ///   - category: category with which to tag the message
    ///   - file: file of trace call
    ///   - line: line of trace call
    public func trace(
        _ message: String,
        category: String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        log(
            message,
            level: .trace,
            category: category,
            file: file,
            line: line
        )
    }

    /// Log a message at level ``LogLevel/debug``.
    /// - Parameters:
    ///   - message: message to log
    ///   - category: category with which to tag the message
    ///   - file: file of trace call
    ///   - line: line of trace call
    public func debug(
        _ message: String,
        category: String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        log(
            message,
            level: .debug,
            category: category,
            file: file,
            line: line
        )
    }

    /// Log a message at level ``LogLevel/info``.
    /// - Parameters:
    ///   - message: message to log
    ///   - category: category with which to tag the message
    ///   - file: file of trace call
    ///   - line: line of trace call
    public func info(
        _ message: String,
        category: String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        log(
            message,
            level: .info,
            category: category,
            file: file,
            line: line
        )
    }

    /// Log a message at level ``LogLevel/warning``.
    /// - Parameters:
    ///   - message: message to log
    ///   - category: category with which to tag the message
    ///   - file: file of trace call
    ///   - line: line of trace call
    public func warning(
        _ message: String,
        category: String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        log(
            message,
            level: .warning,
            category: category,
            file: file,
            line: line
        )
    }

    /// Log a message at level ``LogLevel/error``.
    /// - Parameters:
    ///   - message: message to log
    ///   - category: category with which to tag the message
    ///   - file: file of trace call
    ///   - line: line of trace call
    public func error(
        _ message: String,
        category: String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        log(
            message,
            level: .error,
            category: category,
            file: file,
            line: line
        )
    }

    /// Log a message at level ``LogLevel/fatal``.
    /// - Parameters:
    ///   - message: message to log
    ///   - category: category with which to tag the message
    ///   - file: file of trace call
    ///   - line: line of trace call
    public func fatal(
        _ message: String,
        category: String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        log(
            message,
            level: .fatal,
            category: category,
            file: file,
            line: line
        )
    }
}
