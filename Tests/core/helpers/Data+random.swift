//
// © Copyright 2024, David W. Berry. All Rights Reserved.
//

import Foundation

extension Data {
    static func random(count: Int, in generator: inout RandomNumberGenerator) -> Self {
        Data((0 ..< count).map { _ in generator.next() as UInt8 })
    }

    static func random(count: Int) -> Self {
        var generator: any RandomNumberGenerator = SystemRandomNumberGenerator()

        return .random(count: count, in: &generator)
    }
}
