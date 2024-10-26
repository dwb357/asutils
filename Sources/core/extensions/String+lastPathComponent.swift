//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Foundation

extension String {
    /// Return the last path component (separated by "/")
    var lastPathComponent: Self {
        split(separator: "/").last.map(String.init) ?? self
    }
}
