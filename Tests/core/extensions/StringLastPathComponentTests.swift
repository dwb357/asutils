//
// © Copyright 2024, David W. Berry. All Rights Reserved.
//

import ASCore
import Testing

struct StringLastPathComponentTests {
    @Test
    func emptyString() {
        #expect("".lastPathComponent.isEmpty)
    }

    @Test
    func trailingSlash() {
        #expect("/a/".lastPathComponent == "a")
    }

    @Test
    func singleComponent() {
        #expect("a".lastPathComponent == "a")
    }

    @Test
    func multipleComponents() {
        #expect("a/b/c".lastPathComponent == "c")
    }
}
