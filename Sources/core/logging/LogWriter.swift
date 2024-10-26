//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation
import Mockable

@Mockable
public protocol LogWriter {
    func logMessage(
        _ message: String,
        level: LogLevel,
        file: StaticString,
        line: UInt
    )
}

public extension LogWriter {
    // This allows individual log writers convenient access to the "standard" message format, but they could
    // still override this function in their specific LogWriter instances.
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
