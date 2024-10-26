//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import SwiftUI

/// Lazy view constructor.
///
/// The `Content` view will not be constructed until needed. Useful for ``NavigationLink``
/// content and other similar constructs.
///
/// - parameter content: build content to be lazily constructed.
public struct LazyView<Content: View>: View {
    @ViewBuilder let content: () -> Content

    /// The content and behavior of the view.
    public var body: some View {
        content()
    }
}
