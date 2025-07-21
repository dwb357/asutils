//
// Copyright © 2025, David W. Berry
// All rights reserved.
//

import Foundation
import Mockable

public struct File: FileProtocol {
    public let path: URL

    public init(path: URL) {
        self.path = path
    }

    public func read() throws -> Data {
        try Data(contentsOf: path)
    }

    public func readAsString(encoding: String.Encoding) throws -> String {
        try String(contentsOf: path, encoding: encoding)
    }

    public func write(data: Data) throws {
        try data.write(to: path)
    }

    public func write(string: String, encoding: String.Encoding) throws {
        try string.write(to: path, atomically: true, encoding: encoding)
    }
}
