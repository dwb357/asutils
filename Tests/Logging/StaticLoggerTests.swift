//
// © Copyright 2024, David W. Berry. All Rights Reserved.
//

import Logging
import Mockable
import Testing

class StaticLoggerTests {
    private enum Log: StaticLogger {
        nonisolated(unsafe) static var instance: LogWriter?
        nonisolated(unsafe) static var category: String?
    }

    private let logger = MockLogWriter(policy: .relaxed)
    private let category = "Test"
    private let file: StaticString = #file
    private let line: UInt = #line
    private let message = "Hello, world!"

    init() {
        print("init")
        Log.instance = logger
        Log.category = category
    }

    @Test
    func trace() {
        Log.trace(message, file: file, line: line)

        verify(logger)
            .log(record: .value(
                LogRecord(
                    message: message,
                    level: .trace,
                    category: category,
                    file: file,
                    line: line,
                    formatted: message
                )
            ))
            .called(1)
    }

    @Test
    func debug() {
        Log.debug(message, file: file, line: line)

        verify(logger)
            .log(record: .value(
                LogRecord(
                    message: message,
                    level: .debug,
                    category: category,
                    file: file,
                    line: line,
                    formatted: message
                )
            ))
            .called(1)
    }

    @Test
    func info() {
        Log.info(message, file: file, line: line)

        verify(logger)
            .log(record: .value(
                LogRecord(
                    message: message,
                    level: .info,
                    category: category,
                    file: file,
                    line: line,
                    formatted: message
                )
            ))
            .called(1)
    }

    @Test
    func warning() {
        Log.warning(message, file: file, line: line)

        verify(logger)
            .log(record: .value(
                LogRecord(
                    message: message,
                    level: .warning,
                    category: category,
                    file: file,
                    line: line,
                    formatted: message
                )
            ))
            .called(1)
    }

    @Test
    func error() {
        Log.error(message, file: file, line: line)

        verify(logger)
            .log(record: .value(
                LogRecord(
                    message: message,
                    level: .error,
                    category: category,
                    file: file,
                    line: line,
                    formatted: message
                )
            ))
            .called(1)
    }

    @Test
    func fatal() {
        Log.fatal(message, file: file, line: line)

        verify(logger)
            .log(record: .value(
                LogRecord(
                    message: message,
                    level: .fatal,
                    category: category,
                    file: file,
                    line: line,
                    formatted: message
                )
            ))
            .called(1)
    }

    deinit {
        Log.instance = nil
        Log.category = nil
    }
}
