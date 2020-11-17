//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

public final class TSDKTvmModule {
    
    private var binding: TSDKBindingModule
    public let module: String = "tvm"
    
    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }
    
    public func run_executor(_ payload: TSDKParamsOfRunExecutor,
                             _ handler: @escaping (TSDKBindingResponse<TSDKResultOfRunExecutor, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "run_executor"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfRunExecutor, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func run_tvm(_ payload: TSDKParamsOfRunTvm,
                        _ handler: @escaping (TSDKBindingResponse<TSDKResultOfRunTvm, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "run_tvm"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfRunTvm, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func run_get(_ payload: TSDKParamsOfRunGet,
                        _ handler: @escaping (TSDKBindingResponse<TSDKResultOfRunGet, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "run_get"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfRunGet, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }
}
