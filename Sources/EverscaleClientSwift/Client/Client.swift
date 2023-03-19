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
    public var proofs: TSDKProofsModule

    public init(config: TSDKClientConfig) throws {
        self.config = config
        self.binding = try TSDKBindingModule(config: config)
        self.crypto = TSDKCryptoModule(binding: binding)
        self.abi = TSDKAbiModule(binding: binding)
        self.boc = TSDKBocModule(binding: binding)
        self.processing = TSDKProcessingModule(binding: binding)
        self.utils = TSDKUtilsModule(binding: binding)
        self.tvm = TSDKTvmModule(binding: binding)
        self.net = TSDKNetModule(binding: binding)
        self.debot = TSDKDebotModule(binding: binding)
        self.proofs = TSDKProofsModule(binding: binding)
    }

    /// Returns Core Library API reference
    public func get_api_reference(_ handler: @escaping (TSDKBindingResponse<TSDKResultOfGetApiReference, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "get_api_reference"
        try binding.requestLibraryAsync(methodName(module, method), "") { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetApiReference, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Returns Core Library API reference
    public func get_api_reference() async throws -> TSDKResultOfGetApiReference {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "get_api_reference"
                try binding.requestLibraryAsyncAwait(methodName(module, method), "") { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfGetApiReference, TSDKClientError> = .init()
                    response.update(requestId, params, responseType, finished)
                    if let error = response.error {
                        continuation.resume(throwing: error)
                    } else if let result = response.result {
                        continuation.resume(returning: result)
                    } else {
                        continuation.resume(throwing: TSDKClientError("Nothing for return"))
                    }
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }

    /// Returns Core Library version
    public func version(_ handler: @escaping (TSDKBindingResponse<TSDKResultOfVersion, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "version"
        try binding.requestLibraryAsync(methodName(module, method), "") { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfVersion, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Returns Core Library version
    public func version() async throws -> TSDKResultOfVersion {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "version"
                try binding.requestLibraryAsyncAwait(methodName(module, method), "") { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfVersion, TSDKClientError> = .init()
                    response.update(requestId, params, responseType, finished)
                    if let error = response.error {
                        continuation.resume(throwing: error)
                    } else if let result = response.result {
                        continuation.resume(returning: result)
                    } else {
                        continuation.resume(throwing: TSDKClientError("Nothing for return"))
                    }
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }

    /// Returns Core Library API reference
    public func config(_ handler: @escaping (TSDKBindingResponse<TSDKClientConfig, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "config"
        try binding.requestLibraryAsync(methodName(module, method), "") { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKClientConfig, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Returns Core Library API reference
    public func config() async throws -> TSDKClientConfig {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "config"
                try binding.requestLibraryAsyncAwait(methodName(module, method), "") { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKClientConfig, TSDKClientError> = .init()
                    response.update(requestId, params, responseType, finished)
                    if let error = response.error {
                        continuation.resume(throwing: error)
                    } else if let result = response.result {
                        continuation.resume(returning: result)
                    } else {
                        continuation.resume(throwing: TSDKClientError("Nothing for return"))
                    }
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }

    /// Returns detailed information about this build.
    public func build_info(_ handler: @escaping (TSDKBindingResponse<TSDKResultOfBuildInfo, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "build_info"
        try binding.requestLibraryAsync(methodName(module, method), "") { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfBuildInfo, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Returns detailed information about this build.
    public func build_info() async throws -> TSDKResultOfBuildInfo {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "build_info"
                try binding.requestLibraryAsyncAwait(methodName(module, method), "") { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfBuildInfo, TSDKClientError> = .init()
                    response.update(requestId, params, responseType, finished)
                    if let error = response.error {
                        continuation.resume(throwing: error)
                    } else if let result = response.result {
                        continuation.resume(returning: result)
                    } else {
                        continuation.resume(throwing: TSDKClientError("Nothing for return"))
                    }
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }

    /// Resolves application request processing result
    public func resolve_app_request(_ payload: TSDKParamsOfResolveAppRequest, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "resolve_app_request"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Resolves application request processing result
    public func resolve_app_request(_ payload: TSDKParamsOfResolveAppRequest) async throws -> TSDKNoneResult {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "resolve_app_request"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
                    response.update(requestId, params, responseType, finished)
                    if let error = response.error {
                        continuation.resume(throwing: error)
                    } else if let result = response.result {
                        continuation.resume(returning: result)
                    } else {
                        continuation.resume(throwing: TSDKClientError("Nothing for return"))
                    }
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }

    deinit {
        print("Client DEINIT !")
    }
}
