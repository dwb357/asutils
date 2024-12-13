//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import asutils_core
import Testing

struct LogLevelTests {
    @Test(
        arguments: zip(LogLevel.allCases, ["TRACE", "DEBUG", "INFO", "WARNING", "ERROR", "FATAL"])
    )
    func testDescription(level: LogLevel, label: String) {
        #expect(level.description == label)
    }

    @Test(arguments: LogLevel.allCases, LogLevel.allCases)
    func testComparison(left: LogLevel, right: LogLevel) {
        #expect(
            // swiftlint:disable:next force_unwrapping
            (left < right) == (LogLevel.allCases.firstIndex(of: left)! < LogLevel.allCases.firstIndex(of: right)!)
        )
    }
}
