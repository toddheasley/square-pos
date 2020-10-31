import XCTest
@testable import SquarePOS

final class OptionsTests: XCTestCase {
    
}

extension OptionsTests {
    
    // MARK: Encodable
    func testEncode() {
        XCTAssertEqual(try JSONEncoder().encode(Options()), OptionsTests_Data)
    }
}

private let OptionsTests_Data: Data = """
{"auto_return":true,"skip_receipt":false,"disable_cnp":false,"clear_default_fees":true,"supported_tender_types":["CREDIT_CARD","CARD_ON_FILE","SQUARE_GIFT_CARD","CASH","OTHER"]}
""".data(using: .utf8)!
