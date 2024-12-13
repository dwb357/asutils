//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import asutils_core
import Mockable
import Testing

struct LogFormatterTests {
    @Test
    func formatExtensionApplies() {
        let mock = MockLogWriter(policy: .relaxed)
        let formatted = "Some Formatted Text"
        let writer = mock.format { _ in formatted }
        let record = LogRecord(
            message: "Message",
            level: .debug,
            category: nil,
            file: #file,
            line: #line
        )

        writer.log(record: record)

        verify(mock)
            .log(record: .value(record.copy(formatted: formatted)))
            .called(1)
    }
}
