//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

public final class TSDKNetModule {
    
    private var binding: TSDKBindingModule
    public let module: String = "net"
    
    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }
    
    public func query_collection(_ payload: TSDKParamsOfQueryCollection,
                                 _ handler: @escaping (TSDKBindingResponse<TSDKResultOfQueryCollection, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "query_collection"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfQueryCollection, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func wait_for_collection(_ payload: TSDKParamsOfWaitForCollection,
                                    _ handler: @escaping (TSDKBindingResponse<TSDKResultOfWaitForCollection, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "wait_for_collection"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfWaitForCollection, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func subscribe_collection(_ payload: TSDKParamsOfSubscribeCollection,
                                     _ handler: @escaping (TSDKBindingResponse<TSDKResultOfSubscribeCollection, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "subscribe_collection"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfSubscribeCollection, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func unsubscribe(_ payload: TSDKResultOfSubscribeCollection,
                            _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "unsubscribe"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        }
    }
}


