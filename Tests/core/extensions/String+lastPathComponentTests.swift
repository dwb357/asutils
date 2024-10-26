//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Testing
@testable import asutils_core

struct StringLastPathComponentTests {

    @Test func emptyString() {
        #expect("".lastPathComponent == "")
    }

    @Test func trailingSlash() {
        #expect("/a/".lastPathComponent == "a")
    }

    @Test func singleComponent() {
        #expect("a".lastPathComponent == "a")
    }

    @Test func multipleComponents() {
        #expect("a/b/c".lastPathComponent == "c")
    }
    
}
