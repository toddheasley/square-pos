import XCTest
@testable import SquarePOS

final class ResponseTests: XCTestCase {
    
}

extension ResponseTests {
    
    // MARK: Decodable
    func testDecoderInit() throws {
        let responses: [Response] = try JSONDecoder().decode([Response].self, from: ResponseTests_Data)
        switch responses[0] {
        case .ok(let transaction):
            XCTAssertEqual(transaction.clientID, "8E3AF970-0607-ED4D-9A28-AAFB2A3CBB31")
            XCTAssertEqual(transaction.id, "a5eVaGObRVGjmiXpm5zhSn716")
        case .error:
            XCTFail()
        }
        switch responses[1] {
        case .error(let error):
            XCTAssertEqual(error, .paymentCanceled)
        case .ok:
            XCTFail()
        }
    }
}

private let ResponseTests_Data: Data = """
[{"status":"ok","transaction_id":"a5eVaGObRVGjmiXpm5zhSn716","client_transaction_id":"8E3AF970-0607-ED4D-9A28-AAFB2A3CBB31"},{"status":"error","error_code":"payment_canceled"}]
""".data(using: .utf8)!
