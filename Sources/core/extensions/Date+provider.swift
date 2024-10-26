//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

/// A function that provides the current Date.
///
/// Primarily useful for testing.
typealias DateProvider = () -> Date

public extension Date {
    /// Current ``DateProvider`` defaults to `Date()`
    nonisolated(unsafe) static var provider = { Date() }

    /// Return the current date as provided by ``Date.provider``
    nonisolated(unsafe) static var current: Date { provider() }
}
