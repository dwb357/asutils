//
// © Copyright 2024, David W. Berry. All Rights Reserved.
//

import Foundation

public extension String {
    /// Return the last path component (separated by "/")
    var lastPathComponent: Self {
        split(separator: "/").last.map(String.init) ?? self
    }
}
