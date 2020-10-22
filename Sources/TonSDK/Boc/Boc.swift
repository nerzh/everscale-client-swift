//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

public final class TSDKBoc {
    
    private var binding: TSDKBinding
    public let module: String = "boc"
    
    public init(binding: TSDKBinding) {
        self.binding = binding
    }
    
    public func parse_message(_ payload: TSDKParamsOfParse,
                              _ handler: @escaping (TSDKBindingResponse<TSDKResultOfParse, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "parse_message"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfParse, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func parse_transaction(_ payload: TSDKParamsOfParse,
                                  _ handler: @escaping (TSDKBindingResponse<TSDKResultOfParse, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "parse_transaction"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfParse, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func parse_account(_ payload: TSDKParamsOfParse,
                              _ handler: @escaping (TSDKBindingResponse<TSDKResultOfParse, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "parse_account"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfParse, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func parse_block(_ payload: TSDKParamsOfParse,
                            _ handler: @escaping (TSDKBindingResponse<TSDKResultOfParse, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "parse_block"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfParse, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func get_blockchain_config(_ payload: TSDKParamsOfGetBlockchainConfig,
                                      _ handler: @escaping (TSDKBindingResponse<TSDKResultOfGetBlockchainConfig, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "get_blockchain_config"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetBlockchainConfig, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }
}
