import Foundation

extension URL {
    static let app: Self = Self(string: "https://apps.apple.com/app/square-point-of-sale-pos/id335393788")!
    static let query: Self = Self(string: "square-commerce-v1://")!
    
    static func query(payment request: Request) throws -> Self {
        guard let data: String = String(data: try JSONEncoder().encode(request), encoding: .utf8),
              let url: Self = Self(string: "\(query.absoluteString)payment/create?data=\(try data.encoded())") else {
            throw Error.dataNotValid
        }
        return url
    }
}

extension String {
    fileprivate func encoded() throws -> Self {
        var allowedCharacters: CharacterSet = .urlQueryAllowed
        allowedCharacters.remove(charactersIn: ":/?#[]@!$&'()*+,;=")
        guard let encoded: Self = addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
            throw Error.dataNotValid
        }
        return encoded
    }
}
