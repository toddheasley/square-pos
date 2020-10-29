import XCTest
@testable import SquarePOS

final class MoneyTests: XCTestCase {
    func testCents() {
        XCTAssertEqual(Money(299.99, currency: .usd).cents, 29999)
        XCTAssertEqual(Money(0.0, currency: .usd).cents, 0)
        XCTAssertEqual(Money(3000.0, currency: .jpy).cents, 3000)
    }
}
