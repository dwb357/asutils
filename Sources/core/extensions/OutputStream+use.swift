//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

public extension OutputStream {
    /// Perform an operation on an ``InputStream``, surrounded by ``open`` and ``close``
    /// and close calls.
    ///
    /// The target stream will be `open`ed before `body` is invoked and then `close`
    /// will be called after body is finished, whether it returns normally or throws an exception.
    ///
    /// - parameter body: operation to perform on the stream.
    /// - returns value returned by `body`
    /// - throws Any `Error` thrown by `body` is rethrown.
    func use<T>(_ body: (OutputStream) throws -> T) rethrows -> T {
        open()
        defer { close() }

        return try body(self)
    }
}
