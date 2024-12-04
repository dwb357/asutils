//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

public struct PrintLogWriter: LogWriter {
    let format = LogFormatters.medium

    public func log( // swiftlint:disable:this function_parameter_count
        _ message: String,
        level: LogLevel,
        category: String?,
        file: StaticString,
        fun: StaticString,
        line: UInt
    ) {
        print(format(message, level, category, file, fun, line))
    }
}
