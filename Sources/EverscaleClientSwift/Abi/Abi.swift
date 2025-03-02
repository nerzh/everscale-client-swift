public final class TSDKAbiModule {

    private var binding: TSDKBindingModule
    public let module: String = "abi"

    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }

    /// Encodes message body according to ABI function call.
    public func encode_message_body(_ payload: TSDKParamsOfEncodeMessageBody, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfEncodeMessageBody, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "encode_message_body"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncodeMessageBody, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Encodes message body according to ABI function call.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func encode_message_body(_ payload: TSDKParamsOfEncodeMessageBody) async throws -> TSDKResultOfEncodeMessageBody {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "encode_message_body"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfEncodeMessageBody, TSDKClientError> = .init()
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

    public func attach_signature_to_message_body(_ payload: TSDKParamsOfAttachSignatureToMessageBody, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfAttachSignatureToMessageBody, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "attach_signature_to_message_body"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfAttachSignatureToMessageBody, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    @available(iOS 13, *)
    @available(macOS 12, *)
    public func attach_signature_to_message_body(_ payload: TSDKParamsOfAttachSignatureToMessageBody) async throws -> TSDKResultOfAttachSignatureToMessageBody {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "attach_signature_to_message_body"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfAttachSignatureToMessageBody, TSDKClientError> = .init()
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
    public func encode_message(_ payload: TSDKParamsOfEncodeMessage, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfEncodeMessage, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "encode_message"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncodeMessage, TSDKClientError> = .init()
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
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func encode_message(_ payload: TSDKParamsOfEncodeMessage) async throws -> TSDKResultOfEncodeMessage {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "encode_message"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfEncodeMessage, TSDKClientError> = .init()
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

    /// Encodes an internal ABI-compatible message
    /// Allows to encode deploy and function call messages.
    /// Use cases include messages of any possible type:
    /// - deploy with initial function call (i.e. `constructor` or any other function that is used for some kindof initialization);
    /// - deploy without initial function call;
    /// - simple function callThere is an optional public key can be provided in deploy set in order to substitute onein TVM file.
    /// Public key resolving priority:
    /// 1. Public key from deploy set.
    /// 2. Public key, specified in TVM file.
    public func encode_internal_message(_ payload: TSDKParamsOfEncodeInternalMessage, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfEncodeInternalMessage, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "encode_internal_message"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncodeInternalMessage, TSDKClientError> = .init()
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
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func encode_internal_message(_ payload: TSDKParamsOfEncodeInternalMessage) async throws -> TSDKResultOfEncodeInternalMessage {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "encode_internal_message"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfEncodeInternalMessage, TSDKClientError> = .init()
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

    /// Combines `hex`-encoded `signature` with `base64`-encoded `unsigned_message`. Returns signed message encoded in `base64`.
    public func attach_signature(_ payload: TSDKParamsOfAttachSignature, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfAttachSignature, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "attach_signature"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfAttachSignature, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Combines `hex`-encoded `signature` with `base64`-encoded `unsigned_message`. Returns signed message encoded in `base64`.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func attach_signature(_ payload: TSDKParamsOfAttachSignature) async throws -> TSDKResultOfAttachSignature {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "attach_signature"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfAttachSignature, TSDKClientError> = .init()
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

    /// Decodes message body using provided message BOC and ABI.
    public func decode_message(_ payload: TSDKParamsOfDecodeMessage, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKDecodedMessageBody, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "decode_message"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKDecodedMessageBody, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Decodes message body using provided message BOC and ABI.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func decode_message(_ payload: TSDKParamsOfDecodeMessage) async throws -> TSDKDecodedMessageBody {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "decode_message"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKDecodedMessageBody, TSDKClientError> = .init()
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

    /// Decodes message body using provided body BOC and ABI.
    public func decode_message_body(_ payload: TSDKParamsOfDecodeMessageBody, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKDecodedMessageBody, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "decode_message_body"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKDecodedMessageBody, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Decodes message body using provided body BOC and ABI.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func decode_message_body(_ payload: TSDKParamsOfDecodeMessageBody) async throws -> TSDKDecodedMessageBody {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "decode_message_body"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKDecodedMessageBody, TSDKClientError> = .init()
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

    /// Creates account state BOC
    public func encode_account(_ payload: TSDKParamsOfEncodeAccount, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfEncodeAccount, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "encode_account"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncodeAccount, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Creates account state BOC
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func encode_account(_ payload: TSDKParamsOfEncodeAccount) async throws -> TSDKResultOfEncodeAccount {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "encode_account"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfEncodeAccount, TSDKClientError> = .init()
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

    /// Decodes account data using provided data BOC and ABI.
    /// Note: this feature requires ABI 2.1 or higher.
    public func decode_account_data(_ payload: TSDKParamsOfDecodeAccountData, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfDecodeAccountData, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "decode_account_data"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfDecodeAccountData, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Decodes account data using provided data BOC and ABI.
    /// Note: this feature requires ABI 2.1 or higher.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func decode_account_data(_ payload: TSDKParamsOfDecodeAccountData) async throws -> TSDKResultOfDecodeAccountData {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "decode_account_data"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfDecodeAccountData, TSDKClientError> = .init()
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

    /// Updates initial account data with initial values for the contract's static variables and owner's public key. This operation is applicable only for initial account data (before deploy). If the contract is already deployed, its data doesn't contain this data section any more.
    /// Doesn't support ABI version >= 2.4. Use `encode_initial_data` instead
    public func update_initial_data(_ payload: TSDKParamsOfUpdateInitialData, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfUpdateInitialData, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "update_initial_data"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfUpdateInitialData, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Updates initial account data with initial values for the contract's static variables and owner's public key. This operation is applicable only for initial account data (before deploy). If the contract is already deployed, its data doesn't contain this data section any more.
    /// Doesn't support ABI version >= 2.4. Use `encode_initial_data` instead
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func update_initial_data(_ payload: TSDKParamsOfUpdateInitialData) async throws -> TSDKResultOfUpdateInitialData {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "update_initial_data"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfUpdateInitialData, TSDKClientError> = .init()
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

    /// Encodes initial account data with initial values for the contract's static variables and owner's public key into a data BOC that can be passed to `encode_tvc` function afterwards.
    /// This function is analogue of `tvm.buildDataInit` function in Solidity.
    public func encode_initial_data(_ payload: TSDKParamsOfEncodeInitialData, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfEncodeInitialData, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "encode_initial_data"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfEncodeInitialData, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Encodes initial account data with initial values for the contract's static variables and owner's public key into a data BOC that can be passed to `encode_tvc` function afterwards.
    /// This function is analogue of `tvm.buildDataInit` function in Solidity.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func encode_initial_data(_ payload: TSDKParamsOfEncodeInitialData) async throws -> TSDKResultOfEncodeInitialData {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "encode_initial_data"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfEncodeInitialData, TSDKClientError> = .init()
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

    /// Decodes initial values of a contract's static variables and owner's public key from account initial data This operation is applicable only for initial account data (before deploy). If the contract is already deployed, its data doesn't contain this data section any more.
    /// Doesn't support ABI version >= 2.4. Use `decode_account_data` instead
    public func decode_initial_data(_ payload: TSDKParamsOfDecodeInitialData, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfDecodeInitialData, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "decode_initial_data"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfDecodeInitialData, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Decodes initial values of a contract's static variables and owner's public key from account initial data This operation is applicable only for initial account data (before deploy). If the contract is already deployed, its data doesn't contain this data section any more.
    /// Doesn't support ABI version >= 2.4. Use `decode_account_data` instead
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func decode_initial_data(_ payload: TSDKParamsOfDecodeInitialData) async throws -> TSDKResultOfDecodeInitialData {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "decode_initial_data"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfDecodeInitialData, TSDKClientError> = .init()
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

    /// Decodes BOC into JSON as a set of provided parameters.
    /// Solidity functions use ABI types for [builder encoding](https://github.com/everx-labs/TVM-Solidity-Compiler/blob/master/API.md#tvmbuilderstore).
    /// The simplest way to decode such a BOC is to use ABI decoding.
    /// ABI has it own rules for fields layout in cells so manually encodedBOC can not be described in terms of ABI rules.
    /// To solve this problem we introduce a new ABI type `Ref(<ParamType>)`which allows to store `ParamType` ABI parameter in cell reference and, thus,decode manually encoded BOCs. This type is available only in `decode_boc` functionand will not be available in ABI messages encoding until it is included into some ABI revision.
    /// Such BOC descriptions covers most users needs. If someone wants to decode some BOC whichcan not be described by these rules (i.e. BOC with TLB containing constructors of flagsdefining some parsing conditions) then they can decode the fields up to fork condition,check the parsed data manually, expand the parsing schema and then decode the whole BOCwith the full schema.
    public func decode_boc(_ payload: TSDKParamsOfDecodeBoc, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfDecodeBoc, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "decode_boc"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfDecodeBoc, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Decodes BOC into JSON as a set of provided parameters.
    /// Solidity functions use ABI types for [builder encoding](https://github.com/everx-labs/TVM-Solidity-Compiler/blob/master/API.md#tvmbuilderstore).
    /// The simplest way to decode such a BOC is to use ABI decoding.
    /// ABI has it own rules for fields layout in cells so manually encodedBOC can not be described in terms of ABI rules.
    /// To solve this problem we introduce a new ABI type `Ref(<ParamType>)`which allows to store `ParamType` ABI parameter in cell reference and, thus,decode manually encoded BOCs. This type is available only in `decode_boc` functionand will not be available in ABI messages encoding until it is included into some ABI revision.
    /// Such BOC descriptions covers most users needs. If someone wants to decode some BOC whichcan not be described by these rules (i.e. BOC with TLB containing constructors of flagsdefining some parsing conditions) then they can decode the fields up to fork condition,check the parsed data manually, expand the parsing schema and then decode the whole BOCwith the full schema.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func decode_boc(_ payload: TSDKParamsOfDecodeBoc) async throws -> TSDKResultOfDecodeBoc {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "decode_boc"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfDecodeBoc, TSDKClientError> = .init()
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

    /// Encodes given parameters in JSON into a BOC using param types from ABI.
    public func encode_boc(_ payload: TSDKParamsOfAbiEncodeBoc, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfAbiEncodeBoc, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "encode_boc"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfAbiEncodeBoc, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Encodes given parameters in JSON into a BOC using param types from ABI.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func encode_boc(_ payload: TSDKParamsOfAbiEncodeBoc) async throws -> TSDKResultOfAbiEncodeBoc {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "encode_boc"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfAbiEncodeBoc, TSDKClientError> = .init()
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

    /// Calculates contract function ID by contract ABI
    public func calc_function_id(_ payload: TSDKParamsOfCalcFunctionId, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfCalcFunctionId, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "calc_function_id"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfCalcFunctionId, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Calculates contract function ID by contract ABI
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func calc_function_id(_ payload: TSDKParamsOfCalcFunctionId) async throws -> TSDKResultOfCalcFunctionId {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "calc_function_id"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfCalcFunctionId, TSDKClientError> = .init()
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

    /// Extracts signature from message body and calculates hash to verify the signature
    public func get_signature_data(_ payload: TSDKParamsOfGetSignatureData, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfGetSignatureData, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "get_signature_data"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetSignatureData, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Extracts signature from message body and calculates hash to verify the signature
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func get_signature_data(_ payload: TSDKParamsOfGetSignatureData) async throws -> TSDKResultOfGetSignatureData {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "get_signature_data"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfGetSignatureData, TSDKClientError> = .init()
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
