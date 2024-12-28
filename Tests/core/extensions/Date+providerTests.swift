//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import ASCore
import Foundation
import Testing

@Test
func testDateProvider() {
    let now = Date(timeIntervalSinceNow: -100)

    Date.provider = { now }

    #expect(Date.provided == now)
}
