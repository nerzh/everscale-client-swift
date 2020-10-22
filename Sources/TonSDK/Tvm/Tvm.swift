//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

public final class TSDKTvm {
    
    private var binding: TSDKBinding
    public let module: String = "tvm"
    
    public init(binding: TSDKBinding) {
        self.binding = binding
    }
    
    public func execute_message(_ payload: TSDKParamsOfExecuteMessage,
                                _ handler: @escaping (TSDKBindingResponse<TSDKResultOfExecuteMessage, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "execute_message"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfExecuteMessage, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func execute_get(_ payload: TSDKParamsOfExecuteGet,
                            _ handler: @escaping (TSDKBindingResponse<TSDKResultOfExecuteGet, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "execute_get"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfExecuteGet, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }
}
