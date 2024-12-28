//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import ASCore
import Foundation
import Testing

class StreamUseTests {
    private class MockOutputStream: OutputStream {
        var opens = 0
        var closes = 0
        var isOpen = false

        override func open() {
            opens += 1
            isOpen = true
        }

        override func close() {
            closes += 1
            isOpen = false
        }
    }

    private class MockInputStream: InputStream {
        var opens = 0
        var closes = 0
        var isOpen = false

        override func open() {
            opens += 1
            isOpen = true
        }

        override func close() {
            closes += 1
            isOpen = false
        }
    }

    @Test
    func outputStreamUseOpensAndCloses() throws {
        let expect = MockOutputStream()
        #expect(expect.opens == 0)
        #expect(expect.closes == 0)

        try expect.use { stream in
            #expect(expect === stream)
            #expect(stream.isOpen)
        }

        #expect(expect.opens == 1)
        #expect(expect.closes == 1)
        #expect(expect.isOpen == false)
    }

    @Test
    func inputStreamUseOpensAndCloses() throws {
        let expect = MockInputStream()
        #expect(expect.opens == 0)
        #expect(expect.closes == 0)

        try expect.use { stream in
            #expect(expect === stream)
            #expect(stream.isOpen)
        }

        #expect(expect.opens == 1)
        #expect(expect.closes == 1)
        #expect(expect.isOpen == false)
    }
}
