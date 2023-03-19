public final class TSDKBocModule {

    private var binding: TSDKBindingModule
    public let module: String = "boc"

    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }

    /// Parses message boc into a JSON
    /// JSON structure is compatible with GraphQL API message object
    public func parse_message(_ payload: TSDKParamsOfParse, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfParse, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "parse_message"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfParse, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Parses message boc into a JSON
    /// JSON structure is compatible with GraphQL API message object
    public func parse_message(_ payload: TSDKParamsOfParse) async throws -> TSDKResultOfParse {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "parse_message"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfParse, TSDKClientError> = .init()
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

    /// Parses transaction boc into a JSON
    /// JSON structure is compatible with GraphQL API transaction object
    public func parse_transaction(_ payload: TSDKParamsOfParse, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfParse, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "parse_transaction"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfParse, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Parses transaction boc into a JSON
    /// JSON structure is compatible with GraphQL API transaction object
    public func parse_transaction(_ payload: TSDKParamsOfParse) async throws -> TSDKResultOfParse {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "parse_transaction"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfParse, TSDKClientError> = .init()
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

    /// Parses account boc into a JSON
    /// JSON structure is compatible with GraphQL API account object
    public func parse_account(_ payload: TSDKParamsOfParse, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfParse, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "parse_account"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfParse, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Parses account boc into a JSON
    /// JSON structure is compatible with GraphQL API account object
    public func parse_account(_ payload: TSDKParamsOfParse) async throws -> TSDKResultOfParse {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "parse_account"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfParse, TSDKClientError> = .init()
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

    /// Parses block boc into a JSON
    /// JSON structure is compatible with GraphQL API block object
    public func parse_block(_ payload: TSDKParamsOfParse, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfParse, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "parse_block"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfParse, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Parses block boc into a JSON
    /// JSON structure is compatible with GraphQL API block object
    public func parse_block(_ payload: TSDKParamsOfParse) async throws -> TSDKResultOfParse {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "parse_block"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfParse, TSDKClientError> = .init()
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

    /// Parses shardstate boc into a JSON
    /// JSON structure is compatible with GraphQL API shardstate object
    public func parse_shardstate(_ payload: TSDKParamsOfParseShardstate, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfParse, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "parse_shardstate"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfParse, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Parses shardstate boc into a JSON
    /// JSON structure is compatible with GraphQL API shardstate object
    public func parse_shardstate(_ payload: TSDKParamsOfParseShardstate) async throws -> TSDKResultOfParse {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "parse_shardstate"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfParse, TSDKClientError> = .init()
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

    /// Extract blockchain configuration from key block and also from zerostate.
    public func get_blockchain_config(_ payload: TSDKParamsOfGetBlockchainConfig, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfGetBlockchainConfig, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "get_blockchain_config"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetBlockchainConfig, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Extract blockchain configuration from key block and also from zerostate.
    public func get_blockchain_config(_ payload: TSDKParamsOfGetBlockchainConfig) async throws -> TSDKResultOfGetBlockchainConfig {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "get_blockchain_config"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfGetBlockchainConfig, TSDKClientError> = .init()
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

    /// Calculates BOC root hash
    public func get_boc_hash(_ payload: TSDKParamsOfGetBocHash, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfGetBocHash, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "get_boc_hash"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetBocHash, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Calculates BOC root hash
    public func get_boc_hash(_ payload: TSDKParamsOfGetBocHash) async throws -> TSDKResultOfGetBocHash {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "get_boc_hash"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfGetBocHash, TSDKClientError> = .init()
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

    /// Calculates BOC depth
    public func get_boc_depth(_ payload: TSDKParamsOfGetBocDepth, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfGetBocDepth, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "get_boc_depth"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetBocDepth, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Calculates BOC depth
    public func get_boc_depth(_ payload: TSDKParamsOfGetBocDepth) async throws -> TSDKResultOfGetBocDepth {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "get_boc_depth"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfGetBocDepth, TSDKClientError> = .init()
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

    /// Extracts code from TVC contract image
    public func get_code_from_tvc(_ payload: TSDKParamsOfGetCodeFromTvc, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfGetCodeFromTvc, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "get_code_from_tvc"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetCodeFromTvc, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Extracts code from TVC contract image
    public func get_code_from_tvc(_ payload: TSDKParamsOfGetCodeFromTvc) async throws -> TSDKResultOfGetCodeFromTvc {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "get_code_from_tvc"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfGetCodeFromTvc, TSDKClientError> = .init()
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

    /// Get BOC from cache
    public func cache_get(_ payload: TSDKParamsOfBocCacheGet, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfBocCacheGet, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "cache_get"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfBocCacheGet, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Get BOC from cache
    public func cache_get(_ payload: TSDKParamsOfBocCacheGet) async throws -> TSDKResultOfBocCacheGet {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "cache_get"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfBocCacheGet, TSDKClientError> = .init()
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

    /// Save BOC into cache or increase pin counter for existing pinned BOC
    public func cache_set(_ payload: TSDKParamsOfBocCacheSet, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfBocCacheSet, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "cache_set"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfBocCacheSet, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Save BOC into cache or increase pin counter for existing pinned BOC
    public func cache_set(_ payload: TSDKParamsOfBocCacheSet) async throws -> TSDKResultOfBocCacheSet {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "cache_set"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfBocCacheSet, TSDKClientError> = .init()
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

    /// Unpin BOCs with specified pin defined in the `cache_set`. Decrease pin reference counter for BOCs with specified pin defined in the `cache_set`. BOCs which have only 1 pin and its reference counter become 0 will be removed from cache
    public func cache_unpin(_ payload: TSDKParamsOfBocCacheUnpin, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "cache_unpin"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Unpin BOCs with specified pin defined in the `cache_set`. Decrease pin reference counter for BOCs with specified pin defined in the `cache_set`. BOCs which have only 1 pin and its reference counter become 0 will be removed from cache
    public func cache_unpin(_ payload: TSDKParamsOfBocCacheUnpin) async throws -> TSDKNoneResult {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "cache_unpin"
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

    /// Encodes bag of cells (BOC) with builder operations. This method provides the same functionality as Solidity TvmBuilder. Resulting BOC of this method can be passed into Solidity and C++ contracts as TvmCell type.
    public func encode_boc(_ payload: TSDKParamsOfEncodeBoc, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfEncodeBoc, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "encode_boc"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncodeBoc, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Encodes bag of cells (BOC) with builder operations. This method provides the same functionality as Solidity TvmBuilder. Resulting BOC of this method can be passed into Solidity and C++ contracts as TvmCell type.
    public func encode_boc(_ payload: TSDKParamsOfEncodeBoc) async throws -> TSDKResultOfEncodeBoc {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "encode_boc"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfEncodeBoc, TSDKClientError> = .init()
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

    /// Returns the contract code's salt if it is present.
    public func get_code_salt(_ payload: TSDKParamsOfGetCodeSalt, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfGetCodeSalt, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "get_code_salt"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetCodeSalt, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Returns the contract code's salt if it is present.
    public func get_code_salt(_ payload: TSDKParamsOfGetCodeSalt) async throws -> TSDKResultOfGetCodeSalt {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "get_code_salt"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfGetCodeSalt, TSDKClientError> = .init()
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

    /// Sets new salt to contract code.
    /// Returns the new contract code with salt.
    public func set_code_salt(_ payload: TSDKParamsOfSetCodeSalt, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfSetCodeSalt, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "set_code_salt"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfSetCodeSalt, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Sets new salt to contract code.
    /// Returns the new contract code with salt.
    public func set_code_salt(_ payload: TSDKParamsOfSetCodeSalt) async throws -> TSDKResultOfSetCodeSalt {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "set_code_salt"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfSetCodeSalt, TSDKClientError> = .init()
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

    /// Decodes tvc into code, data, libraries and special options.
    public func decode_tvc(_ payload: TSDKParamsOfDecodeTvc, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfDecodeTvc, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "decode_tvc"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfDecodeTvc, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Decodes tvc into code, data, libraries and special options.
    public func decode_tvc(_ payload: TSDKParamsOfDecodeTvc) async throws -> TSDKResultOfDecodeTvc {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "decode_tvc"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfDecodeTvc, TSDKClientError> = .init()
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

    /// Encodes tvc from code, data, libraries ans special options (see input params)
    public func encode_tvc(_ payload: TSDKParamsOfEncodeTvc, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfEncodeTvc, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "encode_tvc"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncodeTvc, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Encodes tvc from code, data, libraries ans special options (see input params)
    public func encode_tvc(_ payload: TSDKParamsOfEncodeTvc) async throws -> TSDKResultOfEncodeTvc {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "encode_tvc"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfEncodeTvc, TSDKClientError> = .init()
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

    /// Encodes a message
    /// Allows to encode any external inbound message.
    public func encode_external_in_message(_ payload: TSDKParamsOfEncodeExternalInMessage, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfEncodeExternalInMessage, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "encode_external_in_message"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncodeExternalInMessage, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Encodes a message
    /// Allows to encode any external inbound message.
    public func encode_external_in_message(_ payload: TSDKParamsOfEncodeExternalInMessage) async throws -> TSDKResultOfEncodeExternalInMessage {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "encode_external_in_message"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfEncodeExternalInMessage, TSDKClientError> = .init()
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

    /// Returns the compiler version used to compile the code.
    public func get_compiler_version(_ payload: TSDKParamsOfGetCompilerVersion, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfGetCompilerVersion, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "get_compiler_version"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetCompilerVersion, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Returns the compiler version used to compile the code.
    public func get_compiler_version(_ payload: TSDKParamsOfGetCompilerVersion) async throws -> TSDKResultOfGetCompilerVersion {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "get_compiler_version"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfGetCompilerVersion, TSDKClientError> = .init()
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

}
