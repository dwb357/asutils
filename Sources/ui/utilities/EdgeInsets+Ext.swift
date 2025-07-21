//
// © Copyright 2024, David W. Berry. All Rights Reserved.
//

import SwiftUI

public extension EdgeInsets {
    /// An `EdgeInsets` with no insets.
    static let zero = Self(top: 0, leading: 0, bottom: 0, trailing: 0)

    /// Construct an `EdgeInsets` with only the specified paddings applied. All other insets
    /// default to zero.
    ///
    /// - parameters:
    ///     - top: top inset to apply
    ///     - leading: leading inset to apply
    ///     - bottom: bottom inset to apply
    ///     - training: bottom inset to apply
    static func from(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) -> Self {
        .init(top: top, leading: leading, bottom: bottom, trailing: trailing)
    }
}
