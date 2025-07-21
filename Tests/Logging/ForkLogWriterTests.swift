//
// © Copyright 2024, David W. Berry. All Rights Reserved.
//

import Logging
import Mockable
import Testing

struct ForkLogWriterTests {
    init() {
        Matcher.register(StaticString.self) { $0.description == $1.description }
    }

    @Test(arguments: LogLevel.allCases)
    func proxyDistributesLogMessages(level: LogLevel) {
        let mock1 = MockLogWriter(policy: .relaxed)
        let mock2 = MockLogWriter(policy: .relaxed)
        let proxy = ForkLogWriter(mock1, mock2)
        let record = LogRecord(
            message: "Message",
            level: level,
            category: nil,
            file: #file,
            line: #line
        )

        proxy.log(record: record)

        verify(mock1)
            .log(record: .value(record))
            .called(1)

        verify(mock2)
            .log(record: .value(record))
            .called(1)
    }
}
