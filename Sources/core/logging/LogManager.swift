//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

/// Simplified access to logging functionality via a default ``LogWriter``.
///
/// Example usage:
///
///     LogManager.logger = SystemLogWriter().filter(minLevel: .warning)
///
/// or to log to both a file and the print console:
///
///     LogManager.logger = SharedLogWriter(
///         FileLogWriter("log"),
///         PrintLogWriter()
///     ).filter(minLevel: .warning)
///
/// The format of logged messages can be updated by specifying a ``LogFormatter``:
///
///     LogManager.logger = SystemLogWriter(format: LogFormatters.long)
///
/// Most ``LogWriter`` implementations support the specification of a ``LogFormatter``.
///
/// `SharedLogWriter` and `filter` can also be combined to log different categories of messages
/// using different loggers:
///
///     LogManager.logger = SharedLogWriter(
///         FileLogWriter("log"),
///         SystemLogWriter().filter(categories: "CORE")
///     )
///     
/// The optional `category` parameter can be used to distinguish between messages arising
/// in different modules:
///
///     class Log {
///         static func error(
///             _ message: String,
///             file: StaticString = #file,
///             fun: StaticString = #fun,
///             line: UInt = #line
///         ) {
///             LogManager.error(message, category: "CORE", file: file, fun: fun, line: line)
///         }
///     }
///
///     Log.error("An error occured")
///
public enum LogManager {
    /// Default ``LogWriter`` for logging functions below.
    public nonisolated(unsafe) static var logger: LogWriter = PrintLogWriter()

    /// Write a message to this log
    /// - parameters:
    ///     - message: message to log
    ///     - level: `LogLevel` for this message
    ///     - category: category with which to tag the message
    ///     - file: file where message was generated
    ///     - fun: function where message was generated
    ///     - line: line where message was generated
    static func log(
        _ message: String,
        level: LogLevel,
        category: String? = nil,
        file: StaticString = #file,
        fun: StaticString = #function,
        line: UInt = #line
    ) {
        logger.log(
            message,
            level: level,
            category: category,
            file: file,
            fun: fun,
            line: line
        )
    }

    /// Log a message at level ``LogLevel/trace``.
    /// - Parameters:
    ///   - message: message to log
    ///   - category: category with which to tag the message
    ///   - file: file of trace call
    ///   - fun: function where message was generated
    ///   - line: line of trace call
    static func trace(
        _ message: String,
        category: String? = nil,
        file: StaticString = #file,
        fun: StaticString = #function,
        line: UInt = #line
    ) {
        log(
            message,
            level: .trace,
            category: category,
            file: file,
            fun: fun,
            line: line
        )
    }

    /// Log a message at level ``LogLevel/debug``.
    /// - Parameters:
    ///   - message: message to log
    ///   - category: category with which to tag the message
    ///   - file: file of trace call
    ///   - fun: function where message was generated
    ///   - line: line of trace call
    static func debug(
        _ message: String,
        category: String? = nil,
        file: StaticString = #file,
        fun: StaticString = #function,
        line: UInt = #line
    ) {
        log(
            message,
            level: .debug,
            category: category,
            file: file,
            fun: fun,
            line: line
        )
    }

    /// Log a message at level ``LogLevel/info``.
    /// - Parameters:
    ///   - message: message to log
    ///   - category: category with which to tag the message
    ///   - file: file of trace call
    ///   - fun: function where message was generated
    ///   - line: line of trace call
    static func info(
        _ message: String,
        category: String? = nil,
        file: StaticString = #file,
        fun: StaticString = #function,
        line: UInt = #line
    ) {
        log(
            message,
            level: .info,
            category: category,
            file: file,
            fun: fun,
            line: line
        )
    }

    /// Log a message at level ``LogLevel/warning``.
    /// - Parameters:
    ///   - message: message to log
    ///   - category: category with which to tag the message
    ///   - file: file of trace call
    ///   - fun: function where message was generated
    ///   - line: line of trace call
    static func warning(
        _ message: String,
        category: String? = nil,
        file: StaticString = #file,
        fun: StaticString = #function,
        line: UInt = #line
    ) {
        log(
            message,
            level: .warning,
            category: category,
            file: file,
            fun: fun,
            line: line
        )
    }

    /// Log a message at level ``LogLevel/error``.
    /// - Parameters:
    ///   - message: message to log
    ///   - category: category with which to tag the message
    ///   - file: file of trace call
    ///   - fun: function where message was generated
    ///   - line: line of trace call
    static func error(
        _ message: String,
        category: String? = nil,
        file: StaticString = #file,
        fun: StaticString = #function,
        line: UInt = #line
    ) {
        log(
            message,
            level: .error,
            category: category,
            file: file,
            fun: fun,
            line: line
        )
    }

    /// Log a message at level ``LogLevel/fatal``.
    /// - Parameters:
    ///   - message: message to log
    ///   - category: category with which to tag the message
    ///   - file: file of trace call
    ///   - fun: function where message was generated
    ///   - line: line of trace call
    static func fatal(
        _ message: String,
        category: String? = nil,
        file: StaticString = #file,
        fun: StaticString = #function,
        line: UInt = #line
    ) {
        log(
            message,
            level: .fatal,
            category: category,
            file: file,
            fun: fun,
            line: line
        )
    }
}
