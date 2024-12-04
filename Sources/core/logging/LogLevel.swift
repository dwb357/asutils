//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

/// Signficance or severity of a log message
public enum LogLevel: Int, Sendable, CaseIterable {
    /// detailed flow tracing
    case trace
    /// intended for logging detailed information about the system for debugging purposes.
    case debug
    /// includes messages that provide a record of the normal operation of the system.
    case info
    /// signifies potential issues that may lead to errors or unexpected behavior in the future if not addressed.
    case warning
    /// indicates error conditions that impair some operation but are less severe than critical situations.
    case error
    /// A critical unrecoverable error condition
    case fatal
}

extension LogLevel: CustomStringConvertible {
    /// Implement `CustomStringConvertible`
    public var description: String {
        switch self {
        case .trace:
            return "TRACE"

        case .debug:
            return "DEBUG"

        case .info:
            return "INFO"

        case .warning:
            return "WARNING"

        case .error:
            return "ERROR"

        case .fatal:
            return "FATAL"
        }
    }
}

extension LogLevel: Comparable {
    public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
