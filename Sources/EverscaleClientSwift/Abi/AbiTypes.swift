public typealias TSDKAbiHandle = UInt32

public enum TSDKAbiErrorCode: Int, Codable {
    case RequiredAddressMissingForEncodeMessage = 301
    case RequiredCallSetMissingForEncodeMessage = 302
    case InvalidJson = 303
    case InvalidMessage = 304
    case EncodeDeployMessageFailed = 305
    case EncodeRunMessageFailed = 306
    case AttachSignatureFailed = 307
    case InvalidTvcImage = 308
    case RequiredPublicKeyMissingForFunctionHeader = 309
    case InvalidSigner = 310
    case InvalidAbi = 311
    case InvalidFunctionId = 312
    case InvalidData = 313
    case EncodeInitialDataFailed = 314
}

public enum TSDKAbiEnumTypes: String, Codable {
    case Contract = "Contract"
    case Json = "Json"
    case Handle = "Handle"
    case Serialized = "Serialized"
}

public enum TSDKSignerEnumTypes: String, Codable {
    case None = "None"
    case External = "External"
    case Keys = "Keys"
    case SigningBox = "SigningBox"
}

public enum TSDKMessageBodyType: String, Codable {
    case Input = "Input"
    case Output = "Output"
    case InternalOutput = "InternalOutput"
    case Event = "Event"
}

public enum TSDKStateInitSourceEnumTypes: String, Codable {
    case Message = "Message"
    case StateInit = "StateInit"
    case Tvc = "Tvc"
}

public enum TSDKMessageSourceEnumTypes: String, Codable {
    case Encoded = "Encoded"
    case EncodingParams = "EncodingParams"
}

public struct TSDKAbi: Codable {
    public var type: TSDKAbiEnumTypes
    public var value: AnyValue?

    public init(type: TSDKAbiEnumTypes, value: AnyValue? = nil) {
        self.type = type
        self.value = value
    }
}

public struct TSDKFunctionHeader: Codable {
    /// Message expiration time in seconds. If not specified - calculated automatically from message_expiration_timeout(), try_index and message_expiration_timeout_grow_factor() (if ABI includes `expire` header).
    public var expire: UInt32?
    /// Message creation time in milliseconds.
    /// If not specified, `now` is used (if ABI includes `time` header).
    public var time: Int?
    /// Public key is used by the contract to check the signature.
    /// Encoded in `hex`. If not specified, method fails with exception (if ABI includes `pubkey` header)..
    public var pubkey: String?

    public init(expire: UInt32? = nil, time: Int? = nil, pubkey: String? = nil) {
        self.expire = expire
        self.time = time
        self.pubkey = pubkey
    }
}

public struct TSDKCallSet: Codable {
    /// Function name that is being called. Or function id encoded as string in hex (starting with 0x).
    public var function_name: String
    /// Function header.
    /// If an application omits some header parameters required by thecontract's ABI, the library will set the default values forthem.
    public var header: TSDKFunctionHeader?
    /// Function input parameters according to ABI.
    public var input: AnyValue?

    public init(function_name: String, header: TSDKFunctionHeader? = nil, input: AnyValue? = nil) {
        self.function_name = function_name
        self.header = header
        self.input = input
    }
}

public struct TSDKDeploySet: Codable {
    /// Content of TVC file encoded in `base64`.
    public var tvc: String
    /// Target workchain for destination address.
    /// Default is `0`.
    public var workchain_id: Int32?
    /// List of initial values for contract's public variables.
    public var initial_data: AnyValue?
    /// Optional public key that can be provided in deploy set in order to substitute one in TVM file or provided by Signer.
    /// Public key resolving priority:
    /// 1. Public key from deploy set.
    /// 2. Public key, specified in TVM file.
    /// 3. Public key, provided by Signer.
    public var initial_pubkey: String?

    public init(tvc: String, workchain_id: Int32? = nil, initial_data: AnyValue? = nil, initial_pubkey: String? = nil) {
        self.tvc = tvc
        self.workchain_id = workchain_id
        self.initial_data = initial_data
        self.initial_pubkey = initial_pubkey
    }
}

public struct TSDKSigner: Codable {
    public var type: TSDKSignerEnumTypes
    public var public_key: String?
    public var keys: TSDKKeyPair?
    public var handle: TSDKSigningBoxHandle?

    public init(type: TSDKSignerEnumTypes, public_key: String? = nil, keys: TSDKKeyPair? = nil, handle: TSDKSigningBoxHandle? = nil) {
        self.type = type
        self.public_key = public_key
        self.keys = keys
        self.handle = handle
    }
}

public struct TSDKStateInitSource: Codable {
    public var type: TSDKStateInitSourceEnumTypes
    public var source: TSDKMessageSource?
    /// Code BOC.
    /// Encoded in `base64`.
    public var code: String?
    /// Data BOC.
    /// Encoded in `base64`.
    public var data: String?
    /// Library BOC.
    /// Encoded in `base64`.
    public var library: String?
    public var tvc: String?
    public var public_key: String?
    public var init_params: TSDKStateInitParams?

    public init(type: TSDKStateInitSourceEnumTypes, source: TSDKMessageSource? = nil, code: String? = nil, data: String? = nil, library: String? = nil, tvc: String? = nil, public_key: String? = nil, init_params: TSDKStateInitParams? = nil) {
        self.type = type
        self.source = source
        self.code = code
        self.data = data
        self.library = library
        self.tvc = tvc
        self.public_key = public_key
        self.init_params = init_params
    }
}

public struct TSDKStateInitParams: Codable {
    public var abi: TSDKAbi
    public var value: AnyValue

    public init(abi: TSDKAbi, value: AnyValue) {
        self.abi = abi
        self.value = value
    }
}

public struct TSDKMessageSource: Codable {
    public var type: TSDKMessageSourceEnumTypes
    public var message: String?
    public var abi: TSDKAbi?

    public init(type: TSDKMessageSourceEnumTypes, message: String? = nil, abi: TSDKAbi? = nil) {
        self.type = type
        self.message = message
        self.abi = abi
    }
}

public struct TSDKAbiParam: Codable {
    public var name: String
    public var type: String
    public var components: [TSDKAbiParam]?

    public init(name: String, type: String, components: [TSDKAbiParam]? = nil) {
        self.name = name
        self.type = type
        self.components = components
    }
}

public struct TSDKAbiEvent: Codable {
    public var name: String
    public var inputs: [TSDKAbiParam]
    public var id: String?

    public init(name: String, inputs: [TSDKAbiParam], id: String? = nil) {
        self.name = name
        self.inputs = inputs
        self.id = id
    }
}

public struct TSDKAbiData: Codable {
    public var key: UInt32
    public var name: String
    public var type: String
    public var components: [TSDKAbiParam]?

    public init(key: UInt32, name: String, type: String, components: [TSDKAbiParam]? = nil) {
        self.key = key
        self.name = name
        self.type = type
        self.components = components
    }
}

public struct TSDKAbiFunction: Codable {
    public var name: String
    public var inputs: [TSDKAbiParam]
    public var outputs: [TSDKAbiParam]
    public var id: String?

    public init(name: String, inputs: [TSDKAbiParam], outputs: [TSDKAbiParam], id: String? = nil) {
        self.name = name
        self.inputs = inputs
        self.outputs = outputs
        self.id = id
    }
}

public struct TSDKAbiContract: Codable {
    public var abi_version: UInt32?
    public var version: String?
    public var header: [String]?
    public var functions: [TSDKAbiFunction]?
    public var events: [TSDKAbiEvent]?
    public var data: [TSDKAbiData]?
    public var fields: [TSDKAbiParam]?

    public init(abi_version: UInt32? = nil, version: String? = nil, header: [String]? = nil, functions: [TSDKAbiFunction]? = nil, events: [TSDKAbiEvent]? = nil, data: [TSDKAbiData]? = nil, fields: [TSDKAbiParam]? = nil) {
        self.abi_version = abi_version
        self.version = version
        self.header = header
        self.functions = functions
        self.events = events
        self.data = data
        self.fields = fields
    }
}

public struct TSDKParamsOfEncodeMessageBody: Codable {
    /// Contract ABI.
    public var abi: TSDKAbi
    /// Function call parameters.
    /// Must be specified in non deploy message.
    /// In case of deploy message contains parameters of constructor.
    public var call_set: TSDKCallSet
    /// True if internal message body must be encoded.
    public var is_internal: Bool
    /// Signing parameters.
    public var signer: TSDKSigner
    /// Processing try index.
    /// Used in message processing with retries.
    /// Encoder uses the provided try index to calculate messageexpiration time.
    /// Expiration timeouts will grow with every retry.
    /// Default value is 0.
    public var processing_try_index: UInt8?

    public init(abi: TSDKAbi, call_set: TSDKCallSet, is_internal: Bool, signer: TSDKSigner, processing_try_index: UInt8? = nil) {
        self.abi = abi
        self.call_set = call_set
        self.is_internal = is_internal
        self.signer = signer
        self.processing_try_index = processing_try_index
    }
}

public struct TSDKResultOfEncodeMessageBody: Codable {
    /// Message body BOC encoded with `base64`.
    public var body: String
    /// Optional data to sign.
    /// Encoded with `base64`.
    /// /// Presents when `message` is unsigned. Can be used for externalmessage signing. Is this case you need to sing this data andproduce signed message using `abi.attach_signature`.
    public var data_to_sign: String?

    public init(body: String, data_to_sign: String? = nil) {
        self.body = body
        self.data_to_sign = data_to_sign
    }
}

public struct TSDKParamsOfAttachSignatureToMessageBody: Codable {
    /// Contract ABI
    public var abi: TSDKAbi
    /// Public key.
    /// Must be encoded with `hex`.
    public var public_key: String
    /// Unsigned message body BOC.
    /// Must be encoded with `base64`.
    public var message: String
    /// Signature.
    /// Must be encoded with `hex`.
    public var signature: String

    public init(abi: TSDKAbi, public_key: String, message: String, signature: String) {
        self.abi = abi
        self.public_key = public_key
        self.message = message
        self.signature = signature
    }
}

public struct TSDKResultOfAttachSignatureToMessageBody: Codable {
    public var body: String

    public init(body: String) {
        self.body = body
    }
}

public struct TSDKParamsOfEncodeMessage: Codable {
    /// Contract ABI.
    public var abi: TSDKAbi
    /// Target address the message will be sent to.
    /// Must be specified in case of non-deploy message.
    public var address: String?
    /// Deploy parameters.
    /// Must be specified in case of deploy message.
    public var deploy_set: TSDKDeploySet?
    /// Function call parameters.
    /// Must be specified in case of non-deploy message.
    /// In case of deploy message it is optional and contains parametersof the functions that will to be called upon deploy transaction.
    public var call_set: TSDKCallSet?
    /// Signing parameters.
    public var signer: TSDKSigner
    /// Processing try index.
    /// Used in message processing with retries (if contract's ABI includes "expire" header).
    /// Encoder uses the provided try index to calculate messageexpiration time. The 1st message expiration time is specified inClient config.
    /// Expiration timeouts will grow with every retry.
    /// Retry grow factor is set in Client config:
    /// <.....add config parameter with default value here>Default value is 0.
    public var processing_try_index: UInt8?

    public init(abi: TSDKAbi, address: String? = nil, deploy_set: TSDKDeploySet? = nil, call_set: TSDKCallSet? = nil, signer: TSDKSigner, processing_try_index: UInt8? = nil) {
        self.abi = abi
        self.address = address
        self.deploy_set = deploy_set
        self.call_set = call_set
        self.signer = signer
        self.processing_try_index = processing_try_index
    }
}

public struct TSDKResultOfEncodeMessage: Codable {
    /// Message BOC encoded with `base64`.
    public var message: String
    /// Optional data to be signed encoded in `base64`.
    /// Returned in case of `Signer::External`. Can be used for externalmessage signing. Is this case you need to use this data to create signature andthen produce signed message using `abi.attach_signature`.
    public var data_to_sign: String?
    /// Destination address.
    public var address: String
    /// Message id.
    public var message_id: String

    public init(message: String, data_to_sign: String? = nil, address: String, message_id: String) {
        self.message = message
        self.data_to_sign = data_to_sign
        self.address = address
        self.message_id = message_id
    }
}

public struct TSDKParamsOfEncodeInternalMessage: Codable {
    /// Contract ABI.
    /// Can be None if both deploy_set and call_set are None.
    public var abi: TSDKAbi?
    /// Target address the message will be sent to.
    /// Must be specified in case of non-deploy message.
    public var address: String?
    /// Source address of the message.
    public var src_address: String?
    /// Deploy parameters.
    /// Must be specified in case of deploy message.
    public var deploy_set: TSDKDeploySet?
    /// Function call parameters.
    /// Must be specified in case of non-deploy message.
    /// In case of deploy message it is optional and contains parametersof the functions that will to be called upon deploy transaction.
    public var call_set: TSDKCallSet?
    /// Value in nanotokens to be sent with message.
    public var value: String
    /// Flag of bounceable message.
    /// Default is true.
    public var bounce: Bool?
    /// Enable Instant Hypercube Routing for the message.
    /// Default is false.
    public var enable_ihr: Bool?

    public init(abi: TSDKAbi? = nil, address: String? = nil, src_address: String? = nil, deploy_set: TSDKDeploySet? = nil, call_set: TSDKCallSet? = nil, value: String, bounce: Bool? = nil, enable_ihr: Bool? = nil) {
        self.abi = abi
        self.address = address
        self.src_address = src_address
        self.deploy_set = deploy_set
        self.call_set = call_set
        self.value = value
        self.bounce = bounce
        self.enable_ihr = enable_ihr
    }
}

public struct TSDKResultOfEncodeInternalMessage: Codable {
    /// Message BOC encoded with `base64`.
    public var message: String
    /// Destination address.
    public var address: String
    /// Message id.
    public var message_id: String

    public init(message: String, address: String, message_id: String) {
        self.message = message
        self.address = address
        self.message_id = message_id
    }
}

public struct TSDKParamsOfAttachSignature: Codable {
    /// Contract ABI
    public var abi: TSDKAbi
    /// Public key encoded in `hex`.
    public var public_key: String
    /// Unsigned message BOC encoded in `base64`.
    public var message: String
    /// Signature encoded in `hex`.
    public var signature: String

    public init(abi: TSDKAbi, public_key: String, message: String, signature: String) {
        self.abi = abi
        self.public_key = public_key
        self.message = message
        self.signature = signature
    }
}

public struct TSDKResultOfAttachSignature: Codable {
    /// Signed message BOC
    public var message: String
    /// Message ID
    public var message_id: String

    public init(message: String, message_id: String) {
        self.message = message
        self.message_id = message_id
    }
}

public struct TSDKParamsOfDecodeMessage: Codable {
    /// contract ABI
    public var abi: TSDKAbi
    /// Message BOC
    public var message: String
    /// Flag allowing partial BOC decoding when ABI doesn't describe the full body BOC. Controls decoder behaviour when after decoding all described in ABI params there are some data left in BOC: `true` - return decoded values `false` - return error of incomplete BOC deserialization (default)
    public var allow_partial: Bool?

    public init(abi: TSDKAbi, message: String, allow_partial: Bool? = nil) {
        self.abi = abi
        self.message = message
        self.allow_partial = allow_partial
    }
}

public struct TSDKDecodedMessageBody: Codable {
    /// Type of the message body content.
    public var body_type: TSDKMessageBodyType
    /// Function or event name.
    public var name: String
    /// Parameters or result value.
    public var value: AnyValue?
    /// Function header.
    public var header: TSDKFunctionHeader?

    public init(body_type: TSDKMessageBodyType, name: String, value: AnyValue? = nil, header: TSDKFunctionHeader? = nil) {
        self.body_type = body_type
        self.name = name
        self.value = value
        self.header = header
    }
}

public struct TSDKParamsOfDecodeMessageBody: Codable {
    /// Contract ABI used to decode.
    public var abi: TSDKAbi
    /// Message body BOC encoded in `base64`.
    public var body: String
    /// True if the body belongs to the internal message.
    public var is_internal: Bool
    /// Flag allowing partial BOC decoding when ABI doesn't describe the full body BOC. Controls decoder behaviour when after decoding all described in ABI params there are some data left in BOC: `true` - return decoded values `false` - return error of incomplete BOC deserialization (default)
    public var allow_partial: Bool?

    public init(abi: TSDKAbi, body: String, is_internal: Bool, allow_partial: Bool? = nil) {
        self.abi = abi
        self.body = body
        self.is_internal = is_internal
        self.allow_partial = allow_partial
    }
}

public struct TSDKParamsOfEncodeAccount: Codable {
    /// Source of the account state init.
    public var state_init: TSDKStateInitSource
    /// Initial balance.
    public var balance: Int?
    /// Initial value for the `last_trans_lt`.
    public var last_trans_lt: Int?
    /// Initial value for the `last_paid`.
    public var last_paid: UInt32?
    /// Cache type to put the result.
    /// The BOC itself returned if no cache type provided
    public var boc_cache: TSDKBocCacheType?

    public init(state_init: TSDKStateInitSource, balance: Int? = nil, last_trans_lt: Int? = nil, last_paid: UInt32? = nil, boc_cache: TSDKBocCacheType? = nil) {
        self.state_init = state_init
        self.balance = balance
        self.last_trans_lt = last_trans_lt
        self.last_paid = last_paid
        self.boc_cache = boc_cache
    }
}

public struct TSDKResultOfEncodeAccount: Codable {
    /// Account BOC encoded in `base64`.
    public var account: String
    /// Account ID  encoded in `hex`.
    public var id: String

    public init(account: String, id: String) {
        self.account = account
        self.id = id
    }
}

public struct TSDKParamsOfDecodeAccountData: Codable {
    /// Contract ABI
    public var abi: TSDKAbi
    /// Data BOC or BOC handle
    public var data: String
    /// Flag allowing partial BOC decoding when ABI doesn't describe the full body BOC. Controls decoder behaviour when after decoding all described in ABI params there are some data left in BOC: `true` - return decoded values `false` - return error of incomplete BOC deserialization (default)
    public var allow_partial: Bool?

    public init(abi: TSDKAbi, data: String, allow_partial: Bool? = nil) {
        self.abi = abi
        self.data = data
        self.allow_partial = allow_partial
    }
}

public struct TSDKResultOfDecodeAccountData: Codable {
    /// Decoded data as a JSON structure.
    public var data: AnyValue

    public init(data: AnyValue) {
        self.data = data
    }
}

public struct TSDKParamsOfUpdateInitialData: Codable {
    /// Contract ABI
    public var abi: TSDKAbi?
    /// Data BOC or BOC handle
    public var data: String
    /// List of initial values for contract's static variables.
    /// `abi` parameter should be provided to set initial data
    public var initial_data: AnyValue?
    /// Initial account owner's public key to set into account data
    public var initial_pubkey: String?
    /// Cache type to put the result. The BOC itself returned if no cache type provided.
    public var boc_cache: TSDKBocCacheType?

    public init(abi: TSDKAbi? = nil, data: String, initial_data: AnyValue? = nil, initial_pubkey: String? = nil, boc_cache: TSDKBocCacheType? = nil) {
        self.abi = abi
        self.data = data
        self.initial_data = initial_data
        self.initial_pubkey = initial_pubkey
        self.boc_cache = boc_cache
    }
}

public struct TSDKResultOfUpdateInitialData: Codable {
    /// Updated data BOC or BOC handle
    public var data: String

    public init(data: String) {
        self.data = data
    }
}

public struct TSDKParamsOfEncodeInitialData: Codable {
    /// Contract ABI
    public var abi: TSDKAbi?
    /// List of initial values for contract's static variables.
    /// `abi` parameter should be provided to set initial data
    public var initial_data: AnyValue?
    /// Initial account owner's public key to set into account data
    public var initial_pubkey: String?
    /// Cache type to put the result. The BOC itself returned if no cache type provided.
    public var boc_cache: TSDKBocCacheType?

    public init(abi: TSDKAbi? = nil, initial_data: AnyValue? = nil, initial_pubkey: String? = nil, boc_cache: TSDKBocCacheType? = nil) {
        self.abi = abi
        self.initial_data = initial_data
        self.initial_pubkey = initial_pubkey
        self.boc_cache = boc_cache
    }
}

public struct TSDKResultOfEncodeInitialData: Codable {
    /// Updated data BOC or BOC handle
    public var data: String

    public init(data: String) {
        self.data = data
    }
}

public struct TSDKParamsOfDecodeInitialData: Codable {
    /// Contract ABI.
    /// Initial data is decoded if this parameter is provided
    public var abi: TSDKAbi?
    /// Data BOC or BOC handle
    public var data: String
    /// Flag allowing partial BOC decoding when ABI doesn't describe the full body BOC. Controls decoder behaviour when after decoding all described in ABI params there are some data left in BOC: `true` - return decoded values `false` - return error of incomplete BOC deserialization (default)
    public var allow_partial: Bool?

    public init(abi: TSDKAbi? = nil, data: String, allow_partial: Bool? = nil) {
        self.abi = abi
        self.data = data
        self.allow_partial = allow_partial
    }
}

public struct TSDKResultOfDecodeInitialData: Codable {
    /// List of initial values of contract's public variables.
    /// Initial data is decoded if `abi` input parameter is provided
    public var initial_data: AnyValue?
    /// Initial account owner's public key
    public var initial_pubkey: String

    public init(initial_data: AnyValue? = nil, initial_pubkey: String) {
        self.initial_data = initial_data
        self.initial_pubkey = initial_pubkey
    }
}

public struct TSDKParamsOfDecodeBoc: Codable {
    /// Parameters to decode from BOC
    public var params: [TSDKAbiParam]
    /// Data BOC or BOC handle
    public var boc: String
    public var allow_partial: Bool

    public init(params: [TSDKAbiParam], boc: String, allow_partial: Bool) {
        self.params = params
        self.boc = boc
        self.allow_partial = allow_partial
    }
}

public struct TSDKResultOfDecodeBoc: Codable {
    /// Decoded data as a JSON structure.
    public var data: AnyValue

    public init(data: AnyValue) {
        self.data = data
    }
}

public struct TSDKParamsOfAbiEncodeBoc: Codable {
    /// Parameters to encode into BOC
    public var params: [TSDKAbiParam]
    /// Parameters and values as a JSON structure
    public var data: AnyValue
    /// Cache type to put the result.
    /// The BOC itself returned if no cache type provided
    public var boc_cache: TSDKBocCacheType?

    public init(params: [TSDKAbiParam], data: AnyValue, boc_cache: TSDKBocCacheType? = nil) {
        self.params = params
        self.data = data
        self.boc_cache = boc_cache
    }
}

public struct TSDKResultOfAbiEncodeBoc: Codable {
    /// BOC encoded as base64
    public var boc: String

    public init(boc: String) {
        self.boc = boc
    }
}

