import XCTest
@testable import SquarePOS

final class StringTests: XCTestCase {
    
}

extension StringTests {
    func testPercentEncoded() {
        XCTAssertEqual(try "{\"urls\":[\"scheme://square-pos\"],}".percentEncoded(), "%7B%22urls%22%3A%5B%22scheme%3A%2F%2Fsquare-pos%22%5D%2C%7D")
    }
}
