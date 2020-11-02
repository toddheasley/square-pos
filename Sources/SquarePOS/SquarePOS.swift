import Foundation

public struct SquarePOS {
    public static var app: (id: String?, scheme: String?) {
        set { Request.app = newValue }
        get { Request.app }
    }
}

#if os(iOS)
import UIKit
import Combine

extension SquarePOS {
    public static func publisher(payment request: Request) -> AnyPublisher<Response, Never> {
        defer {
            do {
                let url: URL = try .query(payment: request)
                UIApplication.shared.open(url)
            } catch {
                NotificationCenter.default.post(name: paymentNotification, object: Response.error(error as! Error))
            }
        }
        return NotificationCenter.default.publisher(for: paymentNotification)
            .compactMap { $0.object as? Response }
            .eraseToAnyPublisher()
    }
    
    @discardableResult public static func open(url: URL?) -> Bool {
        guard let url: URL = url, url.isCallback else {
            return false
        }
        NotificationCenter.default.post(name: paymentNotification, object: url.response)
        return true
    }
    
    private static let paymentNotification: Notification.Name = Notification.Name("SquarePOS.paymentNotification")
}

extension SquarePOS {
    public static var isInstalled: Bool {
        return UIApplication.shared.canOpenURL(.query)
    }
    
    public static func install() {
        UIApplication.shared.open(.install)
    }
}
#endif
