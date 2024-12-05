//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

/// Log messages by logging them to each of the child ``LogWriter``s.
public class SharedLogWriter: LogWriter {
    let loggers: [LogWriter]

    /// Create a new ProxyLogWriter to forward messages to a given list of ``LogWriter``
    /// 
    /// - parameter loggers: vararg list of LogWriters to target
    public init(_ loggers: LogWriter...) {
        self.loggers = loggers
    }

    /// Write a message to all child logs
    /// - parameters:
    ///     - record: ``LogRecord`` to log
    public func log(record: LogRecord) {
        loggers.forEach { logger in
            logger.log(record: record)
        }
    }
}
