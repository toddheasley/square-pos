import XCTest
@testable import SquarePOS

final class RequestTests: XCTestCase {
    
}

extension RequestTests {
    
    // MARK: Encodable
    func testEncode() {
        Request.app = ("sqU@r3-aPP1ic@+i0n-iD", "scheme")
        let request: Request = Request(money: Money(19.99, currency: .usd))
        XCTAssertEqual(try JSONEncoder().encode(request), RequestTests_Data)
    }
}

private let RequestTests_Data: Data = """
{"client_id":"sqU@r3-aPP1ic@+i0n-iD","amount_money":{"amount":1999,"currency_code":"USD"},"options":{"auto_return":true,"skip_receipt":false,"disable_cnp":false,"clear_default_fees":true,"supported_tender_types":["CREDIT_CARD","CARD_ON_FILE","SQUARE_GIFT_CARD","CASH","OTHER"]},"callback_url":"scheme:\\/\\/square-pos","sdk_version":"3.5.0","version":"1.3"}
""".data(using: .utf8)!
