//
// Copyright © 2025, David W. Berry
// All rights reserved.
//

import Foundation
import Mockable

@Mockable
public protocol FileProtocol {
    var path: URL { get }

    func read() throws -> Data

    func readAsString(encoding: String.Encoding) throws -> String

    func write(data: Data) throws

    func write(string: String, encoding: String.Encoding) throws
}

public extension FileProtocol {
    func readAsString() throws -> String {
        try readAsString(encoding: .utf8)
    }

    func write(string: String) throws {
        try write(string: string, encoding: .utf8)
    }
}
