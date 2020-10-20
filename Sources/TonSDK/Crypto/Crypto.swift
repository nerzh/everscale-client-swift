//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

public final class TSDKCrypto {

    public weak var client: TSDKClient?
    public let module: String = "crypto"

    public init(client: TSDKClient) {
        self.client = client
    }

    public func factorize(_ payload: TSDKParamsOfFactorize,
                          _ handler: @escaping (TSDKBindingResponse<TSDKResultOfFactorize, ClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "factorize"
        client?.binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
}
