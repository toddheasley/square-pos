import XCTest
@testable import SquarePOS

final class MoneyTests: XCTestCase {
    func testCents() {
        XCTAssertEqual(Money(19.99, currency: .usd).cents, 1999)
        XCTAssertEqual(Money(0.99, currency: .usd).cents, 99)
        XCTAssertEqual(Money(1999.0, currency: .jpy).cents, 1999)
    }
}

extension MoneyTests {
    
    // MARK: Encodable
    func testEncode() {
        XCTAssertEqual(try JSONEncoder().encode(Money(19.99, currency: .usd)), MoneyTests_Data)
    }
}

private let MoneyTests_Data: Data = """
{"amount":1999,"currency_code":"USD"}
""".data(using: .utf8)!
