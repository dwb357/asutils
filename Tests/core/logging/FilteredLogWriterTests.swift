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
        let category = "Test"
        let file: StaticString = #file
        let function: StaticString = #function
        let line: UInt = #line

        writer
            .log(
                "Hello World",
                level: level,
                category: category,
                file: file,
                fun: function,
                line: line
            )

        verify(mock)
            .log(
                .value("Hello World"),
                level: .value(level),
                category: .value(category),
                file: .value(file),
                fun: .value(function),
                line: .value(line)
            )
            .called(level >= target ? 1 : 0)
    }
}
