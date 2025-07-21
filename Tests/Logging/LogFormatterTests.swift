//
// © Copyright 2024, David W. Berry. All Rights Reserved.
//

import Logging
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
