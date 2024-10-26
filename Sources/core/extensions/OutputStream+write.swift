//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

public extension OutputStream {
    enum StreamError: Error {
        /// An error occured when converting a string to UTF8 to write to a file
        case invalidStringConversion
        /// An unknown error occured while writing a file
        case unknownError
    }

    /// write Data to a file
    /// - parameters:
    ///     - data: ``Data`` to write to file
    /// - returns receiver
    /// - throws Can throw any Error that ``OutputStream.write`` can throw
    @discardableResult
    func write(_ data: Data) throws -> Self {
        try data.withUnsafeBytes { rawBuffer in
            var buffer = rawBuffer.bindMemory(to: UInt8.self)

            while !buffer.isEmpty {
                // swiftlint:disable:next force_unwrapping
                let written = self.write(buffer.baseAddress!, maxLength: buffer.count)
                guard written >= 0 else {
                    throw self.streamError ?? StreamError.unknownError
                }
                buffer = .init(rebasing: buffer.dropFirst(written))
            }
        }

        return self
    }

    /// write String to a file
    /// - parameters:
    ///     - string: ``String`` to convert and write to file
    ///     - using: ``String.Encoding`` to use
    ///     - allowLossyConversion: true to allow lossy conversion
    /// - returns receiver
    /// - throws Can throw any `Error` that ``OutputStream.write`` can throw
    /// - throws ``StreamError.invalidStringConversion`` if `string` cannot be converted using the encoding `using`.
    @discardableResult
    func write(
        _ string: String,
        using encoding: String.Encoding = .utf8,
        allowLossyConversion allowLossy: Bool = true
    ) throws -> Self {
        guard let data = string.data(using: encoding, allowLossyConversion: allowLossy) else {
            throw StreamError.invalidStringConversion
        }

        return try write(data)
    }
}
