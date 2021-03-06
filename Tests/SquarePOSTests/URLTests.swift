import XCTest
@testable import SquarePOS

final class URLTests: XCTestCase {
    
}

extension URLTests {
    func testInstall() {
        XCTAssertEqual(URL.install.absoluteString, "https://apps.apple.com/app/square-point-of-sale-pos/id335393788")
    }
    
    func testQuery() {
        XCTAssertEqual(URL.query.absoluteString, "square-commerce-v1://")
    }
    
    func testRequestQuery() {
        let request: Request = Request(money: Money(19.99, currency: .usd))
        do {
            let _: URL = try URL.query(payment: request)
        } catch {
            XCTAssertEqual(error as? Error, .appIDNotFound)
        }
        Request.app.id = "sqU@r3-aPP1ic@+i0n-iD"
        do {
            let _: URL = try URL.query(payment: request)
        } catch {
            XCTAssertEqual(error as? Error, .appSchemeNotFound)
        }
        Request.app.scheme = "scheme"
        XCTAssertEqual(try URL.query(payment: request), URLTests_URLs[0])
    }
    
    func testCallback() {
        XCTAssertEqual(URL.callback(scheme: "scheme").absoluteString, "scheme://square-pos")
        XCTAssertEqual(URL.callback().absoluteString, "//square-pos")
    }
    
    func testIsCallback() {
        XCTAssertFalse(URL(string: "square-pos://scheme")!.isCallback)
        XCTAssertTrue(URL(string: "scheme://square-pos")!.isCallback)
        XCTAssertTrue(URL(string: "//square-pos")!.isCallback)
    }
    
    func testResponse() {
        XCTAssertEqual(URLTests_URLs[1].response?.transaction?.clientID, "3AF98E70-0706-4EDD-A928-BB33C1AAFB2A")
        XCTAssertEqual(URLTests_URLs[1].response?.transaction?.id, "aGOiXpmbRVGjm5zhSn716a5eV")
        XCTAssertEqual(URLTests_URLs[2].response?.error , .paymentCanceled)
        XCTAssertNil(URLTests_URLs[3].response)
    }
}

private let URLTests_URLs: [URL] = [
    URL(string: "square-commerce-v1://payment/create?data=%7B%22client_id%22%3A%22sqU%40r3-aPP1ic%40%2Bi0n-iD%22%2C%22amount_money%22%3A%7B%22amount%22%3A1999%2C%22currency_code%22%3A%22USD%22%7D%2C%22options%22%3A%7B%22auto_return%22%3Atrue%2C%22skip_receipt%22%3Afalse%2C%22disable_cnp%22%3Afalse%2C%22clear_default_fees%22%3Atrue%2C%22supported_tender_types%22%3A%5B%22CREDIT_CARD%22%2C%22CARD_ON_FILE%22%2C%22SQUARE_GIFT_CARD%22%2C%22CASH%22%2C%22OTHER%22%5D%7D%2C%22callback_url%22%3A%22scheme%3A%5C%2F%5C%2Fsquare-pos%22%2C%22sdk_version%22%3A%223.5.0%22%2C%22version%22%3A%221.3%22%7D")!,
    URL(string: "scheme://square-pos/square_request?data=%7B%22status%22%3A%22ok%22%2C%22transaction_id%22%3A%22aGOiXpmbRVGjm5zhSn716a5eV%22%2C%22client_transaction_id%22%3A%223AF98E70-0706-4EDD-A928-BB33C1AAFB2A%22%7D")!,
    URL(string: "scheme://square-pos/square_request?data=%7B%22error_code%22%3A%22payment_canceled%22%2C%22status%22%3A%22error%22%7D")!,
    URL(string: "scheme://square-pos/square_request?data=%7B%22error_code%22payment_canceled%22%2C%22status%22%3A%22error%22")!
]

