public final class TSDKUtilsModule {

    private var binding: TSDKBindingModule
    public let module: String = "utils"

    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }

    /// Converts address from any TON format to any TON format
    public func convert_address(_ payload: TSDKParamsOfConvertAddress, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfConvertAddress, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "convert_address"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfConvertAddress, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Converts address from any TON format to any TON format
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func convert_address(_ payload: TSDKParamsOfConvertAddress) async throws -> TSDKResultOfConvertAddress {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "convert_address"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfConvertAddress, TSDKClientError> = .init()
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

    /// Validates and returns the type of any TON address.
    /// Address types are the following`0:919db8e740d50bf349df2eea03fa30c385d846b991ff5542e67098ee833fc7f7` - standard TON address mostcommonly used in all cases. Also called as hex address`919db8e740d50bf349df2eea03fa30c385d846b991ff5542e67098ee833fc7f7` - account ID. A part of fulladdress. Identifies account inside particular workchain`EQCRnbjnQNUL80nfLuoD+jDDhdhGuZH/VULmcJjugz/H9wam` - base64 address. Also called "user-friendly".
    /// Was used at the beginning of TON. Now it is supported for compatibility
    public func get_address_type(_ payload: TSDKParamsOfGetAddressType, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfGetAddressType, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "get_address_type"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetAddressType, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Validates and returns the type of any TON address.
    /// Address types are the following`0:919db8e740d50bf349df2eea03fa30c385d846b991ff5542e67098ee833fc7f7` - standard TON address mostcommonly used in all cases. Also called as hex address`919db8e740d50bf349df2eea03fa30c385d846b991ff5542e67098ee833fc7f7` - account ID. A part of fulladdress. Identifies account inside particular workchain`EQCRnbjnQNUL80nfLuoD+jDDhdhGuZH/VULmcJjugz/H9wam` - base64 address. Also called "user-friendly".
    /// Was used at the beginning of TON. Now it is supported for compatibility
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func get_address_type(_ payload: TSDKParamsOfGetAddressType) async throws -> TSDKResultOfGetAddressType {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "get_address_type"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfGetAddressType, TSDKClientError> = .init()
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

    /// Calculates storage fee for an account over a specified time period
    public func calc_storage_fee(_ payload: TSDKParamsOfCalcStorageFee, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfCalcStorageFee, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "calc_storage_fee"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfCalcStorageFee, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Calculates storage fee for an account over a specified time period
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func calc_storage_fee(_ payload: TSDKParamsOfCalcStorageFee) async throws -> TSDKResultOfCalcStorageFee {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "calc_storage_fee"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfCalcStorageFee, TSDKClientError> = .init()
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

    /// Compresses data using Zstandard algorithm
    public func compress_zstd(_ payload: TSDKParamsOfCompressZstd, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfCompressZstd, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "compress_zstd"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfCompressZstd, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Compresses data using Zstandard algorithm
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func compress_zstd(_ payload: TSDKParamsOfCompressZstd) async throws -> TSDKResultOfCompressZstd {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "compress_zstd"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfCompressZstd, TSDKClientError> = .init()
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

    /// Decompresses data using Zstandard algorithm
    public func decompress_zstd(_ payload: TSDKParamsOfDecompressZstd, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfDecompressZstd, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "decompress_zstd"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfDecompressZstd, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Decompresses data using Zstandard algorithm
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func decompress_zstd(_ payload: TSDKParamsOfDecompressZstd) async throws -> TSDKResultOfDecompressZstd {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "decompress_zstd"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfDecompressZstd, TSDKClientError> = .init()
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
