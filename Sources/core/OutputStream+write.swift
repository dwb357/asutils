//
// © Copyright 2024, David W. Berry. All Rights Reserved.
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
    /// - Parameters:
    ///     - data: `Data` to write to file
    /// - Returns receiver
    /// - Throws Can throw any Error that `OutputStream.write(_:_)` can throw
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
    /// - Parameters:
    ///     - string: `String` to convert and write to file
    ///     - encoding: `String.Encoding` to use
    ///     - allowLossy: true to allow lossy conversion
    /// - Returns receiver
    /// - Throws Can throw any `Error` that `OutputStream.write` can throw
    /// - Throws `StreamError.invalidStringConversion` if `string` cannot be converted using the encoding `using`.
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

    /// Write `Encodable` data to an `OutputStream`
    /// - Parameters
    ///     - value: Value to be written
    ///     - encoder: `JSONEncoder` to be used for encoding. A default encoder is used if none is provided.
    /// - Returns: receiver
    /// - Throws: Can thrown any `Error` that `OutputStream.write` or `JSONEncoder.encode` can throw.
    func write<T: Encodable>(
        _ value: T,
        encoder: JSONEncoder = .init()
    ) throws -> Self {
        let data = try encoder.encode(value)
        return try write(data)
    }
}
