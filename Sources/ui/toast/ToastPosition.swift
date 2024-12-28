//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import SwiftUI

/// How to position a ``View.toast`` message.
public struct ToastPosition {
    /// Position the message at the top of the container.
    nonisolated(unsafe) public static let top = Self(
        alignment: .top,
        padding: .from(top: 8.0)  // swiftlint:disable:this no_magic_numbers
    )

    /// Position the message at the center of the container.
    nonisolated(unsafe) public static let center = Self(
        alignment: .center,
        padding: .zero
    )

    /// Position the message at the bottom of the container.
    nonisolated(unsafe) public static let bottom = Self(
        alignment: .bottom,
        padding: .from(bottom: 8.0)  // swiftlint:disable:this no_magic_numbers
    )

    /// ``SwiftUI.Alignment`` to use for this message positioning.
    public let alignment: SwiftUI.Alignment

    /// ``EdgeInsets`` insets from container to use with this message positioning.
    public let padding: EdgeInsets
}
