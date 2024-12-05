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
    ///     - record: ``LogRecord`` to log
    func log(record: LogRecord)
}
