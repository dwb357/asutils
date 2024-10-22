//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Testing
@testable import asutils_ui

struct AnimationSequenceTests {

    @Test func basicDefaultInitialization() {
        let sequence = AnimationSequence()

        #expect(sequence.style == .easeInOut)
        #expect(sequence.delay == nil)
        #expect(sequence.duration == 0.1)
    }

    @Test func basicInitialization() {
        let sequence = AnimationSequence(
            style: .linear,
            delay: 0.2,
            duration: 0.9
        )
        
        #expect(sequence.style == .linear)
        #expect(sequence.delay == 0.2)
        #expect(sequence.duration == 0.9)
    }

    @Test func styleUpdatesDefault() {
        let sequence = AnimationSequence().style(.bouncy)

        #expect(sequence.style == .bouncy)
    }

    @Test func delayUpdatesDefault() async throws {
        let sequence = AnimationSequence().delay(0.2)

        #expect(sequence.delay == 0.2)
    }

    @Test func durationUpdatesDefault() async throws {
        let sequence = AnimationSequence().duration(0.9)
        
        #expect(sequence.duration == 0.9)
    }

    @MainActor @Test func appendAppliesDefaults() {
        let sequence = AnimationSequence(
            style: .linear,
            delay: 0.2,
            duration: 0.9
        ).append {}

        #expect(sequence.animations.count == 1)

        let step = sequence.animations.first!

        #expect(step.style == .linear)
        #expect(step.delay == 0.2)
        #expect(step.duration == 0.9)
    }

    @MainActor @Test func appendAppliesCustomValues() {
        let sequence = AnimationSequence(
            style: .linear,
            delay: 0.2,
            duration: 0.9
        ).append(
            style: .bouncy,
            delay: 0.3,
            duration: 0.4
        ) {}

        #expect(sequence.animations.count == 1)

        let step = sequence.animations.first!

        #expect(step.style == .bouncy)
        #expect(step.delay == 0.3)
        #expect(step.duration == 0.4)
    }
}
