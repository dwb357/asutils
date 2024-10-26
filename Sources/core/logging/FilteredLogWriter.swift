//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

public struct FilteredLogWriter {
    let predicate: (String, LogLevel, StaticString, UInt) -> Bool
    let writer: LogWriter
}

extension FilteredLogWriter: LogWriter {
    public func logMessage(_ message: String, level: LogLevel, file: StaticString, line: UInt) {
        if predicate(message, level, file, line) {
            writer.logMessage(message, level: level, file: file, line: line)
        }
    }
}

public extension LogWriter {
    func filtered(_ predicate: @escaping (String, LogLevel, StaticString, UInt) -> Bool) -> FilteredLogWriter {
        FilteredLogWriter(predicate: predicate, writer: self)
    }

    func filter(level minLevel: LogLevel) -> FilteredLogWriter {
        filtered { _, level, _, _ in
            level >= minLevel
        }
    }
}
