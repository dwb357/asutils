//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

extension StaticString: @retroactive Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.description == rhs.description
    }
}
