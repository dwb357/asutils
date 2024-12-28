//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

@testable import ASUIKit
import Testing

struct AnimationSequenceTests {
    static let delay = 0.2
    static let duration = 0.9
    static let defaultDuration = 0.1

    @Test
    func basicDefaultInitialization() {
        let sequence = AnimationSequence()

        #expect(sequence.style == .easeInOut)
        #expect(sequence.delay == nil)
        #expect(sequence.duration == Self.defaultDuration)
    }

    @Test
    func basicInitialization() {
        let sequence = AnimationSequence(
            style: .linear,
            delay: Self.delay,
            duration: Self.duration
        )

        #expect(sequence.style == .linear)
        #expect(sequence.delay == Self.delay)
        #expect(sequence.duration == Self.duration)
    }

    @Test
    func styleUpdatesDefault() {
        let sequence = AnimationSequence().style(.bouncy)

        #expect(sequence.style == .bouncy)
    }

    @Test
    func delayUpdatesDefault() async throws {
        let sequence = AnimationSequence().delay(Self.delay)

        #expect(sequence.delay == Self.delay)
    }

    @Test
    func durationUpdatesDefault() async throws {
        let sequence = AnimationSequence().duration(Self.duration)

        #expect(sequence.duration == Self.duration)
    }

    @MainActor
    @Test
    func appendAppliesDefaults() {
        let sequence = AnimationSequence(
            style: .linear,
            delay: Self.delay,
            duration: Self.duration
        ).append {
            // nothing to do
        }

        #expect(sequence.animations.count == 1)

        let step = sequence.animations.first

        #expect(step?.style == .linear)
        #expect(step?.delay == Self.delay)
        #expect(step?.duration == Self.duration)
    }

    @MainActor
    @Test
    func appendAppliesCustomValues() {
        let sequence = AnimationSequence(
            style: .linear,
            delay: Self.delay,
            duration: Self.duration
        ).append(
            style: .bouncy,
            delay: Self.delay,
            duration: Self.duration
        ) {
            // Nothing to do
        }

        #expect(sequence.animations.count == 1)

        let step = sequence.animations.first

        #expect(step?.style == .bouncy)
        #expect(step?.delay == Self.delay)
        #expect(step?.duration == Self.duration)
    }
}
