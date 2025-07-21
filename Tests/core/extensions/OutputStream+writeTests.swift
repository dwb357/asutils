//
// © Copyright 2024, David W. Berry. All Rights Reserved.
//

import ASCore
import Foundation
import Testing

@Test
func testDataWrite() throws {
    let dataSize = 64
    let data = Data.random(count: dataSize)

    let stream = OutputStream(toMemory: ())

    try stream.use { stream in
        stream.open()

        try stream.write(data)

        stream.close()
    }

    let written = stream.property(forKey: Stream.PropertyKey.dataWrittenToMemoryStreamKey) as? Data

    #expect(data == written)
}

@Test
func testStringWrite() throws {
    let stream = OutputStream(toMemory: ())

    try stream.use { stream in
        stream.open()

        try stream.write("Hello World!\n")

        stream.close()
    }

    let written = stream.property(forKey: Stream.PropertyKey.dataWrittenToMemoryStreamKey) as? Data

    #expect(Data("Hello World!\n".utf8) == written)
}
