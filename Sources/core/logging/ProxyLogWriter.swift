//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

/// Log messages by logging them to each of the children ``LogWriter``s.
public class ProxyLogWriter: LogWriter {
    let loggers: [LogWriter]

    /// Create a new ProxyLogWriter to forward messages to a given list of ``LogWriter``
    /// 
    /// - parameter loggers: vararg list of LogWriters to target
    public init(loggers: LogWriter...) {
        self.loggers = loggers
    }

    /// Log a message by logging it to each target ``LogWriter`` defined at initialization time.
    ///
    /// - parameters:
    ///     - message: detailed message to log
    ///     - level: level of message to log
    ///     - file: file where error occured
    ///     - line: line where error occured
    public func logMessage(
        _ message: String,
        level: LogLevel,
        file: StaticString,
        line: UInt
    ) {
        loggers.forEach { logger in
            logger.logMessage(message, level: level, file: file, line: line)
        }
    }
}
