import Foundation

public struct Request {
    public let money: Money
    public let options: Options
    public let callbackURL: URL
    
    public var appID: String? {
        return Self.appID
    }
    
    public init(money: Money, options: Options = .default, callback url: URL) {
        self.money = money
        self.options = options
        callbackURL = url
    }
    
    static var appID: String?
}

extension Request: Encodable {
    
    // MARK: Encodable
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        guard let appID: String = Self.appID, !appID.isEmpty else {
            throw Error.appIDNotFound
        }
        try container.encode(appID, forKey: .appID)
        try container.encode(money, forKey: .money)
        try container.encode(options, forKey: .options)
        try container.encode(callbackURL.absoluteString, forKey: .callbackURL)
        try container.encode("3.5.0", forKey: .versionSDK)
        try container.encode("1.3", forKey: .version)
    }
    
    private enum Key: String, CodingKey {
        case appID = "client_id", money = "amount_money", options, callbackURL = "callback_url", versionSDK = "sdk_version", version
    }
}
