//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

public final class TSDKAbi {

    private var binding: TSDKBinding
    public let module: String = "abi"

    public init(binding: TSDKBinding) {
        self.binding = binding
    }

    public func factorize(_ payload: TSDKParamsOfFactorize,
                          _ handler: @escaping (TSDKBindingResponse<TSDKResultOfFactorize, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "factorize"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
}
