//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

/// Log messages by logging them to each of the children ``LogWriter``s.
public class SharedLogWriter: LogWriter {
    let loggers: [LogWriter]

    /// Create a new ProxyLogWriter to forward messages to a given list of ``LogWriter``
    /// 
    /// - parameter loggers: vararg list of LogWriters to target
    public init(_ loggers: LogWriter...) {
        self.loggers = loggers
    }

    /// Log a message by logging it to each target ``LogWriter`` defined at initialization time.
    ///
    /// - parameters:
    ///     - message: detailed message to log
    ///     - level: level of message to log
    ///     - file: file where error occured
    ///     - line: line where error occured
    public func log( // swiftlint:disable:this function_parameter_count
        _ message: String,
        level: LogLevel,
        category: String?,
        file: StaticString,
        fun: StaticString,
        line: UInt
    ) {
        loggers.forEach { logger in
            logger.log(message, level: level, category: category, file: file, fun: fun, line: line)
        }
    }
}
