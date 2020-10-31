import Foundation

public struct Currency: Identifiable, Equatable, CustomStringConvertible {
    public let code: String
    
    public init?(iso4217 code: String) {
        guard let currency: Self = Self.from(iso4217: code) else {
            return nil
        }
        self = currency
    }
    
    static func from(iso4217 code: String) -> Self? {
        return allCases.filter { $0.code == code.uppercased() }.first
    }
    
    let cents: Int
    
    private init(id: Int, code: String, description: String, cents: Int = 100) {
        self.id = id
        self.code = code
        self.description = description
        self.cents = cents
    }
    
    // MARK: Identifiable
    public let id: Int
    
    // MARK: CustomStringConvertible
    public let description: String
}

extension Currency: CaseIterable {
    public static let auto: Self = .usd
    
    public static var aud: Self {
        return Self(id: 036, code: "AUD", description: "Australian dollar")
    }
    
    public static var cad: Self {
        return Self(id: 124, code: "CAD", description: "Canadian dollar")
    }
    
    public static var usd: Self {
        return Self(id: 840, code: "USD", description: "United States dollar")
    }
    
    static var jpy: Self {
        return Self(id: 392, code: "JPY", description: "Japanese yen", cents: 1)
    }
    
    // MARK: CaseIterable
    public static var allCases: [Self] {
        return [.aud, .cad, .usd]
    }
}

extension Currency: Encodable {
    
    // MARK: Encodable
    public func encode(to encoder: Encoder) throws {
        var container: SingleValueEncodingContainer = encoder.singleValueContainer()
        try container.encode(code)
    }
}
