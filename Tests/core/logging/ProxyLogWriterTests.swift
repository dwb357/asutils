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
        let proxy = ProxyLogWriter(loggers: mock1, mock2)
        let file: StaticString = #file
        let line: UInt = #line

        proxy.logMessage("Hello, world!", level: level, file: file, line: line)

        verify(mock1)
            .logMessage(.value("Hello, world!"), level: .value(level), file: .value(file), line: .value(line))
            .called(1)

        verify(mock2)
            .logMessage(.value("Hello, world!"), level: .value(level), file: .value(file), line: .value(line))
            .called(1)
    }

}
