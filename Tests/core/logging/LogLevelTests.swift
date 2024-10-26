//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

@testable import asutils_core
import Testing

struct LogLevelTests {

    @Test(arguments: LogLevel.allCases)
    func testDescription(level: LogLevel) {
        #expect(level.description == level.rawValue.uppercased())
    }

    @Test(arguments: LogLevel.allCases, LogLevel.allCases)
    func testComparison(left: LogLevel, right: LogLevel) {
        #expect(
            (left < right) == (LogLevel.allCases.firstIndex(of: left)! < LogLevel.allCases.firstIndex(of: right)!)
        )
    }
}
