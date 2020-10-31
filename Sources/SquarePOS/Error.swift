import Foundation

public struct Error: Swift.Error, Identifiable, Equatable, CustomStringConvertible {
    public init?(id: String) {
        guard let error: Self = Self.from(id: id) else {
            return nil
        }
        self = error
    }
    
    static func from(id: String) -> Self? {
        return allCases.filter { $0.id == id.lowercased() }.first
    }
    
    private init(id: String, description: String) {
        self.id = id
        self.description = description
    }
    
    // MARK: Identifiable
    public let id: String
    
    // MARK: CustomStringConvertible
    public let description: String
}

extension Error: CaseIterable {
    public static var appIDNotFound: Self {
        return Self(id: "app_id_missing", description: "Square developer application ID is not configured")
    }
    
    public static var appNotInstalled: Self {
        return Self(id: "app_not_installed", description: "Square app is not installed")
    }
    
    public static var appNotActive: Self {
        return Self(id: "not_logged_in", description: "Square app is not configured to process payments")
    }
    
    public static var accountNotActive: Self {
        return Self(id: "user_not_active", description: "Square account is not accepting payments")
    }
    
    public static var currencyNotAccepted: Self {
        return Self(id: "currency_code_mismatch", description: "Square account does not accept the requested currency")
    }
    
    public static var currencyNotSupported: Self {
        return Self(id: "unsupported_currency_code", description: "Square does not support the requested currency")
    }
    
    public static var currencyNotFound: Self {
        return Self(id: "currency_code_missing", description: "Square does not recognize the requested currency")
    }
    
    public static var amountTooSmall: Self {
        return Self(id: "amount_too_small", description: "Square payment amount is below the minimum credit card charge")
    }
    
    public static var amountTooLarge: Self {
        return Self(id: "amount_too_large", description: "Square payment amount exceeds the maximum credit card charge")
    }
    
    public static var amountNotValid: Self {
        return Self(id: "amount_invalid_format", description: "Square payment amount is not correct")
    }
    
    public static var tenderNotSupported: Self {
        return Self(id: "unsupported_tender_type", description: "Square does not support the requested tender")
    }
    
    public static var tenderNotFound: Self {
        return Self(id: "invalid_tender_type", description: "Square does not recognize the requested tender")
    }
    
    public static var networkNotConnected: Self {
        return Self(id: "no_network_connection", description: "Square could not connect to the Internet")
    }
    
    public static var versionNotSupported: Self {
        return Self(id: "unsupported_api_version", description: "Square does not support the requested API version")
    }
    
    public static var versionNotFound: Self {
        return Self(id: "invalid_version_number", description: "Square does not recognize the requested API version")
    }
    
    public static var customerManagementNotSupported: Self {
        return Self(id: "customer_management_not_supported", description: "Square account does not allow customer management")
    }
    
    public static var customerNotFound: Self {
        return Self(id: "invalid_customer_id", description: "Square account does not recognize the customer")
    }
    
    public static var paymentCanceled: Self {
        return Self(id: "payment_canceled", description: "Square payment was canceled")
    }
    
    public static var dataNotValid: Self {
        return Self(id: "data_invalid", description: "Square payment request could not be understood")
    }
    
    // MARK: CaseIterable
    public static var allCases: [Self] {
        return [.appIDNotFound, .appNotInstalled, .appNotActive, .accountNotActive, .currencyNotAccepted, .currencyNotSupported, .currencyNotFound, .amountTooSmall, .amountTooLarge, .amountNotValid, .tenderNotSupported, .tenderNotFound, .networkNotConnected, .versionNotSupported, .versionNotFound, .customerManagementNotSupported, .customerNotFound, .paymentCanceled, .dataNotValid]
    }
}

extension Error: Decodable {
    
    // MARK: Decodable
    public init(from decoder: Decoder) throws {
        let container: SingleValueDecodingContainer = try decoder.singleValueContainer()
        let id: String =  try container.decode(String.self)
        self = Self(id: id) ?? .dataNotValid
    }
}
