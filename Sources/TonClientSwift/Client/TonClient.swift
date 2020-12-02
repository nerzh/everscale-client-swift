//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

public final class TSDKClientModule {

    public let module: String = "client"
    private let binding: TSDKBindingModule
    public let config: TSDKClientConfig
    public var abi: TSDKAbiModule
    public var boc: TSDKBocModule
    public var crypto: TSDKCryptoModule
    public var net: TSDKNetModule
    public var processing: TSDKProcessingModule
    public var tvm: TSDKTvmModule
    public var utils: TSDKUtilsModule

    public init(config: TSDKClientConfig) {
        self.config = config
        self.binding = TSDKBindingModule(config: config)
        self.abi = TSDKAbiModule(binding: binding)
        self.boc = TSDKBocModule(binding: binding)
        self.crypto = TSDKCryptoModule(binding: binding)
        self.net = TSDKNetModule(binding: binding)
        self.processing = TSDKProcessingModule(binding: binding)
        self.tvm = TSDKTvmModule(binding: binding)
        self.utils = TSDKUtilsModule(binding: binding)
    }

    public func destroy() {
        binding.destroyContext()
    }

    public func get_api_reference(_ handler: @escaping (TSDKBindingResponse<TSDKResultOfGetApiReference, TSDKClientError, TSDKDefault>) -> Void) {
        let method: String = "get_api_reference"
        binding.requestLibraryAsync(methodName(module, method)) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetApiReference, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        }
    }

    public func version(_ handler: @escaping (TSDKBindingResponse<TSDKResultOfVersion, TSDKClientError, TSDKDefault>) -> Void) {
        let method: String = "version"
        binding.requestLibraryAsync(methodName(module, method)) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfVersion, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        }
    }

    public func build_info(_ handler: @escaping (TSDKBindingResponse<TSDKResultOfBuildInfo, TSDKClientError, TSDKDefault>) -> Void) {
        let method: String = "build_info"
        binding.requestLibraryAsync(methodName(module, method)) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfBuildInfo, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        }
    }
}
