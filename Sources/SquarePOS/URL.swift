import Foundation

extension URL {
    static let app: Self = Self(string: "https://apps.apple.com/app/square-point-of-sale-pos/id335393788")!
    
    static func query() -> Self {
        return URL(string: "square-commerce-v1://")!
    }
}
