//
// Copyright © 2024, David W. Berry
// All rights reserved.
//

import Testing
import Foundation
import asutils_core

@Test func testDataWrite() throws {
    let data = Data.random(count: 64)

    let stream = OutputStream(toMemory: ())

    try stream.use { stream in
        stream.open()

        try stream.write(data)

        stream.close()
    }

    let written = stream.property(forKey: Stream.PropertyKey.dataWrittenToMemoryStreamKey) as! Data

    #expect(data == written)
}

@Test func testStringWrite() throws {
    let stream = OutputStream(toMemory: ())

    try stream.use { stream in
        stream.open()

        try stream.write("Hello World!\n")

        stream.close()
    }

    let written = stream.property(forKey: Stream.PropertyKey.dataWrittenToMemoryStreamKey) as! Data

    #expect("Hello World!\n".data(using: .utf8) == written)
}
