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
    ///     - message: message to log
    ///     - level: `LogLevel` for this message
    ///     - file: file where message was generated
    ///     - line: line where message was generated
    func logMessage(
        _ message: String,
        level: LogLevel,
        file: StaticString,
        line: UInt
    )
}

public extension LogWriter {
    /// Format a message to be written to the logger.
    /// - parameters:
    ///     - message: message to log
    ///     - level: `LogLevel` for this message
    ///     - file: file where message was generated
    ///     - line: line where message was generated
    /// - returns: Formatted message to log
    func format(
        _ message: String,
        level: LogLevel,
        file: StaticString,
        line: UInt
    ) -> String {
        let file = file.description.lastPathComponent

        return "\(Date.current) [\(file):\(line)]: \(level): \(message)"
    }
}
