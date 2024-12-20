//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

/// An add-on protocol to describe a class which must be opened before use.
public protocol HasOpen {
    /// Default `open` call to `Self`
    func open() throws
}

public extension HasOpen {
    /// Execute a block of code, guaranteeing that is `open`ed before usage.
    /// - parameter body: block to be safely executed
    /// - returns value returned by `body` if any.
    /// - throws rethrows any exception generated by `open` or `body`.
    func use<T>(_ body: (Self) throws -> T) throws -> T {
        try open()
        return try body(self)
    }
}
