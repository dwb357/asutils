//
// 
//

import Testing
import Foundation
@testable import asutils_core

final class URLComponentsBuilderTests {
    @Test
    func testWithScheme() {
        let start = URLComponents(string: "http://some.where")!

        #expect(
            "https://some.where" == start.scheme("https").url?.absoluteString
        )
    }

    @Test
    func testWithHost() {
        let start = URLComponents(string: "http://some.where")!

        #expect(
            "http://some.where.com" == start.host("some.where.com").url?.absoluteString
        )
    }

    @Test
    func testWithUser() {
        let start = URLComponents(string: "http://some.where")!

        #expect(
            "http://dwb@some.where" == start.user("dwb").url?.absoluteString
        )
    }

    @Test
    func testWithPassword() {
        let start = URLComponents(string: "http://some.where")!

        #expect(
            "http://dwb:password@some.where" ==
            start.user("dwb")
                .password("password")
                .url?
                .absoluteString
        )
    }

    @Test
    func testWithPathNoRoot() {
        let start = URLComponents(string: "http://some.where")!

        #expect(
            "http://some.where/a/b" ==
            start.path("a/b").url?.absoluteString
        )
    }

    @Test
    func testWithPathRoot() {
        let start = URLComponents(string: "http://some.where")!

        #expect(
            "http://some.where/a/b" ==
            start.path("/a/b").url?.absoluteString
        )
    }

    @Test
    func testAppendPathFileRelative() {
        let start = URLComponents(string: "http://some.where/a")!

        #expect(
            "http://some.where/a/b" ==
            start.append(path: "b").url?.absoluteString
        )
    }

    @Test
    func testAppendPathFileAbsolute() {
        let start = URLComponents(string: "http://some.where/a")!

        #expect(
            "http://some.where/a/b" ==
            start.append(path: "/b").url?.absoluteString
        )
    }

    @Test
    func testAppendPathDirectoryRelative() {
        let start = URLComponents(string: "http://some.where/a/")!

        #expect(
            "http://some.where/a/b" ==
            start.append(path: "b").url?.absoluteString
        )
    }

    @Test
    func testAppendPathDirectoryAbsolute() {
        let start = URLComponents(string: "http://some.where/a/")!

        #expect(
            "http://some.where/a/b" ==
            start.append(path: "/b").url?.absoluteString
        )
    }

    @Test
    func testAppendingPathElementsDirectory() {
        let start = URLComponents(string: "http://some.where/a/")!

        #expect(
            "http://some.where/a/b/c" ==
            start.append(elements: "b", "c").url?.absoluteString
        )
    }

    @Test
    func testAppendingPathElementsFile() {
        let start = URLComponents(string: "http://some.where/a")!

        #expect(
            "http://some.where/a/b/c" ==
            start.append(elements: "b", "c").url?.absoluteString
        )
    }

    @Test
    func testAppendingPathElementsEscaping() {
        let start = URLComponents(string: "http://some.where/a")!

        #expect(
            "http://some.where/a/b%20c&d" ==
            start.append(elements: "b c&d").url?.absoluteString
        )
    }

    @Test
    func testQueryEscaping() {
        let start = URLComponents(string: "http://some.where/a")!

        #expect(
            "http://some.where/a?q=a%20b" ==
            start.append(query: "q", value: "a b").url?.absoluteString
        )
    }

    @Test
    func testQueries() {
        let start = URLComponents(string: "http://some.where/a")!

        #expect(
            "http://some.where/a?a=b&c" ==
            start
                .query(("a", "b"), ("c", String?.none))
                .url?
                .absoluteString
        )
    }
}
