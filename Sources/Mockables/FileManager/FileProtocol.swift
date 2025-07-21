//
// © Copyright 2025, David W. Berry. All Rights Reserved.
//

import Foundation
import Mockable

// swiftlint:disable missing_docs

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

// swiftlint:enable missing_docs
