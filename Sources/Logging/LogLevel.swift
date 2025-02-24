//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

/// Signficance or severity of a log message
public enum LogLevel: String, Sendable, CaseIterable, Equatable {
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
        rawValue.uppercased()
    }
}

extension LogLevel: Comparable {
    public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
        guard let lhs = allCases.firstIndex(of: lhs), let rhs = allCases.firstIndex(of: rhs) else {
            return false
        }

        return lhs < rhs
    }
}
