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
    ///     - category: message category to log
    ///     - level: `LogLevel` for this message
    ///     - file: file where message was generated
    ///     - fun: function where message was generated
    ///     - line: line where message was generated
    func log( // swiftlint:disable:this function_parameter_count
        _ message: String,
        level: LogLevel,
        category: String?,
        file: StaticString,
        fun: StaticString,
        line: UInt
    )
}
