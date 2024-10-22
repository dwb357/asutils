//
//  TypingIndicator.swift
//  ASUtils-UI
//
//  © Copyright 2024 David W. Berry. All Rights Reserved.
//

import SwiftUI

#if DEBUG

struct TypingIndicator: View {
    static let dotSize: CGFloat = 30.0
    static let offset = dotSize / 2
    static let dotCount = 3
    static let animationTime = 0.5
    static let spacing = 2.0
    static let repeatDelay = 0.5

    @State var dotState = [CGFloat](repeatElement(0.0, count: Self.dotCount))

    var body: some View {
        HStack(alignment: .bottom, spacing: Self.spacing) {
            ForEach(dotState.indices, id: \.self) { index in
                dot(offset: dotState[index])
            }
        }
        .background(Color.gray)
        .task {
            await dotState.indices.reduce(
                AnimationSequence(style: .easeInOut, duration: Self.animationTime)
            ) { animation, index in
                animation
                    .append { dotState[index] = Self.offset }
                    .append { dotState[index] = 0 }
            }.repeat(delay: Self.repeatDelay)
        }
    }

    func dot(offset: CGFloat) -> some View {
        VStack {
            Circle()
                .frame(width: Self.dotSize, height: Self.dotSize)
                .foregroundColor(Color.blue)
                .offset(y: -offset)
        }
        .frame(height: Self.offset + Self.dotSize, alignment: .bottom)
    }
}

#Preview {
    TypingIndicator()
}

#endif
