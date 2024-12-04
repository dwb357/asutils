//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation
import os

public struct SystemLogWriter: LogWriter {
    let format: LogFormatter
    let logger: Logger

    init(logger: Logger = Logger(), format: @escaping LogFormatter = LogFormatters.default) {
        self.logger = logger
        self.format = format
    }

    public func log( // swiftlint:disable:this function_parameter_count
        _ message: String,
        level: LogLevel,
        category: String?,
        file: StaticString,
        fun: StaticString,
        line: UInt
    ) {
        let message = format(message, level, category, file, fun, line)

        switch level {
        case .debug, .trace:
            logger.debug("\(message)")

        case .info:
            logger.info("\(message)")

        case .warning:
            logger.warning("\(message)")

        case .error, .fatal:
            logger.error("\(message)")
        }
    }
}
