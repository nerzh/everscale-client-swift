public final class TSDKCryptoModule {

    private var binding: TSDKBindingModule
    public let module: String = "crypto"

    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }

    /// Integer factorization
    /// Performs prime factorization – decomposition of a composite numberinto a product of smaller prime integers (factors).
    /// See [https://en.wikipedia.org/wiki/Integer_factorization]
    public func factorize(_ payload: TSDKParamsOfFactorize, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfFactorize, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "factorize"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfFactorize, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Modular exponentiation
    /// Performs modular exponentiation for big integers (`base`^`exponent` mod `modulus`).
    /// See [https://en.wikipedia.org/wiki/Modular_exponentiation]
    public func modular_power(_ payload: TSDKParamsOfModularPower, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfModularPower, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "modular_power"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfModularPower, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Calculates CRC16 using TON algorithm.
    public func ton_crc16(_ payload: TSDKParamsOfTonCrc16, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfTonCrc16, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "ton_crc16"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfTonCrc16, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Generates random byte array of the specified length and returns it in `base64` format
    public func generate_random_bytes(_ payload: TSDKParamsOfGenerateRandomBytes, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfGenerateRandomBytes, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "generate_random_bytes"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGenerateRandomBytes, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Converts public key to ton safe_format
    public func convert_public_key_to_ton_safe_format(_ payload: TSDKParamsOfConvertPublicKeyToTonSafeFormat, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfConvertPublicKeyToTonSafeFormat, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "convert_public_key_to_ton_safe_format"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfConvertPublicKeyToTonSafeFormat, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Generates random ed25519 key pair.
    public func generate_random_sign_keys(_ handler: @escaping (TSDKBindingResponse<TSDKKeyPair, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "generate_random_sign_keys"
        binding.requestLibraryAsync(methodName(module, method), "", { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKKeyPair, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Signs a data using the provided keys.
    public func sign(_ payload: TSDKParamsOfSign, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfSign, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "sign"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfSign, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Verifies signed data using the provided public key. Raises error if verification is failed.
    public func verify_signature(_ payload: TSDKParamsOfVerifySignature, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfVerifySignature, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "verify_signature"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfVerifySignature, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Calculates SHA256 hash of the specified data.
    public func sha256(_ payload: TSDKParamsOfHash, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfHash, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "sha256"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfHash, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Calculates SHA512 hash of the specified data.
    public func sha512(_ payload: TSDKParamsOfHash, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfHash, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "sha512"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfHash, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Perform `scrypt` encryption
    /// Derives key from `password` and `key` using `scrypt` algorithm.
    /// See [https://en.wikipedia.org/wiki/Scrypt].
    /// # Arguments- `log_n` - The log2 of the Scrypt parameter `N`- `r` - The Scrypt parameter `r`- `p` - The Scrypt parameter `p`# Conditions- `log_n` must be less than `64`- `r` must be greater than `0` and less than or equal to `4294967295`- `p` must be greater than `0` and less than `4294967295`# Recommended values sufficient for most use-cases- `log_n = 15` (`n = 32768`)- `r = 8`- `p = 1`
    public func scrypt(_ payload: TSDKParamsOfScrypt, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfScrypt, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "scrypt"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfScrypt, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Generates a key pair for signing from the secret key
    public func nacl_sign_keypair_from_secret_key(_ payload: TSDKParamsOfNaclSignKeyPairFromSecret, _ handler: @escaping (TSDKBindingResponse<TSDKKeyPair, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_sign_keypair_from_secret_key"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKKeyPair, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Signs data using the signer's secret key.
    public func nacl_sign(_ payload: TSDKParamsOfNaclSign, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfNaclSign, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_sign"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfNaclSign, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Verifies the signature and returns the unsigned message
    /// Verifies the signature in `signed` using the signer's public key `public`and returns the message `unsigned`.
    /// If the signature fails verification, crypto_sign_open raises an exception.
    public func nacl_sign_open(_ payload: TSDKParamsOfNaclSignOpen, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfNaclSignOpen, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_sign_open"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfNaclSignOpen, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Signs the message using the secret key and returns a signature.
    /// Signs the message `unsigned` using the secret key `secret`and returns a signature `signature`.
    public func nacl_sign_detached(_ payload: TSDKParamsOfNaclSign, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfNaclSignDetached, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_sign_detached"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfNaclSignDetached, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Verifies the signature with public key and `unsigned` data.
    public func nacl_sign_detached_verify(_ payload: TSDKParamsOfNaclSignDetachedVerify, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfNaclSignDetachedVerify, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_sign_detached_verify"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfNaclSignDetachedVerify, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Generates a random NaCl key pair
    public func nacl_box_keypair(_ handler: @escaping (TSDKBindingResponse<TSDKKeyPair, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_box_keypair"
        binding.requestLibraryAsync(methodName(module, method), "", { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKKeyPair, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Generates key pair from a secret key
    public func nacl_box_keypair_from_secret_key(_ payload: TSDKParamsOfNaclBoxKeyPairFromSecret, _ handler: @escaping (TSDKBindingResponse<TSDKKeyPair, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_box_keypair_from_secret_key"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKKeyPair, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Public key authenticated encryption
    /// Encrypt and authenticate a message using the senders secret key, the receivers publickey, and a nonce.
    public func nacl_box(_ payload: TSDKParamsOfNaclBox, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfNaclBox, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_box"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfNaclBox, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Decrypt and verify the cipher text using the receivers secret key, the senders public key, and the nonce.
    public func nacl_box_open(_ payload: TSDKParamsOfNaclBoxOpen, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfNaclBoxOpen, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_box_open"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfNaclBoxOpen, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Encrypt and authenticate message using nonce and secret key.
    public func nacl_secret_box(_ payload: TSDKParamsOfNaclSecretBox, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfNaclBox, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_secret_box"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfNaclBox, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Decrypts and verifies cipher text using `nonce` and secret `key`.
    public func nacl_secret_box_open(_ payload: TSDKParamsOfNaclSecretBoxOpen, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfNaclBoxOpen, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_secret_box_open"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfNaclBoxOpen, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Prints the list of words from the specified dictionary
    public func mnemonic_words(_ payload: TSDKParamsOfMnemonicWords, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfMnemonicWords, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "mnemonic_words"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfMnemonicWords, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Generates a random mnemonic
    /// Generates a random mnemonic from the specified dictionary and word count
    public func mnemonic_from_random(_ payload: TSDKParamsOfMnemonicFromRandom, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfMnemonicFromRandom, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "mnemonic_from_random"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfMnemonicFromRandom, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Generates mnemonic from pre-generated entropy
    public func mnemonic_from_entropy(_ payload: TSDKParamsOfMnemonicFromEntropy, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfMnemonicFromEntropy, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "mnemonic_from_entropy"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfMnemonicFromEntropy, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Validates a mnemonic phrase
    /// The phrase supplied will be checked for word length and validated according to the checksumspecified in BIP0039.
    public func mnemonic_verify(_ payload: TSDKParamsOfMnemonicVerify, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfMnemonicVerify, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "mnemonic_verify"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfMnemonicVerify, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Derives a key pair for signing from the seed phrase
    /// Validates the seed phrase, generates master key and then derivesthe key pair from the master key and the specified path
    public func mnemonic_derive_sign_keys(_ payload: TSDKParamsOfMnemonicDeriveSignKeys, _ handler: @escaping (TSDKBindingResponse<TSDKKeyPair, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "mnemonic_derive_sign_keys"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKKeyPair, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Generates an extended master private key that will be the root for all the derived keys
    public func hdkey_xprv_from_mnemonic(_ payload: TSDKParamsOfHDKeyXPrvFromMnemonic, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfHDKeyXPrvFromMnemonic, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "hdkey_xprv_from_mnemonic"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfHDKeyXPrvFromMnemonic, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Returns extended private key derived from the specified extended private key and child index
    public func hdkey_derive_from_xprv(_ payload: TSDKParamsOfHDKeyDeriveFromXPrv, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfHDKeyDeriveFromXPrv, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "hdkey_derive_from_xprv"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfHDKeyDeriveFromXPrv, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Derives the extended private key from the specified key and path
    public func hdkey_derive_from_xprv_path(_ payload: TSDKParamsOfHDKeyDeriveFromXPrvPath, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfHDKeyDeriveFromXPrvPath, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "hdkey_derive_from_xprv_path"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfHDKeyDeriveFromXPrvPath, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Extracts the private key from the serialized extended private key
    public func hdkey_secret_from_xprv(_ payload: TSDKParamsOfHDKeySecretFromXPrv, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfHDKeySecretFromXPrv, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "hdkey_secret_from_xprv"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfHDKeySecretFromXPrv, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Extracts the public key from the serialized extended private key
    public func hdkey_public_from_xprv(_ payload: TSDKParamsOfHDKeyPublicFromXPrv, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfHDKeyPublicFromXPrv, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "hdkey_public_from_xprv"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfHDKeyPublicFromXPrv, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Performs symmetric `chacha20` encryption.
    public func chacha20(_ payload: TSDKParamsOfChaCha20, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfChaCha20, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "chacha20"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfChaCha20, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Register an application implemented signing box.
    public func register_signing_box(_ handler: @escaping (TSDKBindingResponse<TSDKRegisteredSigningBox, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "register_signing_box"
        binding.requestLibraryAsync(methodName(module, method), "", { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKRegisteredSigningBox, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Creates a default signing box implementation.
    public func get_signing_box(_ payload: TSDKKeyPair, _ handler: @escaping (TSDKBindingResponse<TSDKRegisteredSigningBox, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "get_signing_box"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKRegisteredSigningBox, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Returns public key of signing key pair.
    public func signing_box_get_public_key(_ payload: TSDKRegisteredSigningBox, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfSigningBoxGetPublicKey, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "signing_box_get_public_key"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfSigningBoxGetPublicKey, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Returns signed user data.
    public func signing_box_sign(_ payload: TSDKParamsOfSigningBoxSign, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfSigningBoxSign, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "signing_box_sign"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfSigningBoxSign, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Removes signing box from SDK.
    public func remove_signing_box(_ payload: TSDKRegisteredSigningBox, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "remove_signing_box"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

}
