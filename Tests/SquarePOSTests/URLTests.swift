import XCTest
@testable import SquarePOS

final class URLTests: XCTestCase {
    
}

extension URLTests {
    func testApp() {
        XCTAssertEqual(URL.app.absoluteString, "https://apps.apple.com/app/square-point-of-sale-pos/id335393788")
    }
    
    func testQuery() {
        
    }
}
