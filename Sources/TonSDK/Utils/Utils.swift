//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

public final class TSDKUtils {
    
    private var binding: TSDKBinding
    public let module: String = "utils"
    
    public init(binding: TSDKBinding) {
        self.binding = binding
    }
    
    public func convert_address(_ payload: TSDKParamsOfConvertAddress,
                                _ handler: @escaping (TSDKBindingResponse<TSDKResultOfConvertAddress, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "convert_address"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
}
