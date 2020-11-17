//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

public final class TSDKUtilsModule {
    
    private var binding: TSDKBindingModule
    public let module: String = "utils"
    
    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }
    
    public func convert_address(_ payload: TSDKParamsOfConvertAddress,
                                _ handler: @escaping (TSDKBindingResponse<TSDKResultOfConvertAddress, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "convert_address"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfConvertAddress, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            BindingStore.responseQueue.async { handler(response) }
        })
    }
}
