//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

public final class TSDKClient {

    private let binding: TSDKBinding
    public var crypto: TSDKCrypto

    public init(config: ClientConfig) {
        self.binding = TSDKBinding(config: config)
        self.crypto = TSDKCrypto(binding: binding)
    }
}
