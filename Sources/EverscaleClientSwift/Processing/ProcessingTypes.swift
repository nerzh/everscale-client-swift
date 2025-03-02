import Foundation
import SwiftExtensionsPack


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

public enum TSDKMonitorFetchWaitMode: String, Codable {
    case AtLeastOne = "AtLeastOne"
    case All = "All"
    case NoWait = "NoWait"
}

public enum TSDKMonitoredMessageEnumTypes: String, Codable {
    case Boc = "Boc"
    case HashAddress = "HashAddress"
}

public enum TSDKMessageMonitoringStatus: String, Codable {
    case Finalized = "Finalized"
    case Timeout = "Timeout"
    case Reserved = "Reserved"
}

public struct TSDKProcessingEvent: Codable, @unchecked Sendable {
    public var type: TSDKProcessingEventEnumTypes
    public var message_id: String?
    public var message_dst: String?
    public var error: TSDKClientError?
    public var shard_block_id: String?
    public var message: String?
    public var timestamp: Int?
    public var json: AnyValue?

    public init(type: TSDKProcessingEventEnumTypes, message_id: String? = nil, message_dst: String? = nil, error: TSDKClientError? = nil, shard_block_id: String? = nil, message: String? = nil, timestamp: Int? = nil, json: AnyValue? = nil) {
        self.type = type
        self.message_id = message_id
        self.message_dst = message_dst
        self.error = error
        self.shard_block_id = shard_block_id
        self.message = message
        self.timestamp = timestamp
        self.json = json
    }
}

public struct TSDKResultOfProcessMessage: Codable, @unchecked Sendable {
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

public struct TSDKDecodedOutput: Codable, @unchecked Sendable {
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

public struct TSDKMessageMonitoringTransactionCompute: Codable, @unchecked Sendable {
    /// Compute phase exit code.
    public var exit_code: Int32

    public init(exit_code: Int32) {
        self.exit_code = exit_code
    }
}

public struct TSDKMessageMonitoringTransaction: Codable, @unchecked Sendable {
    /// Hash of the transaction. Present if transaction was included into the blocks. When then transaction was emulated this field will be missing.
    public var hash: String?
    /// Aborted field of the transaction.
    public var aborted: Bool
    /// Optional information about the compute phase of the transaction.
    public var compute: TSDKMessageMonitoringTransactionCompute?

    public init(hash: String? = nil, aborted: Bool, compute: TSDKMessageMonitoringTransactionCompute? = nil) {
        self.hash = hash
        self.aborted = aborted
        self.compute = compute
    }
}

public struct TSDKMessageMonitoringParams: Codable, @unchecked Sendable {
    /// Monitored message identification. Can be provided as a message's BOC or (hash, address) pair. BOC is a preferable way because it helps to determine possible error reason (using TVM execution of the message).
    public var message: TSDKMonitoredMessage
    /// Block time Must be specified as a UNIX timestamp in seconds
    public var wait_until: UInt32
    /// User defined data associated with this message. Helps to identify this message when user received `MessageMonitoringResult`.
    public var user_data: AnyValue?

    public init(message: TSDKMonitoredMessage, wait_until: UInt32, user_data: AnyValue? = nil) {
        self.message = message
        self.wait_until = wait_until
        self.user_data = user_data
    }
}

public struct TSDKMessageMonitoringResult: Codable, @unchecked Sendable {
    /// Hash of the message.
    public var hash: String
    /// Processing status.
    public var status: TSDKMessageMonitoringStatus
    /// In case of `Finalized` the transaction is extracted from the block. In case of `Timeout` the transaction is emulated using the last known account state.
    public var transaction: TSDKMessageMonitoringTransaction?
    /// In case of `Timeout` contains possible error reason.
    public var error: String?
    /// User defined data related to this message. This is the same value as passed before with `MessageMonitoringParams` or `SendMessageParams`.
    public var user_data: AnyValue?

    public init(hash: String, status: TSDKMessageMonitoringStatus, transaction: TSDKMessageMonitoringTransaction? = nil, error: String? = nil, user_data: AnyValue? = nil) {
        self.hash = hash
        self.status = status
        self.transaction = transaction
        self.error = error
        self.user_data = user_data
    }
}

public struct TSDKMonitoredMessage: Codable, @unchecked Sendable {
    public var type: TSDKMonitoredMessageEnumTypes
    public var boc: String?
    /// Hash of the message.
    public var hash: String?
    /// Destination address of the message.
    public var address: String?

    public init(type: TSDKMonitoredMessageEnumTypes, boc: String? = nil, hash: String? = nil, address: String? = nil) {
        self.type = type
        self.boc = boc
        self.hash = hash
        self.address = address
    }
}

public struct TSDKMessageSendingParams: Codable, @unchecked Sendable {
    /// BOC of the message, that must be sent to the blockchain.
    public var boc: String
    /// Expiration time of the message. Must be specified as a UNIX timestamp in seconds.
    public var wait_until: UInt32
    /// User defined data associated with this message. Helps to identify this message when user received `MessageMonitoringResult`.
    public var user_data: AnyValue?

    public init(boc: String, wait_until: UInt32, user_data: AnyValue? = nil) {
        self.boc = boc
        self.wait_until = wait_until
        self.user_data = user_data
    }
}

public struct TSDKParamsOfMonitorMessages: Codable, @unchecked Sendable {
    /// Name of the monitoring queue.
    public var queue: String
    /// Messages to start monitoring for.
    public var messages: [TSDKMessageMonitoringParams]

    public init(queue: String, messages: [TSDKMessageMonitoringParams]) {
        self.queue = queue
        self.messages = messages
    }
}

public struct TSDKParamsOfGetMonitorInfo: Codable, @unchecked Sendable {
    /// Name of the monitoring queue.
    public var queue: String

    public init(queue: String) {
        self.queue = queue
    }
}

public struct TSDKMonitoringQueueInfo: Codable, @unchecked Sendable {
    /// Count of the unresolved messages.
    public var unresolved: UInt32
    /// Count of resolved results.
    public var resolved: UInt32

    public init(unresolved: UInt32, resolved: UInt32) {
        self.unresolved = unresolved
        self.resolved = resolved
    }
}

public struct TSDKParamsOfFetchNextMonitorResults: Codable, @unchecked Sendable {
    /// Name of the monitoring queue.
    public var queue: String
    /// Wait mode.
    /// Default is `NO_WAIT`.
    public var wait_mode: TSDKMonitorFetchWaitMode?

    public init(queue: String, wait_mode: TSDKMonitorFetchWaitMode? = nil) {
        self.queue = queue
        self.wait_mode = wait_mode
    }
}

public struct TSDKResultOfFetchNextMonitorResults: Codable, @unchecked Sendable {
    /// List of the resolved results.
    public var results: [TSDKMessageMonitoringResult]

    public init(results: [TSDKMessageMonitoringResult]) {
        self.results = results
    }
}

public struct TSDKParamsOfCancelMonitor: Codable, @unchecked Sendable {
    /// Name of the monitoring queue.
    public var queue: String

    public init(queue: String) {
        self.queue = queue
    }
}

public struct TSDKParamsOfSendMessages: Codable, @unchecked Sendable {
    /// Messages that must be sent to the blockchain.
    public var messages: [TSDKMessageSendingParams]
    /// Optional message monitor queue that starts monitoring for the processing results for sent messages.
    public var monitor_queue: String?

    public init(messages: [TSDKMessageSendingParams], monitor_queue: String? = nil) {
        self.messages = messages
        self.monitor_queue = monitor_queue
    }
}

public struct TSDKResultOfSendMessages: Codable, @unchecked Sendable {
    /// Messages that was sent to the blockchain for execution.
    public var messages: [TSDKMessageMonitoringParams]

    public init(messages: [TSDKMessageMonitoringParams]) {
        self.messages = messages
    }
}

public struct TSDKParamsOfSendMessage: Codable, @unchecked Sendable {
    /// Message BOC.
    public var message: String
    /// Optional message ABI.
    /// If this parameter is specified and the message has the`expire` header then expiration time will be checked againstthe current time to prevent unnecessary sending of already expired message.
    /// The `message already expired` error will be returned in thiscase.
    /// Note, that specifying `abi` for ABI compliant contracts isstrongly recommended, so that proper processing strategy can bechosen.
    public var abi: TSDKAbi?
    /// Flag for requesting events sending. Default is `false`.
    public var send_events: Bool?

    public init(message: String, abi: TSDKAbi? = nil, send_events: Bool? = nil) {
        self.message = message
        self.abi = abi
        self.send_events = send_events
    }
}

public struct TSDKResultOfSendMessage: Codable, @unchecked Sendable {
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

public struct TSDKParamsOfWaitForTransaction: Codable, @unchecked Sendable {
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
    /// Flag that enables/disables intermediate events. Default is `false`.
    public var send_events: Bool?
    /// The list of endpoints to which the message was sent.
    /// Use this field to get more informative errors.
    /// Provide the same value as the `send_message` has returned.
    /// If the message was not delivered (expired), SDK will log the endpoint URLs, used for its sending.
    public var sending_endpoints: [String]?

    public init(abi: TSDKAbi? = nil, message: String, shard_block_id: String, send_events: Bool? = nil, sending_endpoints: [String]? = nil) {
        self.abi = abi
        self.message = message
        self.shard_block_id = shard_block_id
        self.send_events = send_events
        self.sending_endpoints = sending_endpoints
    }
}

public struct TSDKParamsOfProcessMessage: Codable, @unchecked Sendable {
    /// Message encode parameters.
    public var message_encode_params: TSDKParamsOfEncodeMessage
    /// Flag for requesting events sending. Default is `false`.
    public var send_events: Bool?

    public init(message_encode_params: TSDKParamsOfEncodeMessage, send_events: Bool? = nil) {
        self.message_encode_params = message_encode_params
        self.send_events = send_events
    }
}

