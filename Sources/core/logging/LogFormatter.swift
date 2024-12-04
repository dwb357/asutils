//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

/// A function that formats log messages
public typealias LogFormatter = (
    /// Format a message to be written to the logger.
    /// - parameters:
    ///     - message: message to log
    ///     - level: `LogLevel` for this message
    ///     - category: category for this message
    ///     - file: file where message was generated
    ///     - line: line where message was generated
    /// - returns: Formatted message to log
    _ message: String,
    _ level: LogLevel,
    _ category: String?,
    _ file: StaticString,
    _ fun: StaticString,
    _ line: UInt
) -> String
