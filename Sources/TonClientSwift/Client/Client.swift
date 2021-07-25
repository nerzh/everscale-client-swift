public final class TSDKClientModule {

    private var binding: TSDKBindingModule
    public let module: String = "client"
    public let config: TSDKClientConfig
    public var crypto: TSDKCryptoModule
    public var abi: TSDKAbiModule
    public var boc: TSDKBocModule
    public var processing: TSDKProcessingModule
    public var utils: TSDKUtilsModule
    public var tvm: TSDKTvmModule
    public var net: TSDKNetModule
    public var debot: TSDKDebotModule

    public init(config: TSDKClientConfig) {
        self.config = config
        self.binding = TSDKBindingModule(config: config)
        self.crypto = TSDKCryptoModule(binding: binding)
        self.abi = TSDKAbiModule(binding: binding)
        self.boc = TSDKBocModule(binding: binding)
        self.processing = TSDKProcessingModule(binding: binding)
        self.utils = TSDKUtilsModule(binding: binding)
        self.tvm = TSDKTvmModule(binding: binding)
        self.net = TSDKNetModule(binding: binding)
        self.debot = TSDKDebotModule(binding: binding)
    }

    /// Returns Core Library API reference
    public func get_api_reference(_ handler: @escaping (TSDKBindingResponse<TSDKResultOfGetApiReference, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "get_api_reference"
        binding.requestLibraryAsync(methodName(module, method), "", { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetApiReference, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Returns Core Library version
    public func version(_ handler: @escaping (TSDKBindingResponse<TSDKResultOfVersion, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "version"
        binding.requestLibraryAsync(methodName(module, method), "", { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfVersion, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Returns detailed information about this build.
    public func build_info(_ handler: @escaping (TSDKBindingResponse<TSDKResultOfBuildInfo, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "build_info"
        binding.requestLibraryAsync(methodName(module, method), "", { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfBuildInfo, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Resolves application request processing result
    public func resolve_app_request(_ payload: TSDKParamsOfResolveAppRequest, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "resolve_app_request"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    deinit {
        print("Client DEINIT !")
    }
}
