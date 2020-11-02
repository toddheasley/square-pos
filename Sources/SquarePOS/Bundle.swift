import Foundation

extension Bundle {
    var scheme: String? {
        guard let bundleURLType: [String: Any] = (object(forInfoDictionaryKey: "CFBundleURLTypes") as? [[String:Any]])?.first else {
            return nil
        }
        return (bundleURLType["CFBundleURLSchemes"] as? [String])?.first
    }
    
    var querySchemes: [String] {
        return object(forInfoDictionaryKey: "LSApplicationQueriesSchemes") as? [String] ?? []
    }
}
