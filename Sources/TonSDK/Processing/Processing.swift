//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

public final class TSDKProcessing {
    
    private var binding: TSDKBinding
    public let module: String = "processing"
    
    public init(binding: TSDKBinding) {
        self.binding = binding
    }
    
    public func send_message<T: Encodable>(_ payload: TSDKParamsOfSendMessage<T>,
                             _ handler: @escaping (TSDKBindingResponse<TSDKResultOfSendMessage, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "send_message"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func wait_for_transaction<T: Encodable>(_ payload: TSDKParamsOfWaitForTransaction<T>,
                                     _ handler: @escaping (TSDKBindingResponse<TSDKResultOfProcessMessage, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "wait_for_transaction"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func process_message<T: Encodable>(_ payload: TSDKParamsOfProcessMessage<T>,
                                _ handler: @escaping (TSDKBindingResponse<TSDKResultOfProcessMessage, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "process_message"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
}
