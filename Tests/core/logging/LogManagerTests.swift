//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import asutils_core
import Mockable
import Testing

class LogManagerTests {
    lazy var logger = MockLogWriter(policy: .relaxed)
    lazy var manager = LogManager(logger: logger)
    let file: StaticString = #file
    let line: UInt = #line
    let message = "Hello, world!"

    @Test func trace() {
        manager.trace(message, file: file, line: line)

        verify(logger)
            .log(record: .value(
                LogRecord(
                    message: message,
                    level: .trace,
                    category: nil,
                    file: file,
                    line: line,
                    formatted: message
                )
            ))
            .called(1)
    }

    @Test func debug() {
        manager.debug(message, file: file, line: line)

        verify(logger)
            .log(record: .value(
                LogRecord(
                    message: message,
                    level: .debug,
                    category: nil,
                    file: file,
                    line: line,
                    formatted: message
                )
            ))
            .called(1)
    }

    @Test func info() {
        manager.info(message, file: file, line: line)

        verify(logger)
            .log(record: .value(
                LogRecord(
                    message: message,
                    level: .info,
                    category: nil,
                    file: file,
                    line: line,
                    formatted: message
                )
            ))
            .called(1)
    }

    @Test func warning() {
        manager.warning(message, file: file, line: line)

        verify(logger)
            .log(record: .value(
                LogRecord(
                    message: message,
                    level: .warning,
                    category: nil,
                    file: file,
                    line: line,
                    formatted: message
                )
            ))
            .called(1)
    }

    @Test func error() {
        manager.error(message, file: file, line: line)

        verify(logger)
            .log(record: .value(
                LogRecord(
                    message: message,
                    level: .error,
                    category: nil,
                    file: file,
                    line: line,
                    formatted: message
                )
            ))
            .called(1)
    }

    @Test func fatal() {
        manager.fatal(message, file: file, line: line)

        verify(logger)
            .log(record: .value(
                LogRecord(
                    message: message,
                    level: .fatal,
                    category: nil,
                    file: file,
                    line: line,
                    formatted: message
                )
            ))
            .called(1)
    }
}
