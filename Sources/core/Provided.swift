//
// © Copyright 2024, David W. Berry. All Rights Reserved.
//

import Foundation

/// Add-on protocol noting a class that can provide default values, primarily for testing.
public protocol Provided {
    /// Current function to provide the next instance of `Self`
    nonisolated(unsafe) static var provider: () -> Self { get set }

    /// Return the current provided value
    nonisolated(unsafe) static var provided: Self { get }
}

public extension Provided {
    /// Return the current provided value
    nonisolated(unsafe) static var provided: Self { provider() }
}

/// A function that provides the current Date.
///
/// Primarily useful for testing.
extension Date: Provided {
    /// Current provider of Date. Defaults to `Date()`
    public nonisolated(unsafe) static var provider = { Date() }
}

extension UUID: Provided {
    public nonisolated(unsafe) static var provider = { UUID() }
}
