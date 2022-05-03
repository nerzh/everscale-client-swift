public enum TSDKProcessingErrorCode: Int, Codable {
    case MessageAlreadyExpired = 501
    case MessageHasNotDestinationAddress = 502
    case CanNotBuildMessageCell = 503
    case FetchBlockFailed = 504
    case SendMessageFailed = 505
    case InvalidMessageBoc = 506
    case MessageExpired = 507
    case TransactionWaitTimeout = 508
    case InvalidBlockReceived = 509
    case CanNotCheckBlockShard = 510
    case BlockNotFound = 511
    case InvalidData = 512
    case ExternalSignerMustNotBeUsed = 513
    case MessageRejected = 514
    case InvalidRempStatus = 515
    case NextRempStatusTimeout = 516
}

public enum TSDKProcessingEventEnumTypes: String, Codable {
    case WillFetchFirstBlock = "WillFetchFirstBlock"
    case FetchFirstBlockFailed = "FetchFirstBlockFailed"
    case WillSend = "WillSend"
    case DidSend = "DidSend"
    case SendFailed = "SendFailed"
    case WillFetchNextBlock = "WillFetchNextBlock"
    case FetchNextBlockFailed = "FetchNextBlockFailed"
    case MessageExpired = "MessageExpired"
    case RempSentToValidators = "RempSentToValidators"
    case RempIncludedIntoBlock = "RempIncludedIntoBlock"
    case RempIncludedIntoAcceptedBlock = "RempIncludedIntoAcceptedBlock"
    case RempOther = "RempOther"
    case RempError = "RempError"
}

public struct TSDKProcessingEvent: Codable {
    public var type: TSDKProcessingEventEnumTypes
    public var error: TSDKClientError?
    public var shard_block_id: String?
    public var message_id: String?
    public var message: String?
    public var timestamp: Int?
    public var json: AnyValue?

    public init(type: TSDKProcessingEventEnumTypes, error: TSDKClientError? = nil, shard_block_id: String? = nil, message_id: String? = nil, message: String? = nil, timestamp: Int? = nil, json: AnyValue? = nil) {
        self.type = type
        self.error = error
        self.shard_block_id = shard_block_id
        self.message_id = message_id
        self.message = message
        self.timestamp = timestamp
        self.json = json
    }
}

public struct TSDKResultOfProcessMessage: Codable {
    /// Parsed transaction.
    /// In addition to the regular transaction fields there is a`boc` field encoded with `base64` which contains sourcetransaction BOC.
    public var transaction: AnyValue
    /// List of output messages' BOCs.
    /// Encoded as `base64`
    public var out_messages: [String]
    /// Optional decoded message bodies according to the optional `abi` parameter.
    public var decoded: TSDKDecodedOutput?
    /// Transaction fees
    public var fees: TSDKTransactionFees

    public init(transaction: AnyValue, out_messages: [String], decoded: TSDKDecodedOutput? = nil, fees: TSDKTransactionFees) {
        self.transaction = transaction
        self.out_messages = out_messages
        self.decoded = decoded
        self.fees = fees
    }
}

public struct TSDKDecodedOutput: Codable {
    /// Decoded bodies of the out messages.
    /// If the message can't be decoded, then `None` will be stored inthe appropriate position.
    public var out_messages: [TSDKDecodedMessageBody?]
    /// Decoded body of the function output message.
    public var output: AnyValue?

    public init(out_messages: [TSDKDecodedMessageBody?], output: AnyValue? = nil) {
        self.out_messages = out_messages
        self.output = output
    }
}

public struct TSDKParamsOfSendMessage: Codable {
    /// Message BOC.
    public var message: String
    /// Optional message ABI.
    /// If this parameter is specified and the message has the`expire` header then expiration time will be checked againstthe current time to prevent unnecessary sending of already expired message.
    /// The `message already expired` error will be returned in thiscase.
    /// Note, that specifying `abi` for ABI compliant contracts isstrongly recommended, so that proper processing strategy can bechosen.
    public var abi: TSDKAbi?
    /// Flag for requesting events sending
    public var send_events: Bool

    public init(message: String, abi: TSDKAbi? = nil, send_events: Bool) {
        self.message = message
        self.abi = abi
        self.send_events = send_events
    }
}

public struct TSDKResultOfSendMessage: Codable {
    /// The last generated shard block of the message destination account before the message was sent.
    /// This block id must be used as a parameter of the`wait_for_transaction`.
    public var shard_block_id: String
    /// The list of endpoints to which the message was sent.
    /// This list id must be used as a parameter of the`wait_for_transaction`.
    public var sending_endpoints: [String]

    public init(shard_block_id: String, sending_endpoints: [String]) {
        self.shard_block_id = shard_block_id
        self.sending_endpoints = sending_endpoints
    }
}

public struct TSDKParamsOfWaitForTransaction: Codable {
    /// Optional ABI for decoding the transaction result.
    /// If it is specified, then the output messages' bodies will bedecoded according to this ABI.
    /// The `abi_decoded` result field will be filled out.
    public var abi: TSDKAbi?
    /// Message BOC.
    /// Encoded with `base64`.
    public var message: String
    /// The last generated block id of the destination account shard before the message was sent.
    /// You must provide the same value as the `send_message` has returned.
    public var shard_block_id: String
    /// Flag that enables/disables intermediate events
    public var send_events: Bool
    /// The list of endpoints to which the message was sent.
    /// Use this field to get more informative errors.
    /// Provide the same value as the `send_message` has returned.
    /// If the message was not delivered (expired), SDK will log the endpoint URLs, used for its sending.
    public var sending_endpoints: [String]?

    public init(abi: TSDKAbi? = nil, message: String, shard_block_id: String, send_events: Bool, sending_endpoints: [String]? = nil) {
        self.abi = abi
        self.message = message
        self.shard_block_id = shard_block_id
        self.send_events = send_events
        self.sending_endpoints = sending_endpoints
    }
}

public struct TSDKParamsOfProcessMessage: Codable {
    /// Message encode parameters.
    public var message_encode_params: TSDKParamsOfEncodeMessage
    /// Flag for requesting events sending
    public var send_events: Bool

    public init(message_encode_params: TSDKParamsOfEncodeMessage, send_events: Bool) {
        self.message_encode_params = message_encode_params
        self.send_events = send_events
    }
}

