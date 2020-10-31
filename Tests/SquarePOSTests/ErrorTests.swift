import XCTest
@testable import SquarePOS

final class ErrorTests: XCTestCase {
    func testIDInit() {
        XCTAssertEqual(Error(id: "data_invalid"), .dataNotValid)
        XCTAssertNil(Error(id: ""))
    }
    
    func testFromID() {
        XCTAssertEqual(Error.from(id: "app_id_missing"), .appIDNotFound)
        XCTAssertEqual(Error.from(id: "app_not_installed"), .appNotInstalled)
        XCTAssertEqual(Error.from(id: "not_logged_in"), .appNotActive)
        XCTAssertEqual(Error.from(id: "user_not_active"), .accountNotActive)
        XCTAssertEqual(Error.from(id: "currency_code_mismatch"), .currencyNotAccepted)
        XCTAssertEqual(Error.from(id: "unsupported_currency_code"), .currencyNotSupported)
        XCTAssertEqual(Error.from(id: "currency_code_missing"), .currencyNotFound)
        XCTAssertEqual(Error.from(id: "amount_too_small"), .amountTooSmall)
        XCTAssertEqual(Error.from(id: "amount_too_large"), .amountTooLarge)
        XCTAssertEqual(Error.from(id: "amount_invalid_format"), .amountNotValid)
        XCTAssertEqual(Error.from(id: "unsupported_tender_type"), .tenderNotSupported)
        XCTAssertEqual(Error.from(id: "invalid_tender_type"), .tenderNotFound)
        XCTAssertEqual(Error.from(id: "no_network_connection"), .networkNotConnected)
        XCTAssertEqual(Error.from(id: "unsupported_api_version"), .versionNotSupported)
        XCTAssertEqual(Error.from(id: "invalid_version_number"), .versionNotFound)
        XCTAssertEqual(Error.from(id: "customer_management_not_supported"), .customerManagementNotSupported)
        XCTAssertEqual(Error.from(id: "invalid_customer_id"), .customerNotFound)
        XCTAssertEqual(Error.from(id: "payment_canceled"), .paymentCanceled)
        XCTAssertEqual(Error.from(id: "data_invalid"), .dataNotValid)
        XCTAssertNil(Error.from(id: ""))
    }
}

extension ErrorTests {
    
    // MARK: CaseIterable
    func testAllCases() {
        XCTAssertEqual(Error.allCases, [.appIDNotFound, .appNotInstalled, .appNotActive, .accountNotActive, .currencyNotAccepted, .currencyNotSupported, .currencyNotFound, .amountTooSmall, .amountTooLarge, .amountNotValid, .tenderNotSupported, .tenderNotFound, .networkNotConnected, .versionNotSupported, .versionNotFound, .customerManagementNotSupported, .customerNotFound, .paymentCanceled, .dataNotValid])
    }
}

extension ErrorTests {
    
    // MARK: Decodable
    func testDecoderInit() {
        XCTAssertEqual(try JSONDecoder().decode(Error.self, from: ErrorTests_Data), .paymentCanceled)
        XCTAssertEqual(try JSONDecoder().decode(Error.self, from: "\"foo\"".data(using: .utf8)!), .dataNotValid)
    }
}

private let ErrorTests_Data: Data = """
"payment_canceled"
""".data(using: .utf8)!
