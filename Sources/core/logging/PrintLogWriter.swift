//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

/// Log messages by printing them using `Swift.print`
public struct PrintLogWriter: LogWriter {
    /// Write a message to this log
    /// - parameters:
    ///     - record: ``LogRecord`` to log
    public func log(record: LogRecord) {
        print(record.formatted)
    }
}
