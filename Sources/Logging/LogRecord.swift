//
// © Copyright 2024, David W. Berry. All Rights Reserved.
//

import Foundation

/// A record of the details to be logged. All details are maintained throughout the ``LogWriter`` chain to facilitate
/// customized formatting, filtering, and other operations in a fully isolated manner.
public struct LogRecord: Equatable {
    /// raw message to log
    public let message: String
    /// `LogLevel`` of message to log
    public let level: LogLevel
    /// category of message to log
    public let category: String?
    /// originating file of log message
    public let file: StaticString
    /// originating line of log message
    public let line: UInt
    /// raw message to log
    public let formatted: String

    /// Full constructor
    ///
    /// - parameters:
    ///     - message: raw message to log
    ///     - level ``LogLevel`` of message to log
    ///     - category: category of message to log
    ///     - file: originating file of log message
    ///     - line: originating line of log message
    ///     - formatted: fully formatted message to log
    public init(
        message: String,
        level: LogLevel,
        category: String?,
        file: StaticString,
        line: UInt,
        formatted: String? = nil
    ) {
        self.formatted = formatted ?? message
        self.message = message
        self.level = level
        self.category = category
        self.file = file
        self.line = line
    }

    public func copy(
        message: String? = nil,
        level: LogLevel? = nil,
        category: String? = nil,
        file: StaticString? = nil,
        line: UInt? = nil,
        formatted: String? = nil
    ) -> Self {
        Self(
            message: message ?? self.message,
            level: level ?? self.level,
            category: category ?? self.category,
            file: file ?? self.file,
            line: line ?? self.line,
            formatted: formatted ?? self.formatted
        )
    }
}
