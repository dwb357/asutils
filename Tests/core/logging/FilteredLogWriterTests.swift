//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Testing
@testable import asutils_core
import Mockable

struct FilteredLogWriterTests {

    init() {
        Matcher.register(StaticString.self) { $0.description == $1.description }
    }

    @Test(arguments: LogLevel.allCases, LogLevel.allCases)
    func filterByLevel(level: LogLevel, target: LogLevel) async throws {
        let mock = MockLogWriter(policy: .relaxed)
        let writer = mock.filter(level: target)
        let file: StaticString = #file
        let line: UInt = #line

        writer.logMessage("Hello World", level: level, file: file, line: line)

        verify(mock)
            .logMessage(.value("Hello World"), level: .value(level), file: .value(file), line: .value(line))
            .called(level >= target ? 1 : 0)
    }
}
