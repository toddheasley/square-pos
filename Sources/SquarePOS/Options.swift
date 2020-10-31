import Foundation

public struct Options {
    public enum Tender: String, CaseIterable, Encodable {
        case card = "CREDIT_CARD"
        case cardOnFile = "CARD_ON_FILE"
        case giftCard = "SQUARE_GIFT_CARD"
        case cash = "CASH"
        case other = "OTHER"
    }
    
    public static let `default`: Self = Self()
    
    public let supportedTender: [Tender]
    public let clearDefaultFees: Bool
    public let disableCNP: Bool
    public let skipReceipt: Bool
    public let autoReturn: Bool
    
    public init(supportedTender: [Tender] = Tender.allCases, clearDefaultFees: Bool = true, disableCNP: Bool = false, skipReceipt: Bool = false, autoReturn: Bool = true) {
        self.supportedTender = supportedTender
        self.clearDefaultFees = clearDefaultFees
        self.disableCNP = disableCNP
        self.skipReceipt = skipReceipt
        self.autoReturn = autoReturn
    }
}

extension Options: Encodable {
    
    // MARK: Encodable
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encode(supportedTender, forKey: .supportedTender)
        try container.encode(clearDefaultFees, forKey: .clearDefaultFees)
        try container.encode(disableCNP, forKey: .disableCNP)
        try container.encode(skipReceipt, forKey: .skipReceipt)
        try container.encode(autoReturn, forKey: .autoReturn)
    }
    
    private enum Key: String, CodingKey {
        case supportedTender = "supported_tender_types", clearDefaultFees = "clear_default_fees", disableCNP = "disable_cnp", skipReceipt = "skip_receipt", autoReturn = "auto_return"
    }
}
