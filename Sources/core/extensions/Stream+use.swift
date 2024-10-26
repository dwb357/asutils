//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

public extension OutputStream {
    func use<T>(_ body: (OutputStream) throws -> T) rethrows -> T {
        open()
        defer { close() }

        return try body(self)
    }
}

public extension InputStream {
    func use<T>(_ body: (InputStream) throws -> T) rethrows -> T {
        open()
        defer { close() }

        return try body(self)
    }
}
