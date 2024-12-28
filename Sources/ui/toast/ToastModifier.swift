//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import SwiftUI

/// ``ViewModifier`` providing the real functionality of ``View.toast()``.
@available(iOS 16.0, *)
public struct ToastModifier<Alert: View>: ViewModifier {
    @Binding private var isDisplayed: Bool
    private let duration: Duration?
    private let position: ToastPosition
    private let dismissOnTouch: Bool
    @ViewBuilder private let alert: () -> Alert

    /// Default constructor
    ///
    /// - parameters:
    ///     - isDisplayed: is the toast message currently displayed
    ///     - duration: duration before the toast is automatically dismissed. If nil, the
    ///     toast must be manually dismissed.
    ///     - position: Where the toast should be positioned.
    ///     - dismissOnTouch: If true, then the toast message will be dismissed when
    ///     tapped.
    ///     - alert: Body of toast message to be displayed.
    public init(
        isDisplayed: Binding<Bool>,
        duration: Duration?,
        position: ToastPosition,
        dismissOnTouch: Bool,
        @ViewBuilder alert: @escaping () -> Alert
    ) {
        self._isDisplayed = isDisplayed
        self.duration = duration
        self.dismissOnTouch = dismissOnTouch
        self.position = position
        self.alert = alert
    }

    @ViewBuilder
    public func body(content: Content) -> some View {
        if isDisplayed {
            ZStack(alignment: position.alignment) {
                content
                alert()
                    .if(duration) { view, duration in
                        view.task {
                            do {
                                try await Task.sleep(for: duration)
                                isDisplayed = false
                            } catch {
                                // swiftlint appeasement
                            }
                        }
                    }
                    .if(dismissOnTouch) { view in
                        view.onTapGesture {
                            isDisplayed = false
                        }
                    }
                    .padding(position.padding)
            }
        } else {
            content
        }
    }
}

@available(iOS 16.0, *)
extension View {
    /// Display a toast message over the receiver.
    ///
    /// - parameters:
    ///     - isDisplayed: is the toast message currently displayed
    ///     - duration: duration before the toast is automatically dismissed. If nil, the
    ///     toast must be manually dismissed. Defaults to ``Duration.shortToast``.
    ///     - position: Where the toast should be positioned. Defaults to
    ///     ``ToastPosition.bottom``.
    ///     - dismissOnTouch: If true, then the toast message will be dismissed when
    ///     tapped. Defaults to false.
    ///     - alert: Body of toast message to be displayed.
    /// - returns the receiver modified to display a toast message.
    func toast(
        _ isDisplayed: Binding<Bool>,
        duration: Duration? = .shortToast,
        position: ToastPosition = .bottom,
        dismissOnTouch: Bool = false,
        @ViewBuilder alert: @escaping () -> some View
    ) -> some View {
        modifier(ToastModifier(
            isDisplayed: isDisplayed,
            duration: duration,
            position: position,
            dismissOnTouch: dismissOnTouch,
            alert: alert
        ))
    }

    /// Simplified ``View.toast`` to display a simple text message.
    ///
    /// - parameters:
    ///     - isDisplayed: is the toast message currently displayed
    ///     - message: text message to be displayed
    ///     - duration: duration before the toast is automatically dismissed. If nil, the
    ///     toast must be manually dismissed. Defaults to ``Duration.shortToast``.
    ///     - position: Where the toast should be positioned. Defaults to
    ///     ``ToastPosition.bottom``.
    ///     - dismissOnTouch: If true, then the toast message will be dismissed when
    ///     tapped. Defaults to false.
    /// - returns the receiver modified to display a toast message.
    func toast(
        _ isDisplayed: Binding<Bool>,
        _ message: String,
        duration: Duration? = .shortToast,
        position: ToastPosition = .bottom,
        dismissOnTouch: Bool = false
    ) -> some View {
        modifier(
            ToastModifier(
                isDisplayed: isDisplayed,
                duration: duration,
                position: position,
                dismissOnTouch: dismissOnTouch
            ) {
                Text(message)
                    .font(.footnote)
                    .framed()
            }
        )
    }
}

@available(iOS 16.0, *)
public extension Duration {
    /// Appropriate `Duration` for a short toast message of 2 seconds.
    static let shortToast = seconds(2) // swiftlint:disable:this no_magic_numbers

    /// Appropriate `Duration` for a longer toast message of 5 seconds.
    static let longToast = seconds(5) // swiftlint:disable:this no_magic_numbers
}

private let kPositionNames = ["Top", "Center", "Bottom"]

private func getPositionFromName(_ name: String) -> ToastPosition {
    switch name {
    case "Top":
        return .top

    case "Center":
        return .center

    default:
        return .bottom
    }
}

@available(iOS 17.0, *)
#Preview {
    @Previewable @State var isDisplayed = false
    @Previewable @State var positionName = "Top"

    NavigationView {
        VStack {
            Picker("Position", selection: $positionName) {
                ForEach(kPositionNames, id: \.self) { position in
                    Text(position)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .fixedSize(horizontal: true, vertical: false)

            Button("Show") {
                isDisplayed.toggle()
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toast($isDisplayed, "Toast", position: getPositionFromName(positionName))
    }
}
