//
// © Copyright 2024, David W. Berry. All Rights Reserved.
//

import SwiftUI

public extension View {
    /// Apply a block only if a given value is not nil.
    /// - parameters:
    ///     - value: Value to test
    ///     - then: Block to execute if `value` is not nil. `then` will be invoked
    ///     with the receiver and `value.wrapped` as parameters.
    ///     - else: Block to execute if `value` is nil. `else` will be invoked
    ///     with the receiver as it's only parameter.
    /// - returns: the result of `then` or `else` as appropriate, wrapped in a
    /// `_ConditionalContent`.
    func `if`<Value, Then: View, Else: View>(
        _ value: @autoclosure () -> Value?,
        then: (Self, Value) -> Then,
        else: (Self) -> Else
    ) -> _ConditionalContent<Then, Else> {
        if let value = value() {
            ViewBuilder.buildEither(first: then(self, value))
        } else {
            ViewBuilder.buildEither(second: `else`(self))
        }
    }

    /// Apply a block only if a given value is not nil.
    /// - parameters:
    ///     - value: Value to test
    ///     - then: Block to execute if `value` is not nil. `then` will be invoked
    ///     with the receiver and `value.wrapped` as parameters.
    /// - returns: the result of `then` or `self` as appropriate, wrapped in a
    /// `_ConditionalContent`.
    func `if`<Value, Then: View>(
        _ value: @autoclosure () -> Value?,
        then: (Self, Value) -> Then
    ) -> _ConditionalContent<Then, Self> {
        if let value = value() {
            ViewBuilder.buildEither(first: then(self, value))
        } else {
            ViewBuilder.buildEither(second: self)
        }
    }

    /// Apply a block only if a given value is true
    func `if`<Then: View>(
        _ value: @autoclosure() -> Bool,
        then: (Self) -> Then
    ) -> _ConditionalContent<Then, Self> {
        if value() {
            ViewBuilder.buildEither(first: then(self))
        } else {
            ViewBuilder.buildEither(second: self)
        }
    }

    /// Apply a block only if a given value is true
    func `if`<Then: View, Else: View>(
        _ value: @autoclosure() -> Bool,
        then: (Self) -> Then,
        else: (Self) -> Else
    ) -> _ConditionalContent<Then, Else> {
        if value() {
            ViewBuilder.buildEither(first: then(self))
        } else {
            ViewBuilder.buildEither(second: `else`(self))
        }
    }
}
