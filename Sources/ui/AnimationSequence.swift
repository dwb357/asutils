//
//  AnimationSequence.swift
//  ASUtils-UI
//
//  © Copyright 2024 David W. Berry. All Rights Reserved.
//

import SwiftUI

/// Create a sequence of animations to be executed in order.
///
/// Can be used as:
///
///     .task {
///         await AnimationSequence(style: .linear)
///             .duration(2.0)
///             .append { offset.width = 80 }
///             .append { offset.height = 80 }
///             .append { offset.width = 0 }
///             .append { offset.height = 0 }
///             .repeat(delay: 1.0)
///         }
///     }
///
public struct AnimationSequence: Sendable {
    /// Style of animation, correspond roughly to ``SwiftUI.Animation``
    public enum Style: Sendable, Equatable {
        /// ``SwiftUI.Animation.linear``
        case linear
        /// ``SwiftUI.Animation.easeIn``
        case easeIn
        /// ``SwiftUI.Animation.easeOut``
        case easeOut
        /// ``SwiftUI.Animation.easeInOut``
        case easeInOut
        /// ``SwiftUI.Animation.bouncy``
        case bouncy
    }

    @MainActor
    struct Step: Sendable {
        /// Style of animation for this step
        let style: Style
        /// Duration of this animation
        let duration: TimeInterval
        /// Delay to start of *next* animation step
        let delay: TimeInterval
        /// Changes to animate
        let block: @MainActor @Sendable () -> Void

        /// Create an animation with the requested duration
        var animation: Animation {
            switch style {
            case .linear:
                return .linear(duration: duration)
            case .easeIn:
                return .easeIn(duration: duration)
            case .easeOut:
                return .easeOut(duration: duration)
            case .easeInOut:
                return .easeInOut(duration: duration)
            case .bouncy:
                return .bouncy(duration: duration)
            }
        }
    }

    /// Default animation style
    public static let defaultAnimation: Style = .easeInOut

    /// Default animation duration
    public static let defaultDuration = 0.1

    /// Delay to be applied to new animations.  If a nil delay
    /// is specified, the duration will be used as the delay.
    let delay: TimeInterval?

    /// Duration to be applied to future animations
    let duration: TimeInterval

    /// Style to be applied to future animations
    let style: Style

    /// List of animation steps to apply
    let animations: [Step]

    /// Private copy constructor
    /// - parameters:
    ///     - style: default Style to be applied to animations
    ///     - delay: default delay to be applied to animations
    ///     - duration: default duration to be applied to animations
    ///     - list of animations to apply
    private init(
        style: Style,
        delay: TimeInterval?,
        duration: TimeInterval,
        animations: [Step]
    ) {
        self.style = style
        self.delay = delay
        self.duration = duration
        self.animations = animations
    }

    /// Default public constructor
    /// - parameters:
    ///     - style: default Style to be applied to animations
    ///     - delay: default delay to be applied to animations
    ///     - duration: default duration to be applied to animations
    public init(
        style: Style = Self.defaultAnimation,
        delay: TimeInterval? = nil,
        duration: TimeInterval = Self.defaultDuration
    ) {
        self.style = style
        self.delay = delay
        self.duration = duration
        self.animations = []
    }

    /// Apply a new style to future applied animations
    ///
    /// Note: This will not affect animations already added via ``append(style:delay:duration:block:)``
    ///
    /// - parameter style: New animation style to apply
    /// - returns: Updated `AnimationSequence`
    public func style(_ style: Style) -> AnimationSequence {
        AnimationSequence(
            style: style,
            delay: delay,
            duration: duration,
            animations: animations
        )
    }

    /// Apply a new delay to future applied animations
    ///
    /// Note: This will not affect animations already added via ``append(style:delay:duration:block:)``
    ///
    /// - parameter delay: Delay to apply to new animations.
    /// - returns: Updated `AnimationSequence`
    public func delay(_ delay: TimeInterval?) -> AnimationSequence {
        AnimationSequence(
            style: style,
            delay: delay,
            duration: duration,
            animations: animations
        )
    }

    /// Apply a new duration to future applied animations
    ///
    /// Note: This will not affect animations already added via ``append(style:delay:duration:block:)``
    ///
    /// - parameter duration: New animation duration to apply
    /// - returns: Updated `AnimationSequence`
    public func duration(_ duration: TimeInterval) -> AnimationSequence {
        AnimationSequence(
            style: style,
            delay: delay,
            duration: duration,
            animations: animations
        )
    }

    /// Add a new animation to the sequence
    /// - parameters:
    ///     - style: `Style` of animation to add.  If nil or not specified the default style for the
    ///     sequence will be applied.
    ///     - delay: delay of animation to add.  If nil or not specified, the default delay for the
    ///     sequence will be applied.
    ///     - duration: duration of animation to add.  If nil or not specified, the default duration for the
    ///     sequence will be applied
    ///     - block: the actual changes to animate
    /// - returns: Updated `AnimationSequence`
    public func append(
        style: Style? = nil,
        delay: TimeInterval? = nil,
        duration: TimeInterval? = nil,
        block: @Sendable @MainActor @escaping () -> Void
    ) -> AnimationSequence {
        AnimationSequence(
            style: self.style,
            delay: self.delay,
            duration: self.duration,
            animations: self.animations + [
                Step(
                    style: style ?? self.style,
                    duration: duration ?? self.duration,
                    delay: delay ?? self.delay ?? duration ?? self.duration,
                    block: block
                )
            ]
        )
    }

    /// Start the animation sequence running
    /// - parameter completion: optional block to call on completion of the animation sequence.
    @MainActor
    public func start(completion: (() -> Void)? = nil) {
        var offset: TimeInterval = 0.0

        animations.indices.forEach { index in
            let animation = animations[index]

            if #available(iOS 17.0, macOS 14.0, *) {
                withAnimation(animation.animation.delay(offset)) {
                    animation.block()
                } completion: {
                    if index + 1 == animations.endIndex {
                        completion?()
                    }
                }

                offset += animation.delay
            } else {
                withAnimation(animation.animation.delay(offset)) {
                    animation.block()
                }

                offset += animation.delay

                if index + 1 == animations.endIndex, let completion = completion {
                    Task {
                        try await Task.sleep(nanoseconds: offset.nanoseconds)

                        completion()
                    }
                }
            }
        }
    }

    /// Start the animation sequence running repeatedly
    /// - parameters:
    ///     - count: number of times to repeat the animation.  Defaults to Int.max
    ///     - delay: seconds to delay after each iteration of the sequence.
    public func `repeat`(
        count: Int = .max,
        delay: TimeInterval? = nil
    ) async {
        for _ in 0 ..< count {
            if Task.isCancelled {
                break
            }

            await withUnsafeContinuation { context in
                Task { @MainActor in
                    start { context.resume() }
                }
            }

            if let delay {
                try? await Task.sleep(nanoseconds: delay.nanoseconds)
            }
        }
    }
}

private extension TimeInterval {
    var nanoseconds: UInt64 {
        UInt64(self * 1e9)
    }
}

#Preview {
    TypingIndicator()
}
