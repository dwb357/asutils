//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

public struct PrintLogWriter: LogWriter {
    public func logMessage(
        _ message: String,
        level: LogLevel,
        file: StaticString,
        line: UInt
    ) {
        print(format(message, level: level, file: file, line: line))
    }
}
