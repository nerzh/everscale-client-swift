public final class TSDKAbiModule {

    private var binding: TSDKBindingModule
    public let module: String = "abi"

    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }

    /// Encodes message body according to ABI function call.
    public func encode_message_body(_ payload: TSDKParamsOfEncodeMessageBody, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfEncodeMessageBody, TSDKClientError>) throws -> Void
    ) {
        let method: String = "encode_message_body"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncodeMessageBody, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    public func attach_signature_to_message_body(_ payload: TSDKParamsOfAttachSignatureToMessageBody, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfAttachSignatureToMessageBody, TSDKClientError>) throws -> Void
    ) {
        let method: String = "attach_signature_to_message_body"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfAttachSignatureToMessageBody, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Encodes an ABI-compatible message
    /// Allows to encode deploy and function call messages,both signed and unsigned.
    /// Use cases include messages of any possible type:
    /// - deploy with initial function call (i.e. `constructor` or any other function that is used for some kindof initialization);
    /// - deploy without initial function call;
    /// - signed/unsigned + data for signing.
    /// `Signer` defines how the message should or shouldn't be signed:
    /// `Signer::None` creates an unsigned message. This may be needed in case of some public methods,that do not require authorization by pubkey.
    /// `Signer::External` takes public key and returns `data_to_sign` for later signing.
    /// Use `attach_signature` method with the result signature to get the signed message.
    /// `Signer::Keys` creates a signed message with provided key pair.
    /// [SOON] `Signer::SigningBox` Allows using a special interface to implement signingwithout private key disclosure to SDK. For instance, in case of using a cold wallet or HSM,when application calls some API to sign data.
    /// There is an optional public key can be provided in deploy set in order to substitute onein TVM file.
    /// Public key resolving priority:
    /// 1. Public key from deploy set.
    /// 2. Public key, specified in TVM file.
    /// 3. Public key, provided by signer.
    public func encode_message(_ payload: TSDKParamsOfEncodeMessage, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfEncodeMessage, TSDKClientError>) throws -> Void
    ) {
        let method: String = "encode_message"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncodeMessage, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Encodes an internal ABI-compatible message
    /// Allows to encode deploy and function call messages.
    /// Use cases include messages of any possible type:
    /// - deploy with initial function call (i.e. `constructor` or any other function that is used for some kindof initialization);
    /// - deploy without initial function call;
    /// - simple function callThere is an optional public key can be provided in deploy set in order to substitute onein TVM file.
    /// Public key resolving priority:
    /// 1. Public key from deploy set.
    /// 2. Public key, specified in TVM file.
    public func encode_internal_message(_ payload: TSDKParamsOfEncodeInternalMessage, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfEncodeInternalMessage, TSDKClientError>) throws -> Void
    ) {
        let method: String = "encode_internal_message"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncodeInternalMessage, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Combines `hex`-encoded `signature` with `base64`-encoded `unsigned_message`. Returns signed message encoded in `base64`.
    public func attach_signature(_ payload: TSDKParamsOfAttachSignature, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfAttachSignature, TSDKClientError>) throws -> Void
    ) {
        let method: String = "attach_signature"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfAttachSignature, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Decodes message body using provided message BOC and ABI.
    public func decode_message(_ payload: TSDKParamsOfDecodeMessage, _ handler: @escaping (TSDKBindingResponse<TSDKDecodedMessageBody, TSDKClientError>) throws -> Void
    ) {
        let method: String = "decode_message"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKDecodedMessageBody, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Decodes message body using provided body BOC and ABI.
    public func decode_message_body(_ payload: TSDKParamsOfDecodeMessageBody, _ handler: @escaping (TSDKBindingResponse<TSDKDecodedMessageBody, TSDKClientError>) throws -> Void
    ) {
        let method: String = "decode_message_body"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKDecodedMessageBody, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Creates account state BOC
    /// Creates account state provided with one of these sets of data :
    /// 1. BOC of code, BOC of data, BOC of library2. TVC (string in `base64`), keys, init params
    public func encode_account(_ payload: TSDKParamsOfEncodeAccount, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfEncodeAccount, TSDKClientError>) throws -> Void
    ) {
        let method: String = "encode_account"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncodeAccount, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Decodes account data using provided data BOC and ABI.
    /// Note: this feature requires ABI 2.1 or higher.
    public func decode_account_data(_ payload: TSDKParamsOfDecodeAccountData, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfDecodeData, TSDKClientError>) throws -> Void
    ) {
        let method: String = "decode_account_data"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfDecodeData, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Updates initial account data with initial values for the contract's static variables and owner's public key. This operation is applicable only for initial account data (before deploy). If the contract is already deployed, its data doesn't contain this data section any more.
    public func update_initial_data(_ payload: TSDKParamsOfUpdateInitialData, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfUpdateInitialData, TSDKClientError>) throws -> Void
    ) {
        let method: String = "update_initial_data"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfUpdateInitialData, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Decodes initial values of a contract's static variables and owner's public key from account initial data This operation is applicable only for initial account data (before deploy). If the contract is already deployed, its data doesn't contain this data section any more.
    public func decode_initial_data(_ payload: TSDKParamsOfDecodeInitialData, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfDecodeInitialData, TSDKClientError>) throws -> Void
    ) {
        let method: String = "decode_initial_data"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfDecodeInitialData, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

}
