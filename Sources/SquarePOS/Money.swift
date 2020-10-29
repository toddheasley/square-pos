import Foundation

public struct Money: Equatable {
    public let currency: Currency
    public let amount: Decimal
    
    public var cents: Int {
        return NSDecimalNumber(decimal: amount * Decimal(currency.cents)).intValue
    }
    
    public init(_ amount: Decimal = .zero, currency: Currency) {
        self.currency = currency
        self.amount = amount
    }
}
