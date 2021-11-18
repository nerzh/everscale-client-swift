public final class TSDKBocModule {

    private var binding: TSDKBindingModule
    public let module: String = "boc"

    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }

    /// Parses message boc into a JSON
    /// JSON structure is compatible with GraphQL API message object
    public func parse_message(_ payload: TSDKParamsOfParse, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfParse, TSDKClientError>) throws -> Void
    ) {
        let method: String = "parse_message"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfParse, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Parses transaction boc into a JSON
    /// JSON structure is compatible with GraphQL API transaction object
    public func parse_transaction(_ payload: TSDKParamsOfParse, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfParse, TSDKClientError>) throws -> Void
    ) {
        let method: String = "parse_transaction"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfParse, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Parses account boc into a JSON
    /// JSON structure is compatible with GraphQL API account object
    public func parse_account(_ payload: TSDKParamsOfParse, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfParse, TSDKClientError>) throws -> Void
    ) {
        let method: String = "parse_account"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfParse, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Parses block boc into a JSON
    /// JSON structure is compatible with GraphQL API block object
    public func parse_block(_ payload: TSDKParamsOfParse, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfParse, TSDKClientError>) throws -> Void
    ) {
        let method: String = "parse_block"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfParse, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Parses shardstate boc into a JSON
    /// JSON structure is compatible with GraphQL API shardstate object
    public func parse_shardstate(_ payload: TSDKParamsOfParseShardstate, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfParse, TSDKClientError>) throws -> Void
    ) {
        let method: String = "parse_shardstate"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfParse, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Extract blockchain configuration from key block and also from zerostate.
    public func get_blockchain_config(_ payload: TSDKParamsOfGetBlockchainConfig, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfGetBlockchainConfig, TSDKClientError>) throws -> Void
    ) {
        let method: String = "get_blockchain_config"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetBlockchainConfig, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Calculates BOC root hash
    public func get_boc_hash(_ payload: TSDKParamsOfGetBocHash, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfGetBocHash, TSDKClientError>) throws -> Void
    ) {
        let method: String = "get_boc_hash"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetBocHash, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Calculates BOC depth
    public func get_boc_depth(_ payload: TSDKParamsOfGetBocDepth, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfGetBocDepth, TSDKClientError>) throws -> Void
    ) {
        let method: String = "get_boc_depth"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetBocDepth, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Extracts code from TVC contract image
    public func get_code_from_tvc(_ payload: TSDKParamsOfGetCodeFromTvc, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfGetCodeFromTvc, TSDKClientError>) throws -> Void
    ) {
        let method: String = "get_code_from_tvc"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetCodeFromTvc, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Get BOC from cache
    public func cache_get(_ payload: TSDKParamsOfBocCacheGet, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfBocCacheGet, TSDKClientError>) throws -> Void
    ) {
        let method: String = "cache_get"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfBocCacheGet, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Save BOC into cache
    public func cache_set(_ payload: TSDKParamsOfBocCacheSet, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfBocCacheSet, TSDKClientError>) throws -> Void
    ) {
        let method: String = "cache_set"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfBocCacheSet, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Unpin BOCs with specified pin.
    /// BOCs which don't have another pins will be removed from cache
    public func cache_unpin(_ payload: TSDKParamsOfBocCacheUnpin, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) {
        let method: String = "cache_unpin"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Encodes bag of cells (BOC) with builder operations. This method provides the same functionality as Solidity TvmBuilder. Resulting BOC of this method can be passed into Solidity and C++ contracts as TvmCell type
    public func encode_boc(_ payload: TSDKParamsOfEncodeBoc, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfEncodeBoc, TSDKClientError>) throws -> Void
    ) {
        let method: String = "encode_boc"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncodeBoc, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Returns the contract code's salt if it is present.
    public func get_code_salt(_ payload: TSDKParamsOfGetCodeSalt, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfGetCodeSalt, TSDKClientError>) throws -> Void
    ) {
        let method: String = "get_code_salt"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetCodeSalt, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Sets new salt to contract code.
    /// Returns the new contract code with salt.
    public func set_code_salt(_ payload: TSDKParamsOfSetCodeSalt, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfSetCodeSalt, TSDKClientError>) throws -> Void
    ) {
        let method: String = "set_code_salt"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfSetCodeSalt, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Decodes tvc into code, data, libraries and special options.
    public func decode_tvc(_ payload: TSDKParamsOfDecodeTvc, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfDecodeTvc, TSDKClientError>) throws -> Void
    ) {
        let method: String = "decode_tvc"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfDecodeTvc, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Encodes tvc from code, data, libraries ans special options (see input params)
    public func encode_tvc(_ payload: TSDKParamsOfEncodeTvc, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfEncodeTvc, TSDKClientError>) throws -> Void
    ) {
        let method: String = "encode_tvc"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncodeTvc, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Returns the compiler version used to compile the code.
    public func get_compiler_version(_ payload: TSDKParamsOfGetCompilerVersion, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfGetCompilerVersion, TSDKClientError>) throws -> Void
    ) {
        let method: String = "get_compiler_version"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetCompilerVersion, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

}
