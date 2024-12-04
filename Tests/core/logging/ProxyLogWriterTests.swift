//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

@testable import asutils_core
import Mockable
import Testing

struct Test {

    init() {
        Matcher.register(StaticString.self) { $0.description == $1.description }
    }

    @Test(arguments: LogLevel.allCases)
    func proxyDistributesLogMessages(level: LogLevel) {
        let mock1 = MockLogWriter(policy: .relaxed)
        let mock2 = MockLogWriter(policy: .relaxed)
        let proxy = SharedLogWriter(mock1, mock2)
        let category = "Test"
        let file: StaticString = #file
        let function: StaticString = #function
        let line: UInt = #line

        proxy.log(
            "Hello, world!",
            level: level,
            category: category,
            file: file,
            fun: function,
            line: line
        )

        verify(mock1)
            .log(
                .value("Hello, world!"),
                level: .value(level),
                category: .value(category),
                file: .value(file),
                fun: .value(function),
                line: .value(line)
            )
            .called(1)

        verify(mock2)
            .log(
                .value("Hello, world!"),
                level: .value(level),
                category: .value(category),
                file: .value(file),
                fun: .value(function),
                line: .value(line)
            )
            .called(1)
    }

}
