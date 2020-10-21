//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

public final class TSDKNet {
    
    private var binding: TSDKBinding
    public let module: String = "net"
    
    public init(binding: TSDKBinding) {
        self.binding = binding
    }
    
    public func query_collection<A: Encodable>(_ payload: TSDKParamsOfQueryCollection<A>,
                                 _ handler: @escaping (TSDKBindingResponse<TSDKResultOfQueryCollection, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "query_collection"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func wait_for_collection<A: Encodable>(_ payload: TSDKParamsOfWaitForCollection<A>,
                                    _ handler: @escaping (TSDKBindingResponse<TSDKResultOfWaitForCollection, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "wait_for_collection"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func unsubscribe(_ handler: @escaping (TSDKBindingResponse<TSDKResultOfSubscribeCollection, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "unsubscribe"
        binding.requestLibraryAsync(methodName(module, method), "", { (response) in
            handler(response)
        })
    }
    
    public func subscribe_collection<A: Encodable>(_ payload: TSDKParamsOfSubscribeCollection<A>,
                                     _ handler: @escaping (TSDKBindingResponse<TSDKResultOfSubscribeCollection, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "subscribe_collection"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
}
