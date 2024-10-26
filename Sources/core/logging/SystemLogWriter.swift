//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation
import os

public struct SystemLogWriter: LogWriter {
    let logger: Logger

    init(logger: Logger = Logger()) {
        self.logger = logger
    }

    public func logMessage(
        _ message: String,
        level: LogLevel,
        file: StaticString,
        line: UInt
    ) {
        switch level {
        case .debug, .trace:
            logger.debug("\(format(message, level: level, file: file, line: line))")
        case .info:
            logger.info("\(format(message, level: level, file: file, line: line))")
        case .warning:
            logger.warning("\(format(message, level: level, file: file, line: line))")
        case .error, .fatal:
            logger.error("\(format(message, level: level, file: file, line: line))")
        }
    }
}
