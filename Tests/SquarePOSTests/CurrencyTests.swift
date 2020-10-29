import XCTest
@testable import SquarePOS

final class CurrencyTests: XCTestCase {
    func testISO4217Init() {
        XCTAssertEqual(Currency(iso4217: "USD"), .usd)
        XCTAssertNil(Currency(iso4217: "FOO"))
    }
    
    func testFromISO4217() {
        XCTAssertEqual(Currency.from(iso4217: "AUD"), .aud)
        XCTAssertEqual(Currency.from(iso4217: "CAD"), .cad)
        XCTAssertEqual(Currency.from(iso4217: "USD"), .usd)
        XCTAssertNil(Currency.from(iso4217: "JPY"))
    }
}

extension CurrencyTests {
    func testAUD() {
        XCTAssertEqual(Currency.aud.id, 036)
        XCTAssertEqual(Currency.aud.code, "AUD")
        XCTAssertEqual(Currency.aud.description, "Australian dollar")
        XCTAssertEqual(Currency.aud.cents, 100)
    }
    
    func testCAD() {
        XCTAssertEqual(Currency.cad.id, 124)
        XCTAssertEqual(Currency.cad.code, "CAD")
        XCTAssertEqual(Currency.cad.description, "Canadian dollar")
        XCTAssertEqual(Currency.cad.cents, 100)
    }
    
    func testUSD() {
        XCTAssertEqual(Currency.usd.id, 840)
        XCTAssertEqual(Currency.usd.code, "USD")
        XCTAssertEqual(Currency.usd.description, "United States dollar")
        XCTAssertEqual(Currency.usd.cents, 100)
    }
    
    func testJPY() {
        XCTAssertEqual(Currency.jpy.id, 392)
        XCTAssertEqual(Currency.jpy.code, "JPY")
        XCTAssertEqual(Currency.jpy.description, "Japanese yen")
        XCTAssertEqual(Currency.jpy.cents, 1)
    }
    
    // MARK: CaseIterable
    func testAllCases() {
        XCTAssertEqual(Currency.allCases, [.aud, .cad, .usd])
    }
}
