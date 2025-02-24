//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Logging
import Mockable
import Testing

struct LogFilterTests {
    @Test(arguments: LogLevel.allCases, LogLevel.allCases)
    func filterByLevel(level: LogLevel, target: LogLevel) async throws {
        let mock = MockLogWriter(policy: .relaxed)
        let writer = mock.filter(level: target)
        let record = LogRecord(
            message: "Message",
            level: level,
            category: nil,
            file: #file,
            line: #line
        )

        writer.log(record: record)

        verify(mock)
            .log(record: .value(record))
            .called(level >= target ? 1 : 0)
    }

    @Test(arguments: ["Test", "Other"], ["Test", "Other"])
    func filterByCategory(category: String, target: String) async throws {
        let mock = MockLogWriter(policy: .relaxed)
        let writer = mock.filter(categories: target)
        let record = LogRecord(
            message: "Message",
            level: .debug,
            category: category,
            file: #file,
            line: #line
        )

        writer.log(record: record)

        verify(mock)
            .log(record: .value(record))
            .called(category == target ? 1 : 0)
    }
}
