//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

public struct SecureRandomNumberGenerator: RandomNumberGenerator {
    public func next() -> UInt64 {
        var bytes: UInt64 = 0
        let result = withUnsafeMutableBytes(of: &bytes, { buffer in
            SecRandomCopyBytes(kSecRandomDefault, buffer.count, buffer.baseAddress!)
        })

        guard result == errSecSuccess else {
            // Figure out how you'd prefer to deal with this.
            fatalError()
        }

        return bytes
    }
}
