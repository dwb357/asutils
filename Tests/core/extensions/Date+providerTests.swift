//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Testing
import Foundation
import asutils_core

@Test func testDateProvider() {
    let now = Date(timeIntervalSinceNow: -100)

    Date.provider = { now }

    #expect(Date.current == now)
}
