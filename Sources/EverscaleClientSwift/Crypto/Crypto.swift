public final class TSDKCryptoModule {

    private var binding: TSDKBindingModule
    public let module: String = "crypto"

    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }

    /// Integer factorization
    /// Performs prime factorization – decomposition of a composite numberinto a product of smaller prime integers (factors).
    /// See [https://en.wikipedia.org/wiki/Integer_factorization]
    public func factorize(_ payload: TSDKParamsOfFactorize, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfFactorize, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "factorize"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfFactorize, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Integer factorization
    /// Performs prime factorization – decomposition of a composite numberinto a product of smaller prime integers (factors).
    /// See [https://en.wikipedia.org/wiki/Integer_factorization]
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func factorize(_ payload: TSDKParamsOfFactorize) async throws -> TSDKResultOfFactorize {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "factorize"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfFactorize, TSDKClientError> = .init()
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

    /// Modular exponentiation
    /// Performs modular exponentiation for big integers (`base`^`exponent` mod `modulus`).
    /// See [https://en.wikipedia.org/wiki/Modular_exponentiation]
    public func modular_power(_ payload: TSDKParamsOfModularPower, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfModularPower, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "modular_power"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfModularPower, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Modular exponentiation
    /// Performs modular exponentiation for big integers (`base`^`exponent` mod `modulus`).
    /// See [https://en.wikipedia.org/wiki/Modular_exponentiation]
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func modular_power(_ payload: TSDKParamsOfModularPower) async throws -> TSDKResultOfModularPower {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "modular_power"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfModularPower, TSDKClientError> = .init()
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

    /// Calculates CRC16 using TON algorithm.
    public func ton_crc16(_ payload: TSDKParamsOfTonCrc16, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfTonCrc16, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "ton_crc16"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfTonCrc16, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Calculates CRC16 using TON algorithm.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func ton_crc16(_ payload: TSDKParamsOfTonCrc16) async throws -> TSDKResultOfTonCrc16 {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "ton_crc16"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfTonCrc16, TSDKClientError> = .init()
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

    /// Generates random byte array of the specified length and returns it in `base64` format
    public func generate_random_bytes(_ payload: TSDKParamsOfGenerateRandomBytes, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfGenerateRandomBytes, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "generate_random_bytes"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGenerateRandomBytes, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Generates random byte array of the specified length and returns it in `base64` format
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func generate_random_bytes(_ payload: TSDKParamsOfGenerateRandomBytes) async throws -> TSDKResultOfGenerateRandomBytes {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "generate_random_bytes"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfGenerateRandomBytes, TSDKClientError> = .init()
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

    /// Converts public key to ton safe_format
    public func convert_public_key_to_ton_safe_format(_ payload: TSDKParamsOfConvertPublicKeyToTonSafeFormat, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfConvertPublicKeyToTonSafeFormat, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "convert_public_key_to_ton_safe_format"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfConvertPublicKeyToTonSafeFormat, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Converts public key to ton safe_format
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func convert_public_key_to_ton_safe_format(_ payload: TSDKParamsOfConvertPublicKeyToTonSafeFormat) async throws -> TSDKResultOfConvertPublicKeyToTonSafeFormat {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "convert_public_key_to_ton_safe_format"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfConvertPublicKeyToTonSafeFormat, TSDKClientError> = .init()
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

    /// Generates random ed25519 key pair.
    public func generate_random_sign_keys(_ handler: @escaping @Sendable (TSDKBindingResponse<TSDKKeyPair, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "generate_random_sign_keys"
        try binding.requestLibraryAsync(methodName(module, method), "") { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKKeyPair, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Generates random ed25519 key pair.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func generate_random_sign_keys() async throws -> TSDKKeyPair {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "generate_random_sign_keys"
                try binding.requestLibraryAsyncAwait(methodName(module, method), "") { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKKeyPair, TSDKClientError> = .init()
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

    /// Signs a data using the provided keys.
    public func sign(_ payload: TSDKParamsOfSign, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfSign, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "sign"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfSign, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Signs a data using the provided keys.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func sign(_ payload: TSDKParamsOfSign) async throws -> TSDKResultOfSign {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "sign"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfSign, TSDKClientError> = .init()
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

    /// Verifies signed data using the provided public key. Raises error if verification is failed.
    public func verify_signature(_ payload: TSDKParamsOfVerifySignature, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfVerifySignature, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "verify_signature"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfVerifySignature, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Verifies signed data using the provided public key. Raises error if verification is failed.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func verify_signature(_ payload: TSDKParamsOfVerifySignature) async throws -> TSDKResultOfVerifySignature {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "verify_signature"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfVerifySignature, TSDKClientError> = .init()
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

    /// Calculates SHA256 hash of the specified data.
    public func sha256(_ payload: TSDKParamsOfHash, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfHash, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "sha256"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfHash, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Calculates SHA256 hash of the specified data.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func sha256(_ payload: TSDKParamsOfHash) async throws -> TSDKResultOfHash {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "sha256"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfHash, TSDKClientError> = .init()
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

    /// Calculates SHA512 hash of the specified data.
    public func sha512(_ payload: TSDKParamsOfHash, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfHash, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "sha512"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfHash, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Calculates SHA512 hash of the specified data.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func sha512(_ payload: TSDKParamsOfHash) async throws -> TSDKResultOfHash {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "sha512"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfHash, TSDKClientError> = .init()
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

    /// Perform `scrypt` encryption
    /// Derives key from `password` and `key` using `scrypt` algorithm.
    /// See [https://en.wikipedia.org/wiki/Scrypt].
    /// # Arguments- `log_n` - The log2 of the Scrypt parameter `N`- `r` - The Scrypt parameter `r`- `p` - The Scrypt parameter `p`# Conditions- `log_n` must be less than `64`- `r` must be greater than `0` and less than or equal to `4294967295`- `p` must be greater than `0` and less than `4294967295`# Recommended values sufficient for most use-cases- `log_n = 15` (`n = 32768`)- `r = 8`- `p = 1`
    public func scrypt(_ payload: TSDKParamsOfScrypt, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfScrypt, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "scrypt"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfScrypt, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Perform `scrypt` encryption
    /// Derives key from `password` and `key` using `scrypt` algorithm.
    /// See [https://en.wikipedia.org/wiki/Scrypt].
    /// # Arguments- `log_n` - The log2 of the Scrypt parameter `N`- `r` - The Scrypt parameter `r`- `p` - The Scrypt parameter `p`# Conditions- `log_n` must be less than `64`- `r` must be greater than `0` and less than or equal to `4294967295`- `p` must be greater than `0` and less than `4294967295`# Recommended values sufficient for most use-cases- `log_n = 15` (`n = 32768`)- `r = 8`- `p = 1`
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func scrypt(_ payload: TSDKParamsOfScrypt) async throws -> TSDKResultOfScrypt {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "scrypt"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfScrypt, TSDKClientError> = .init()
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

    /// Generates a key pair for signing from the secret key
    /// **NOTE:** In the result the secret key is actually the concatenationof secret and public keys (128 symbols hex string) by design of [NaCL](http://nacl.cr.yp.to/sign.html).
    /// See also [the stackexchange question](https://crypto.stackexchange.com/questions/54353/).
    public func nacl_sign_keypair_from_secret_key(_ payload: TSDKParamsOfNaclSignKeyPairFromSecret, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKKeyPair, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "nacl_sign_keypair_from_secret_key"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKKeyPair, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Generates a key pair for signing from the secret key
    /// **NOTE:** In the result the secret key is actually the concatenationof secret and public keys (128 symbols hex string) by design of [NaCL](http://nacl.cr.yp.to/sign.html).
    /// See also [the stackexchange question](https://crypto.stackexchange.com/questions/54353/).
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func nacl_sign_keypair_from_secret_key(_ payload: TSDKParamsOfNaclSignKeyPairFromSecret) async throws -> TSDKKeyPair {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "nacl_sign_keypair_from_secret_key"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKKeyPair, TSDKClientError> = .init()
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

    /// Signs data using the signer's secret key.
    public func nacl_sign(_ payload: TSDKParamsOfNaclSign, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfNaclSign, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "nacl_sign"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfNaclSign, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Signs data using the signer's secret key.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func nacl_sign(_ payload: TSDKParamsOfNaclSign) async throws -> TSDKResultOfNaclSign {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "nacl_sign"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfNaclSign, TSDKClientError> = .init()
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

    /// Verifies the signature and returns the unsigned message
    /// Verifies the signature in `signed` using the signer's public key `public`and returns the message `unsigned`.
    /// If the signature fails verification, crypto_sign_open raises an exception.
    public func nacl_sign_open(_ payload: TSDKParamsOfNaclSignOpen, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfNaclSignOpen, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "nacl_sign_open"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfNaclSignOpen, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Verifies the signature and returns the unsigned message
    /// Verifies the signature in `signed` using the signer's public key `public`and returns the message `unsigned`.
    /// If the signature fails verification, crypto_sign_open raises an exception.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func nacl_sign_open(_ payload: TSDKParamsOfNaclSignOpen) async throws -> TSDKResultOfNaclSignOpen {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "nacl_sign_open"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfNaclSignOpen, TSDKClientError> = .init()
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

    /// Signs the message using the secret key and returns a signature.
    /// Signs the message `unsigned` using the secret key `secret`and returns a signature `signature`.
    public func nacl_sign_detached(_ payload: TSDKParamsOfNaclSign, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfNaclSignDetached, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "nacl_sign_detached"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfNaclSignDetached, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Signs the message using the secret key and returns a signature.
    /// Signs the message `unsigned` using the secret key `secret`and returns a signature `signature`.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func nacl_sign_detached(_ payload: TSDKParamsOfNaclSign) async throws -> TSDKResultOfNaclSignDetached {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "nacl_sign_detached"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfNaclSignDetached, TSDKClientError> = .init()
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

    /// Verifies the signature with public key and `unsigned` data.
    public func nacl_sign_detached_verify(_ payload: TSDKParamsOfNaclSignDetachedVerify, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfNaclSignDetachedVerify, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "nacl_sign_detached_verify"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfNaclSignDetachedVerify, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Verifies the signature with public key and `unsigned` data.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func nacl_sign_detached_verify(_ payload: TSDKParamsOfNaclSignDetachedVerify) async throws -> TSDKResultOfNaclSignDetachedVerify {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "nacl_sign_detached_verify"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfNaclSignDetachedVerify, TSDKClientError> = .init()
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

    /// Generates a random NaCl key pair
    public func nacl_box_keypair(_ handler: @escaping @Sendable (TSDKBindingResponse<TSDKKeyPair, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "nacl_box_keypair"
        try binding.requestLibraryAsync(methodName(module, method), "") { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKKeyPair, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Generates a random NaCl key pair
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func nacl_box_keypair() async throws -> TSDKKeyPair {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "nacl_box_keypair"
                try binding.requestLibraryAsyncAwait(methodName(module, method), "") { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKKeyPair, TSDKClientError> = .init()
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

    /// Generates key pair from a secret key
    public func nacl_box_keypair_from_secret_key(_ payload: TSDKParamsOfNaclBoxKeyPairFromSecret, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKKeyPair, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "nacl_box_keypair_from_secret_key"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKKeyPair, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Generates key pair from a secret key
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func nacl_box_keypair_from_secret_key(_ payload: TSDKParamsOfNaclBoxKeyPairFromSecret) async throws -> TSDKKeyPair {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "nacl_box_keypair_from_secret_key"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKKeyPair, TSDKClientError> = .init()
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

    /// Public key authenticated encryption
    /// Encrypt and authenticate a message using the senders secret key, the receivers publickey, and a nonce.
    public func nacl_box(_ payload: TSDKParamsOfNaclBox, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfNaclBox, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "nacl_box"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfNaclBox, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Public key authenticated encryption
    /// Encrypt and authenticate a message using the senders secret key, the receivers publickey, and a nonce.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func nacl_box(_ payload: TSDKParamsOfNaclBox) async throws -> TSDKResultOfNaclBox {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "nacl_box"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfNaclBox, TSDKClientError> = .init()
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

    /// Decrypt and verify the cipher text using the receivers secret key, the senders public key, and the nonce.
    public func nacl_box_open(_ payload: TSDKParamsOfNaclBoxOpen, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfNaclBoxOpen, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "nacl_box_open"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfNaclBoxOpen, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Decrypt and verify the cipher text using the receivers secret key, the senders public key, and the nonce.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func nacl_box_open(_ payload: TSDKParamsOfNaclBoxOpen) async throws -> TSDKResultOfNaclBoxOpen {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "nacl_box_open"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfNaclBoxOpen, TSDKClientError> = .init()
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

    /// Encrypt and authenticate message using nonce and secret key.
    public func nacl_secret_box(_ payload: TSDKParamsOfNaclSecretBox, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfNaclBox, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "nacl_secret_box"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfNaclBox, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Encrypt and authenticate message using nonce and secret key.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func nacl_secret_box(_ payload: TSDKParamsOfNaclSecretBox) async throws -> TSDKResultOfNaclBox {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "nacl_secret_box"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfNaclBox, TSDKClientError> = .init()
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

    /// Decrypts and verifies cipher text using `nonce` and secret `key`.
    public func nacl_secret_box_open(_ payload: TSDKParamsOfNaclSecretBoxOpen, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfNaclBoxOpen, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "nacl_secret_box_open"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfNaclBoxOpen, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Decrypts and verifies cipher text using `nonce` and secret `key`.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func nacl_secret_box_open(_ payload: TSDKParamsOfNaclSecretBoxOpen) async throws -> TSDKResultOfNaclBoxOpen {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "nacl_secret_box_open"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfNaclBoxOpen, TSDKClientError> = .init()
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

    /// Prints the list of words from the specified dictionary
    public func mnemonic_words(_ payload: TSDKParamsOfMnemonicWords, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfMnemonicWords, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "mnemonic_words"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfMnemonicWords, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Prints the list of words from the specified dictionary
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func mnemonic_words(_ payload: TSDKParamsOfMnemonicWords) async throws -> TSDKResultOfMnemonicWords {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "mnemonic_words"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfMnemonicWords, TSDKClientError> = .init()
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

    /// Generates a random mnemonic
    /// Generates a random mnemonic from the specified dictionary and word count
    public func mnemonic_from_random(_ payload: TSDKParamsOfMnemonicFromRandom, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfMnemonicFromRandom, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "mnemonic_from_random"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfMnemonicFromRandom, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Generates a random mnemonic
    /// Generates a random mnemonic from the specified dictionary and word count
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func mnemonic_from_random(_ payload: TSDKParamsOfMnemonicFromRandom) async throws -> TSDKResultOfMnemonicFromRandom {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "mnemonic_from_random"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfMnemonicFromRandom, TSDKClientError> = .init()
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

    /// Generates mnemonic from pre-generated entropy
    public func mnemonic_from_entropy(_ payload: TSDKParamsOfMnemonicFromEntropy, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfMnemonicFromEntropy, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "mnemonic_from_entropy"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfMnemonicFromEntropy, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Generates mnemonic from pre-generated entropy
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func mnemonic_from_entropy(_ payload: TSDKParamsOfMnemonicFromEntropy) async throws -> TSDKResultOfMnemonicFromEntropy {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "mnemonic_from_entropy"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfMnemonicFromEntropy, TSDKClientError> = .init()
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

    /// Validates a mnemonic phrase
    /// The phrase supplied will be checked for word length and validated according to the checksumspecified in BIP0039.
    public func mnemonic_verify(_ payload: TSDKParamsOfMnemonicVerify, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfMnemonicVerify, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "mnemonic_verify"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfMnemonicVerify, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Validates a mnemonic phrase
    /// The phrase supplied will be checked for word length and validated according to the checksumspecified in BIP0039.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func mnemonic_verify(_ payload: TSDKParamsOfMnemonicVerify) async throws -> TSDKResultOfMnemonicVerify {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "mnemonic_verify"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfMnemonicVerify, TSDKClientError> = .init()
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

    /// Derives a key pair for signing from the seed phrase
    /// Validates the seed phrase, generates master key and then derivesthe key pair from the master key and the specified path
    public func mnemonic_derive_sign_keys(_ payload: TSDKParamsOfMnemonicDeriveSignKeys, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKKeyPair, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "mnemonic_derive_sign_keys"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKKeyPair, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Derives a key pair for signing from the seed phrase
    /// Validates the seed phrase, generates master key and then derivesthe key pair from the master key and the specified path
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func mnemonic_derive_sign_keys(_ payload: TSDKParamsOfMnemonicDeriveSignKeys) async throws -> TSDKKeyPair {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "mnemonic_derive_sign_keys"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKKeyPair, TSDKClientError> = .init()
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

    /// Generates an extended master private key that will be the root for all the derived keys
    public func hdkey_xprv_from_mnemonic(_ payload: TSDKParamsOfHDKeyXPrvFromMnemonic, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfHDKeyXPrvFromMnemonic, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "hdkey_xprv_from_mnemonic"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfHDKeyXPrvFromMnemonic, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Generates an extended master private key that will be the root for all the derived keys
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func hdkey_xprv_from_mnemonic(_ payload: TSDKParamsOfHDKeyXPrvFromMnemonic) async throws -> TSDKResultOfHDKeyXPrvFromMnemonic {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "hdkey_xprv_from_mnemonic"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfHDKeyXPrvFromMnemonic, TSDKClientError> = .init()
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

    /// Returns extended private key derived from the specified extended private key and child index
    public func hdkey_derive_from_xprv(_ payload: TSDKParamsOfHDKeyDeriveFromXPrv, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfHDKeyDeriveFromXPrv, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "hdkey_derive_from_xprv"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfHDKeyDeriveFromXPrv, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Returns extended private key derived from the specified extended private key and child index
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func hdkey_derive_from_xprv(_ payload: TSDKParamsOfHDKeyDeriveFromXPrv) async throws -> TSDKResultOfHDKeyDeriveFromXPrv {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "hdkey_derive_from_xprv"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfHDKeyDeriveFromXPrv, TSDKClientError> = .init()
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

    /// Derives the extended private key from the specified key and path
    public func hdkey_derive_from_xprv_path(_ payload: TSDKParamsOfHDKeyDeriveFromXPrvPath, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfHDKeyDeriveFromXPrvPath, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "hdkey_derive_from_xprv_path"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfHDKeyDeriveFromXPrvPath, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Derives the extended private key from the specified key and path
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func hdkey_derive_from_xprv_path(_ payload: TSDKParamsOfHDKeyDeriveFromXPrvPath) async throws -> TSDKResultOfHDKeyDeriveFromXPrvPath {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "hdkey_derive_from_xprv_path"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfHDKeyDeriveFromXPrvPath, TSDKClientError> = .init()
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

    /// Extracts the private key from the serialized extended private key
    public func hdkey_secret_from_xprv(_ payload: TSDKParamsOfHDKeySecretFromXPrv, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfHDKeySecretFromXPrv, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "hdkey_secret_from_xprv"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfHDKeySecretFromXPrv, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Extracts the private key from the serialized extended private key
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func hdkey_secret_from_xprv(_ payload: TSDKParamsOfHDKeySecretFromXPrv) async throws -> TSDKResultOfHDKeySecretFromXPrv {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "hdkey_secret_from_xprv"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfHDKeySecretFromXPrv, TSDKClientError> = .init()
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

    /// Extracts the public key from the serialized extended private key
    public func hdkey_public_from_xprv(_ payload: TSDKParamsOfHDKeyPublicFromXPrv, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfHDKeyPublicFromXPrv, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "hdkey_public_from_xprv"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfHDKeyPublicFromXPrv, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Extracts the public key from the serialized extended private key
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func hdkey_public_from_xprv(_ payload: TSDKParamsOfHDKeyPublicFromXPrv) async throws -> TSDKResultOfHDKeyPublicFromXPrv {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "hdkey_public_from_xprv"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfHDKeyPublicFromXPrv, TSDKClientError> = .init()
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

    /// Performs symmetric `chacha20` encryption.
    public func chacha20(_ payload: TSDKParamsOfChaCha20, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfChaCha20, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "chacha20"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfChaCha20, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Performs symmetric `chacha20` encryption.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func chacha20(_ payload: TSDKParamsOfChaCha20) async throws -> TSDKResultOfChaCha20 {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "chacha20"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfChaCha20, TSDKClientError> = .init()
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

    /// Creates a Crypto Box instance.
    /// Crypto Box is a root crypto object, that encapsulates some secret (seed phrase usually)in encrypted form and acts as a factory for all crypto primitives used in SDK:
    /// keys for signing and encryption, derived from this secret.
    /// Crypto Box encrypts original Seed Phrase with salt and password that is retrievedfrom `password_provider` callback, implemented on Application side.
    /// When used, decrypted secret shows up in core library's memory for a very short periodof time and then is immediately overwritten with zeroes.
    public func create_crypto_box(_ payload: TSDKParamsOfCreateCryptoBox, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKRegisteredCryptoBox, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "create_crypto_box"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKRegisteredCryptoBox, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Creates a Crypto Box instance.
    /// Crypto Box is a root crypto object, that encapsulates some secret (seed phrase usually)in encrypted form and acts as a factory for all crypto primitives used in SDK:
    /// keys for signing and encryption, derived from this secret.
    /// Crypto Box encrypts original Seed Phrase with salt and password that is retrievedfrom `password_provider` callback, implemented on Application side.
    /// When used, decrypted secret shows up in core library's memory for a very short periodof time and then is immediately overwritten with zeroes.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func create_crypto_box(_ payload: TSDKParamsOfCreateCryptoBox) async throws -> TSDKRegisteredCryptoBox {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "create_crypto_box"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKRegisteredCryptoBox, TSDKClientError> = .init()
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

    /// Removes Crypto Box. Clears all secret data.
    public func remove_crypto_box(_ payload: TSDKRegisteredCryptoBox, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "remove_crypto_box"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Removes Crypto Box. Clears all secret data.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func remove_crypto_box(_ payload: TSDKRegisteredCryptoBox) async throws -> TSDKNoneResult {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "remove_crypto_box"
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

    /// Get Crypto Box Info. Used to get `encrypted_secret` that should be used for all the cryptobox initializations except the first one.
    public func get_crypto_box_info(_ payload: TSDKRegisteredCryptoBox, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfGetCryptoBoxInfo, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "get_crypto_box_info"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetCryptoBoxInfo, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Get Crypto Box Info. Used to get `encrypted_secret` that should be used for all the cryptobox initializations except the first one.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func get_crypto_box_info(_ payload: TSDKRegisteredCryptoBox) async throws -> TSDKResultOfGetCryptoBoxInfo {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "get_crypto_box_info"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfGetCryptoBoxInfo, TSDKClientError> = .init()
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

    /// Get Crypto Box Seed Phrase.
    /// Attention! Store this data in your application for a very short period of time and overwrite it with zeroes ASAP.
    public func get_crypto_box_seed_phrase(_ payload: TSDKRegisteredCryptoBox, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfGetCryptoBoxSeedPhrase, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "get_crypto_box_seed_phrase"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetCryptoBoxSeedPhrase, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Get Crypto Box Seed Phrase.
    /// Attention! Store this data in your application for a very short period of time and overwrite it with zeroes ASAP.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func get_crypto_box_seed_phrase(_ payload: TSDKRegisteredCryptoBox) async throws -> TSDKResultOfGetCryptoBoxSeedPhrase {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "get_crypto_box_seed_phrase"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfGetCryptoBoxSeedPhrase, TSDKClientError> = .init()
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

    /// Get handle of Signing Box derived from Crypto Box.
    public func get_signing_box_from_crypto_box(_ payload: TSDKParamsOfGetSigningBoxFromCryptoBox, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKRegisteredSigningBox, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "get_signing_box_from_crypto_box"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKRegisteredSigningBox, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Get handle of Signing Box derived from Crypto Box.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func get_signing_box_from_crypto_box(_ payload: TSDKParamsOfGetSigningBoxFromCryptoBox) async throws -> TSDKRegisteredSigningBox {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "get_signing_box_from_crypto_box"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKRegisteredSigningBox, TSDKClientError> = .init()
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

    /// Gets Encryption Box from Crypto Box.
    /// Derives encryption keypair from cryptobox secret and hdpath andstores it in cache for `secret_lifetime`or until explicitly cleared by `clear_crypto_box_secret_cache` method.
    /// If `secret_lifetime` is not specified - overwrites encryption secret with zeroes immediately afterencryption operation.
    public func get_encryption_box_from_crypto_box(_ payload: TSDKParamsOfGetEncryptionBoxFromCryptoBox, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKRegisteredEncryptionBox, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "get_encryption_box_from_crypto_box"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKRegisteredEncryptionBox, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Gets Encryption Box from Crypto Box.
    /// Derives encryption keypair from cryptobox secret and hdpath andstores it in cache for `secret_lifetime`or until explicitly cleared by `clear_crypto_box_secret_cache` method.
    /// If `secret_lifetime` is not specified - overwrites encryption secret with zeroes immediately afterencryption operation.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func get_encryption_box_from_crypto_box(_ payload: TSDKParamsOfGetEncryptionBoxFromCryptoBox) async throws -> TSDKRegisteredEncryptionBox {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "get_encryption_box_from_crypto_box"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKRegisteredEncryptionBox, TSDKClientError> = .init()
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

    /// Removes cached secrets (overwrites with zeroes) from all signing and encryption boxes, derived from crypto box.
    public func clear_crypto_box_secret_cache(_ payload: TSDKRegisteredCryptoBox, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "clear_crypto_box_secret_cache"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Removes cached secrets (overwrites with zeroes) from all signing and encryption boxes, derived from crypto box.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func clear_crypto_box_secret_cache(_ payload: TSDKRegisteredCryptoBox) async throws -> TSDKNoneResult {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "clear_crypto_box_secret_cache"
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

    /// Register an application implemented signing box.
    public func register_signing_box(_ handler: @escaping @Sendable (TSDKBindingResponse<TSDKRegisteredSigningBox, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "register_signing_box"
        try binding.requestLibraryAsync(methodName(module, method), "") { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKRegisteredSigningBox, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Register an application implemented signing box.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func register_signing_box() async throws -> TSDKRegisteredSigningBox {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "register_signing_box"
                try binding.requestLibraryAsyncAwait(methodName(module, method), "") { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKRegisteredSigningBox, TSDKClientError> = .init()
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

    /// Creates a default signing box implementation.
    public func get_signing_box(_ payload: TSDKKeyPair, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKRegisteredSigningBox, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "get_signing_box"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKRegisteredSigningBox, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Creates a default signing box implementation.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func get_signing_box(_ payload: TSDKKeyPair) async throws -> TSDKRegisteredSigningBox {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "get_signing_box"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKRegisteredSigningBox, TSDKClientError> = .init()
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

    /// Returns public key of signing key pair.
    public func signing_box_get_public_key(_ payload: TSDKRegisteredSigningBox, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfSigningBoxGetPublicKey, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "signing_box_get_public_key"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfSigningBoxGetPublicKey, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Returns public key of signing key pair.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func signing_box_get_public_key(_ payload: TSDKRegisteredSigningBox) async throws -> TSDKResultOfSigningBoxGetPublicKey {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "signing_box_get_public_key"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfSigningBoxGetPublicKey, TSDKClientError> = .init()
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

    /// Returns signed user data.
    public func signing_box_sign(_ payload: TSDKParamsOfSigningBoxSign, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfSigningBoxSign, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "signing_box_sign"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfSigningBoxSign, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Returns signed user data.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func signing_box_sign(_ payload: TSDKParamsOfSigningBoxSign) async throws -> TSDKResultOfSigningBoxSign {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "signing_box_sign"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfSigningBoxSign, TSDKClientError> = .init()
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

    /// Removes signing box from SDK.
    public func remove_signing_box(_ payload: TSDKRegisteredSigningBox, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "remove_signing_box"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Removes signing box from SDK.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func remove_signing_box(_ payload: TSDKRegisteredSigningBox) async throws -> TSDKNoneResult {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "remove_signing_box"
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

    /// Register an application implemented encryption box.
    public func register_encryption_box(_ handler: @escaping @Sendable (TSDKBindingResponse<TSDKRegisteredEncryptionBox, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "register_encryption_box"
        try binding.requestLibraryAsync(methodName(module, method), "") { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKRegisteredEncryptionBox, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Register an application implemented encryption box.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func register_encryption_box() async throws -> TSDKRegisteredEncryptionBox {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "register_encryption_box"
                try binding.requestLibraryAsyncAwait(methodName(module, method), "") { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKRegisteredEncryptionBox, TSDKClientError> = .init()
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

    /// Removes encryption box from SDK
    public func remove_encryption_box(_ payload: TSDKRegisteredEncryptionBox, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "remove_encryption_box"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Removes encryption box from SDK
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func remove_encryption_box(_ payload: TSDKRegisteredEncryptionBox) async throws -> TSDKNoneResult {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "remove_encryption_box"
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

    /// Queries info from the given encryption box
    public func encryption_box_get_info(_ payload: TSDKParamsOfEncryptionBoxGetInfo, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfEncryptionBoxGetInfo, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "encryption_box_get_info"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncryptionBoxGetInfo, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Queries info from the given encryption box
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func encryption_box_get_info(_ payload: TSDKParamsOfEncryptionBoxGetInfo) async throws -> TSDKResultOfEncryptionBoxGetInfo {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "encryption_box_get_info"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfEncryptionBoxGetInfo, TSDKClientError> = .init()
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

    /// Encrypts data using given encryption box Note.
    /// Block cipher algorithms pad data to cipher block size so encrypted data can be longer then original data. Client should store the original data size after encryption and use it afterdecryption to retrieve the original data from decrypted data.
    public func encryption_box_encrypt(_ payload: TSDKParamsOfEncryptionBoxEncrypt, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfEncryptionBoxEncrypt, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "encryption_box_encrypt"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncryptionBoxEncrypt, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Encrypts data using given encryption box Note.
    /// Block cipher algorithms pad data to cipher block size so encrypted data can be longer then original data. Client should store the original data size after encryption and use it afterdecryption to retrieve the original data from decrypted data.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func encryption_box_encrypt(_ payload: TSDKParamsOfEncryptionBoxEncrypt) async throws -> TSDKResultOfEncryptionBoxEncrypt {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "encryption_box_encrypt"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfEncryptionBoxEncrypt, TSDKClientError> = .init()
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

    /// Decrypts data using given encryption box Note.
    /// Block cipher algorithms pad data to cipher block size so encrypted data can be longer then original data. Client should store the original data size after encryption and use it afterdecryption to retrieve the original data from decrypted data.
    public func encryption_box_decrypt(_ payload: TSDKParamsOfEncryptionBoxDecrypt, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfEncryptionBoxDecrypt, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "encryption_box_decrypt"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncryptionBoxDecrypt, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Decrypts data using given encryption box Note.
    /// Block cipher algorithms pad data to cipher block size so encrypted data can be longer then original data. Client should store the original data size after encryption and use it afterdecryption to retrieve the original data from decrypted data.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func encryption_box_decrypt(_ payload: TSDKParamsOfEncryptionBoxDecrypt) async throws -> TSDKResultOfEncryptionBoxDecrypt {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "encryption_box_decrypt"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfEncryptionBoxDecrypt, TSDKClientError> = .init()
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

    /// Creates encryption box with specified algorithm
    public func create_encryption_box(_ payload: TSDKParamsOfCreateEncryptionBox, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKRegisteredEncryptionBox, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "create_encryption_box"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKRegisteredEncryptionBox, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Creates encryption box with specified algorithm
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func create_encryption_box(_ payload: TSDKParamsOfCreateEncryptionBox) async throws -> TSDKRegisteredEncryptionBox {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "create_encryption_box"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKRegisteredEncryptionBox, TSDKClientError> = .init()
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
