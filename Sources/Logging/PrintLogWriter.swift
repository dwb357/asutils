//
// © Copyright 2024, David W. Berry. All Rights Reserved.
//

import Foundation

/// Log messages by printing them using `Swift.print`
public struct PrintLogWriter: LogWriter {
    private let print: (String) -> Void

    public init(
        print: @escaping (String) -> Void = { Swift.print($0) }
    ) {
        self.print = print
    }

    /// Write a message to this log
    /// - parameters:
    ///     - record: ``LogRecord`` to log
    public func log(record: LogRecord) {
        self.print(record.formatted)
    }
}
