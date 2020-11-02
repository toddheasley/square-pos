# `SquarePOS`

Add lightweight support for [Square Point of Sale](https://squareup.com/us/en/point-of-sale) payments to any iOS app.

## Requirements

Targets [iOS](https://developer.apple.com/ios)/[iPadOS](https://developer.apple.com/ipad) 13. Written in [Swift](https://developer.apple.com/documentation/swift) 5.3 and requires [Xcode](https://developer.apple.com/xcode) 12 or newer to build. Additionally, a [Square developer account](https://squareup.com/signup?v=developers) is needed to complete registration.

## Example Usage

`SquarePOS` doesn't integrate Square payments directly into an iOS app. Instead, it sends a payment `Request` to the [Square Point of Sale app](https://apps.apple.com/app/square-point-of-sale-pos/id335393788) and accepts a `Response` back. Communication between apps is accomplished via URLs with [app-specific schemes.](https://developer.apple.com/documentation/xcode/allowing_apps_and_websites_to_link_to_your_content/defining_a_custom_url_scheme_for_your_app)

### URL Schemes

Add a custom scheme to the main iOS bundle `Info.plist`:

```
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLName</key>
        <string>com.pos-example</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>pos-example</string>
        </array>
    </dict>
</array>
```

This scheme enables iOS to directly deliver URLs opened from all other apps, not specifically Square.

Also in the main bundle `Info.plist`,  add the Square custom URL scheme `square-commerce-v1` to the list of apps to be queried:

```
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>square-commerce-v1</string>
</array>
```

### Square Configuration

From the [Square developer dashboard](https://developer.squareup.com/apps/), create a new developer application (or choose an existing one). Add app bundle ID and custom URL scheme to the Point of Sale API configuration.

Next, configure `SquarePOS` with the developer application ID:

```swift
import Foundation
import SquarePOS

SquarePOS.app.id = "sqU@r3-aPP1ic@+i0n-iD"
```

`SquarePOS`  attempts to read the custom URL scheme directly from `Bundle`, but scheme may need to be set explicitly in some cases:

```swift
import Foundation
import SquarePOS

SquarePOS.app.scheme = "pos-example"
```
Both app ID and scheme are static, and can be set at launch or just before sending a payment request.

Last, include `SquarePOS` callback handling wherever incoming URLs are routed. `UISceneDelegate` for modern UIKit apps; `UIApplicationDelegate` otherwise.

```swift
import UIKit
import SquarePOS

// MARK: UISceneDelegate
func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    for context in URLContexts {
        guard !SquarePOS.open(url: context.url) else { continue }
    }
}
```

`SquarePOS` is now configured and ready to make payment requests.

### Square App Installation

Before enabling payments functionality, check that the [Square Point of Sale app](https://apps.apple.com/app/square-point-of-sale-pos/id335393788) is installed, and send users to the App Store if not:

```swift
import Foundation
import SquarePOS

if !SquarePOS.isInstalled {
    SquarePOS.install()
}
```

Note that testing payments requires running on a physical iOS device with the Square app installed. Additionally, Square's Point of Sale API lacks any kind of sandbox environment; testing is done with real-money transactions that can be [manually refunded.](https://squareup.com/help/us/en/article/5060-refund-overview)

### Payments

Make payment requests and handle responses with a single [`Publisher`](https://developer.apple.com/documentation/combine/publisher):

```swift
import UIKit
import Combine
import SquarePOS

let request: Request = Request(money: Money(1.99, currency: .usd))
var subscriber: AnyCancellable?

subscriber = SquarePOS.publisher(payment: request)
    .sink { response in
        switch response {
        case .ok(let transaction):
            print(transaction.id) // "aGOiXpmbRVGjm5zhSn716a5eV"
        case .error(let error):
            print(error) // "Square payment was canceled"
        }
    }
```

By default, `Request` is configured to support all available tender types and allow [card-not-present transactions.](https://en.wikipedia.org/wiki/Card_not_present_transaction) Override the provided defaults with custom `Options`:

```swift
import Foundation
import SquarePOS

let options: Options = Options(supportedTender: [.card, .cash], disableCNP: true)
let request: Request = Request(money: Money(19.99, currency: .usd), options: options)
```
`SquarePOS` supports payments in 3 currencies: United States dollar (USD), Canadian dollar  (CAD) and Australian dollar (AUD).
