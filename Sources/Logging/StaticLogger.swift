//
// © Copyright 2024, David W. Berry. All Rights Reserved.
//

import Foundation

/// Simplified access to logging functionality via a default ``LogWriter`` and category.
///
/// Example usage:
///
///     enum Log: StaticLogger {
///         nonisolated(unsafe) static var instance: LogWriter = PrintLogWriter()
///         nonisolated(unsafe) static let category: String? = nil
///     }
///
/// Once that's done, messages can be logged via `instance` using simple static methods. If `category`
/// is specified, it will be used as a default category for all messages logged using the `StaticLogger`.
///
///     Log.trace("Reached checkpoint")
///
/// To log to both a file and the print console:
///
///     Log.instance = SharedLogWriter(
///         FileLogWriter("log"),
///         PrintLogWriter()
///     ).filter(minLevel: .warning)
///
/// `SharedLogWriter` and `filter` can also be combined to log different categories of messages
/// using different loggers:
///
///     Log.instance = SharedLogWriter(
///         FileLogWriter("log"),
///         SystemLogWriter().filter(categories: "CORE")
///     )
///
/// The format of logged messages can be set with the ``LogWriter.format`` function:
///
///     Log.instance = SystemLogWriter().format(.simple)
///
/// As with filter, different loggers can use different formats:
///
///     Log.instance = SharedLogWriter(
///         FileLogWriter("log").format(.full),
///         PrintLogWriter().format(.simple)
///     )
///
public protocol StaticLogger {
    /// ``LogWriter`` to which messages will be logged. If instance is nil
    /// no logging will occur.
    static var instance: LogWriter? { get }

    /// Default category for messages logged using this `StaticLogger` if
    /// no category is specified in the actual logging call.
    static var category: String? { get }
}

public extension StaticLogger {
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
        line: UInt = #line
    ) {
        instance?.log(
            record: LogRecord(
                message: message,
                level: level,
                category: category ?? Self.category,
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
    static func trace(
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
    static func debug(
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
    static func info(
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
    static func warning(
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
    static func error(
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
    static func fatal(
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

    /// Log entry, exit, and elapsed time of a block of code.
    /// - Parameters:
    ///     - message: message to log
    ///     - category: category to log
    ///     - level: level to log message to, defaults to ``.trace``
    ///     - file: file of trace call
    ///     - line: line of trace call
    ///     - block: block of code to trace and time
    /// - Returns: the value returned by ``block``
    static func time<Result>(
        _ message: String,
        category: String? = nil,
        level: LogLevel = .trace,
        file: StaticString = #file,
        line: UInt = #line,
        block: () throws -> Result
    ) rethrows -> Result {
        let start = Date.now

        log(
            "Enter \(message)",
            level: level,
            category: category,
            file: file,
            line: line
        )

        defer {
            log(
                "Elapsed \(-start.timeIntervalSinceNow): \(message)",
                level: level,
                category: category,
                file: file,
                line: line
            )
        }

        return try block()
    }
}
