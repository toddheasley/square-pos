import Foundation

public enum Response {
    public struct Transaction: Identifiable, Equatable {
        public let clientID: String
        
        // MARK: Identifiable
        public let id: String
    }
    
    case ok(Transaction), error(Error)
    
    public var transaction: Transaction? {
        switch self {
        case .ok(let transaction):
            return transaction
        default:
            return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .error(let error):
            return error
        default:
            return nil
        }
    }
}

extension Response: Equatable {
    
    // MARK: Equatable
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        switch lhs {
        case .ok(let transaction):
            return transaction == rhs.transaction
        case .error(let error):
            return error == rhs.error
        }
    }
}

extension Response: Decodable {
    
    // MARK: Decodable
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Key> = try decoder.container(keyedBy: Key.self)
        switch try container.decode(String.self, forKey: .status) {
        case "ok":
            let id: String = try container.decode(String.self, forKey: .transactionID)
            let clientID: String = try container.decode(String.self, forKey: .clientTransactionID)
            self = .ok(Transaction(clientID: clientID, id: id))
        default:
            let id: String = (try? container.decode(String.self, forKey: .errorID)) ?? ""
            self = .error(Error(id: id) ?? .dataNotValid)
        }
    }
    
    private enum Key: String, CodingKey {
        case status, transactionID = "transaction_id", clientTransactionID = "client_transaction_id", errorID = "error_code"
    }
}
