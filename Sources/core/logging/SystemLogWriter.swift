//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation
import os

/// Log messages to `os.Logger`
/// - parameter logger: Target `Logger` to utilize when logging messages.
@available(iOS 14.0, *)
public struct SystemLogWriter: LogWriter {
    let logger: Logger

    /// Create a ``LogWriter`` to log messages to a system logger.
    /// - parameter logger: target ``Logger`` for all messages.
    init(logger: Logger = Logger()) {
        self.logger = logger
    }

    /// Write a message to all child logs
    /// - parameters:
    ///     - record: ``LogRecord`` to log
    public func log(record: LogRecord) {
        switch record.level {
        case .debug, .trace:
            logger.debug("\(record.formatted)")

        case .info:
            logger.info("\(record.formatted)")

        case .warning:
            logger.warning("\(record.formatted)")

        case .error, .fatal:
            logger.error("\(record.formatted)")
        }
    }
}
