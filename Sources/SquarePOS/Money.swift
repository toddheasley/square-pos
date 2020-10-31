import Foundation

public struct Money: Equatable {
    public let currency: Currency
    public let amount: Decimal
    
    public var cents: Int {
        return Int(round((amount as NSDecimalNumber).doubleValue * Double(currency.cents)))
    }
    
    public init(_ amount: Decimal = .zero, currency: Currency) {
        self.currency = currency
        self.amount = max(amount, .zero)
    }
}

extension Money: Encodable {
    
    // MARK: Encodable
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encodeIfPresent(currency, forKey: .currency)
        try container.encode(cents, forKey: .amount)
    }
    
    private enum Key: String, CodingKey {
        case currency = "currency_code", amount
    }
}
