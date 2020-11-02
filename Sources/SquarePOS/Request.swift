import Foundation

public struct Request {
    public let money: Money
    public let options: Options
    
    public init(money: Money, options: Options = .default) {
        self.money = money
        self.options = options
    }
    
    static var app: (id: String?, scheme: String?) = (nil, Bundle.main.scheme) {
        didSet {
            if (app.scheme ?? "").isEmpty, let scheme: String = Bundle.main.scheme, !scheme.isEmpty {
                app.scheme = scheme
            }
        }
    }
}

extension Request: Encodable {
    
    // MARK: Encodable
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Key> = encoder.container(keyedBy: Key.self)
        try container.encode(try id(), forKey: .appID)
        try container.encode(money, forKey: .money)
        try container.encode(options, forKey: .options)
        try container.encode(try callback().absoluteString, forKey: .callbackURL)
        try container.encode("3.5.0", forKey: .versionSDK)
        try container.encode("1.3", forKey: .version)
    }
    
    private func id() throws -> String {
        guard let id: String = Self.app.id, !id.isEmpty else {
            throw Error.appIDNotFound
        }
        return id
    }
    
    private func callback() throws -> URL {
        guard let scheme: String = Self.app.scheme, !scheme.isEmpty else {
            throw Error.appSchemeNotFound
        }
        return .callback(scheme: scheme)
    }
    
    private enum Key: String, CodingKey {
        case appID = "client_id", money = "amount_money", options, callbackURL = "callback_url", versionSDK = "sdk_version", version
    }
}
