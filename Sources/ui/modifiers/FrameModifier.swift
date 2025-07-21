//
// © Copyright 2024, David W. Berry. All Rights Reserved.
//

import SwiftUI

/// Default parameters for ``View.framed``
public enum FrameModifierDefaults {
    /// Default padding for ``View.framed``
    public static let padding: CGFloat = 8.0

    /// Default shadow radius for ``View.framed``
    public static let shadowRadius: CGFloat = 3.0

    /// Default shdow color for ``View.framed``
    public static let shadowColor: Color = .black.opacity(0.50)
    // swiftlint:disable:previous no_magic_numbers

    /// Default corner radius for ``View.framed``
    public static let cornerRadius: CGFloat = 8.0
}

public struct FrameModifier<Background: View>: ViewModifier {
    // swiftlint:disable:previous one_declaration_per_file
    public let padding: CGFloat
    public let shadowColor: Color?
    public let shadowRadius: CGFloat
    public let background: () -> Background

    public func body(content: Content) -> some View {
        content
            .padding(padding)
            .background {
                background()
            }
            .compositingGroup()
            .if(shadowColor) { parent, shadowColor in
                parent.shadow(color: shadowColor, radius: shadowRadius)
            }
    }
}

public extension View {
    /// Apply a frame to the receiver.
    /// - parameters:
    ///     - padding: size of padding between frame and receiver
    ///     - shadowColor:
    func framed<Background: View>(
        padding: CGFloat = FrameModifierDefaults.padding,
        shadowColor: Color? = FrameModifierDefaults.shadowColor,
        shadowRadius: CGFloat = FrameModifierDefaults.shadowRadius,
        @ViewBuilder background: @escaping () -> Background
    ) -> some View {
        modifier(
            FrameModifier(
                padding: padding,
                shadowColor: shadowColor,
                shadowRadius: shadowRadius,
                background: background
            )
        )
    }

    /// Apply a frame to the receiver.
    /// - parameters:
    ///     - padding: size of padding between frame and receiver
    ///     - shadowColor:
    func framed(
        padding: CGFloat = FrameModifierDefaults.padding,
        shadowColor: Color = FrameModifierDefaults.shadowColor,
        shadowRadius: CGFloat = FrameModifierDefaults.shadowRadius,
        cornerRadius: CGFloat = FrameModifierDefaults.cornerRadius
    ) -> some View {
        modifier(
            FrameModifier(
                padding: padding,
                shadowColor: shadowColor,
                shadowRadius: shadowRadius
            ) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundStyle(.background)
            }
        )
    }
}

#Preview {
    Text("Some Text")
        .framed()
}
