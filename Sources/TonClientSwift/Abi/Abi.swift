public final class TSDKAbiModule {

    private var binding: TSDKBindingModule
    public let module: String = "abi"

    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }

    /// Encodes message body according to ABI function call.
    public func encode_message_body(_ payload: TSDKParamsOfEncodeMessageBody, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfEncodeMessageBody, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "encode_message_body"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncodeMessageBody, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func attach_signature_to_message_body(_ payload: TSDKParamsOfAttachSignatureToMessageBody, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfAttachSignatureToMessageBody, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "attach_signature_to_message_body"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfAttachSignatureToMessageBody, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
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
    public func encode_message(_ payload: TSDKParamsOfEncodeMessage, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfEncodeMessage, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "encode_message"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncodeMessage, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
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
    public func encode_internal_message(_ payload: TSDKParamsOfEncodeInternalMessage, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfEncodeInternalMessage, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "encode_internal_message"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncodeInternalMessage, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Combines `hex`-encoded `signature` with `base64`-encoded `unsigned_message`. Returns signed message encoded in `base64`.
    public func attach_signature(_ payload: TSDKParamsOfAttachSignature, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfAttachSignature, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "attach_signature"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfAttachSignature, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Decodes message body using provided message BOC and ABI.
    public func decode_message(_ payload: TSDKParamsOfDecodeMessage, _ handler: @escaping (TSDKBindingResponse<TSDKDecodedMessageBody, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "decode_message"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKDecodedMessageBody, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Decodes message body using provided body BOC and ABI.
    public func decode_message_body(_ payload: TSDKParamsOfDecodeMessageBody, _ handler: @escaping (TSDKBindingResponse<TSDKDecodedMessageBody, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "decode_message_body"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKDecodedMessageBody, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Creates account state BOC
    /// Creates account state provided with one of these sets of data :
    /// 1. BOC of code, BOC of data, BOC of library2. TVC (string in `base64`), keys, init params
    public func encode_account(_ payload: TSDKParamsOfEncodeAccount, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfEncodeAccount, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "encode_account"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncodeAccount, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

}
