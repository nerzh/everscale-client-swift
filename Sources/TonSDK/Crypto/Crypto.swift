//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

public final class TSDKCrypto {

    private var binding: TSDKBinding
    public let module: String = "crypto"

    public init(binding: TSDKBinding) {
        self.binding = binding
    }

    public func factorize(_ payload: TSDKParamsOfFactorize,
                          _ handler: @escaping (TSDKBindingResponse<TSDKResultOfFactorize, ClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "factorize"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
}
