//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

@testable import asutils_core
import Mockable
import Testing

struct LogFilterTests {
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

    @Test(arguments: ["Test", "Other"], ["Test", "Other"])
    func filterByCategory(category: String, target: String) async throws {
        let mock = MockLogWriter(policy: .relaxed)
        let writer = mock.filter(categories: target)
        let file: StaticString = #file
        let function: StaticString = #function
        let line: UInt = #line

        writer.log(
            "Hello World",
            level: .debug,
            category: category,
            file: file,
            fun: function,
            line: line
        )

        verify(mock)
            .log(
                .value("Hello World"),
                level: .value(.debug),
                category: .value(category),
                file: .value(file),
                fun: .value(function),
                line: .value(line)
            )
            .called(category == target ? 1 : 0)
    }
}
