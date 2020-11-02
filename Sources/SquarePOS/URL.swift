import Foundation

extension URL {
    static let install: Self = Self(string: "https://apps.apple.com/app/square-point-of-sale-pos/id335393788")!
    static let query: Self = Self(string: "square-commerce-v1://")!
    
    static func query(payment request: Request) throws -> Self {
        guard let data: String = String(data: try JSONEncoder().encode(request), encoding: .utf8),
              let url: Self = Self(string: "\(query.absoluteString)payment/create?data=\(try data.percentEncoded())") else {
            throw Error.dataNotValid
        }
        return url
    }
    
    static func callback(scheme: String? = nil) -> Self {
        var string: String = "//square-pos"
        if let scheme: String = scheme, !scheme.isEmpty {
            string = "\(scheme):\(string)"
        }
        return URL(string: string)!
    }
    
    var isCallback: Bool {
        return host == Self.callback().host
    }
    
    var response: Response? {
        guard isCallback,
            let components: URLComponents = URLComponents(string: absoluteString),
            let queryItem: URLQueryItem = components.queryItems?.filter({ $0.name == "data" }).first,
            let data: Data = queryItem.value?.data(using: .utf8) else {
            return nil
        }
        return try? JSONDecoder().decode(Response.self, from: data)
    }
}
