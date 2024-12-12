//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation
import Mockable

/// Write messages to a log.
@Mockable
public protocol LogWriter {
    /// Write a message to this log
    /// - parameters:
    ///     - record: ``LogRecord`` to log
    func log(record: LogRecord)
}

public extension LogWriter {
    /// Write a message to this log
    /// - parameters:
    ///     - message: message to log
    ///     - level: `LogLevel` for this message
    ///     - category: category with which to tag the message
    ///     - file: file where message was generated
    ///     - fun: function where message was generated
    ///     - line: line where message was generated
    func log(
        _ message: String,
        level: LogLevel,
        category: String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        log(
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
    func trace(
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
    func debug(
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
    func info(
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
    func warning(
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
    func error(
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
    func fatal(
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
