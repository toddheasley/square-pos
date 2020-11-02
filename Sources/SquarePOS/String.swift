import Foundation

extension String {
    func percentEncoded() throws -> Self {
        guard let encoded: Self = addingPercentEncoding(withAllowedCharacters: .allowedCharacters) else {
            throw Error.dataNotValid
        }
        return encoded
    }
}

extension CharacterSet {
    fileprivate static var allowedCharacters: Self {
        var allowedCharacters: CharacterSet = .urlQueryAllowed
        allowedCharacters.remove(charactersIn: ":/?#[]@!$&'()*+,;=")
        return allowedCharacters
    }
}
