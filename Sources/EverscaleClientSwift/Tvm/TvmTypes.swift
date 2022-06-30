import SwiftExtensionsPack


public enum TSDKTvmErrorCode: Int, Codable {
    case CanNotReadTransaction = 401
    case CanNotReadBlockchainConfig = 402
    case TransactionAborted = 403
    case InternalError = 404
    case ActionPhaseFailed = 405
    case AccountCodeMissing = 406
    case LowBalance = 407
    case AccountFrozenOrDeleted = 408
    case AccountMissing = 409
    case UnknownExecutionError = 410
    case InvalidInputStack = 411
    case InvalidAccountBoc = 412
    case InvalidMessageType = 413
    case ContractExecutionError = 414
}

public enum TSDKAccountForExecutorEnumTypes: String, Codable {
    case None = "None"
    case Uninit = "Uninit"
    case Account = "Account"
}

public struct TSDKExecutionOptions: Codable {
    /// boc with config
    public var blockchain_config: String?
    /// time that is used as transaction time
    public var block_time: UInt32?
    /// block logical time
    public var block_lt: Int?
    /// transaction logical time
    public var transaction_lt: Int?
    /// Overrides standard TVM behaviour. If set to `true` then CHKSIG always will return `true`.
    public var chksig_always_succeed: Bool?

    public init(blockchain_config: String? = nil, block_time: UInt32? = nil, block_lt: Int? = nil, transaction_lt: Int? = nil, chksig_always_succeed: Bool? = nil) {
        self.blockchain_config = blockchain_config
        self.block_time = block_time
        self.block_lt = block_lt
        self.transaction_lt = transaction_lt
        self.chksig_always_succeed = chksig_always_succeed
    }
}

public struct TSDKAccountForExecutor: Codable {
    public var type: TSDKAccountForExecutorEnumTypes
    /// Account BOC.
    /// Encoded as base64.
    public var boc: String?
    /// Flag for running account with the unlimited balance.
    /// Can be used to calculate transaction fees without balance check
    public var unlimited_balance: Bool?

    public init(type: TSDKAccountForExecutorEnumTypes, boc: String? = nil, unlimited_balance: Bool? = nil) {
        self.type = type
        self.boc = boc
        self.unlimited_balance = unlimited_balance
    }
}

public struct TSDKTransactionFees: Codable {
    /// Deprecated.
    /// Left for backward compatibility. Does not participate in account transaction fees calculation.
    public var in_msg_fwd_fee: Int
    /// Fee for account storage
    public var storage_fee: Int
    /// Fee for processing
    public var gas_fee: Int
    /// Deprecated.
    /// Contains the same data as total_fwd_fees field. Deprecated because of its confusing name, that is not the same with GraphQL API Transaction type's field.
    public var out_msgs_fwd_fee: Int
    /// Deprecated.
    /// This is the field that is named as `total_fees` in GraphQL API Transaction type. `total_account_fees` name is misleading, because it does not mean account fees, instead it meansvalidators total fees received for the transaction execution. It does not include some forward fees that accountactually pays now, but validators will receive later during value delivery to another account (not even in the receivingtransaction).
    /// Because of all of this, this field is not interesting for those who wants to understandthe real account fees, this is why it is deprecated and left for backward compatibility.
    public var total_account_fees: Int
    /// Deprecated because it means total value sent in the transaction, which does not relate to any fees.
    public var total_output: Int
    /// Fee for inbound external message import.
    public var ext_in_msg_fee: Int
    /// Total fees the account pays for message forwarding
    public var total_fwd_fees: Int
    /// Total account fees for the transaction execution. Compounds of storage_fee + gas_fee + ext_in_msg_fee + total_fwd_fees
    public var account_fees: Int

    public init(in_msg_fwd_fee: Int, storage_fee: Int, gas_fee: Int, out_msgs_fwd_fee: Int, total_account_fees: Int, total_output: Int, ext_in_msg_fee: Int, total_fwd_fees: Int, account_fees: Int) {
        self.in_msg_fwd_fee = in_msg_fwd_fee
        self.storage_fee = storage_fee
        self.gas_fee = gas_fee
        self.out_msgs_fwd_fee = out_msgs_fwd_fee
        self.total_account_fees = total_account_fees
        self.total_output = total_output
        self.ext_in_msg_fee = ext_in_msg_fee
        self.total_fwd_fees = total_fwd_fees
        self.account_fees = account_fees
    }
}

public struct TSDKParamsOfRunExecutor: Codable {
    /// Input message BOC.
    /// Must be encoded as base64.
    public var message: String
    /// Account to run on executor
    public var account: TSDKAccountForExecutor
    /// Execution options.
    public var execution_options: TSDKExecutionOptions?
    /// Contract ABI for decoding output messages
    public var abi: TSDKAbi?
    /// Skip transaction check flag
    public var skip_transaction_check: Bool?
    /// Cache type to put the result.
    /// The BOC itself returned if no cache type provided
    public var boc_cache: TSDKBocCacheType?
    /// Return updated account flag.
    /// Empty string is returned if the flag is `false`
    public var return_updated_account: Bool?

    public init(message: String, account: TSDKAccountForExecutor, execution_options: TSDKExecutionOptions? = nil, abi: TSDKAbi? = nil, skip_transaction_check: Bool? = nil, boc_cache: TSDKBocCacheType? = nil, return_updated_account: Bool? = nil) {
        self.message = message
        self.account = account
        self.execution_options = execution_options
        self.abi = abi
        self.skip_transaction_check = skip_transaction_check
        self.boc_cache = boc_cache
        self.return_updated_account = return_updated_account
    }
}

public struct TSDKResultOfRunExecutor: Codable {
    /// Parsed transaction.
    /// In addition to the regular transaction fields there is a`boc` field encoded with `base64` which contains sourcetransaction BOC.
    public var transaction: AnyValue
    /// List of output messages' BOCs.
    /// Encoded as `base64`
    public var out_messages: [String]
    /// Optional decoded message bodies according to the optional `abi` parameter.
    public var decoded: TSDKDecodedOutput?
    /// Updated account state BOC.
    /// Encoded as `base64`
    public var account: String
    /// Transaction fees
    public var fees: TSDKTransactionFees

    public init(transaction: AnyValue, out_messages: [String], decoded: TSDKDecodedOutput? = nil, account: String, fees: TSDKTransactionFees) {
        self.transaction = transaction
        self.out_messages = out_messages
        self.decoded = decoded
        self.account = account
        self.fees = fees
    }
}

public struct TSDKParamsOfRunTvm: Codable {
    /// Input message BOC.
    /// Must be encoded as base64.
    public var message: String
    /// Account BOC.
    /// Must be encoded as base64.
    public var account: String
    /// Execution options.
    public var execution_options: TSDKExecutionOptions?
    /// Contract ABI for decoding output messages
    public var abi: TSDKAbi?
    /// Cache type to put the result.
    /// The BOC itself returned if no cache type provided
    public var boc_cache: TSDKBocCacheType?
    /// Return updated account flag.
    /// Empty string is returned if the flag is `false`
    public var return_updated_account: Bool?

    public init(message: String, account: String, execution_options: TSDKExecutionOptions? = nil, abi: TSDKAbi? = nil, boc_cache: TSDKBocCacheType? = nil, return_updated_account: Bool? = nil) {
        self.message = message
        self.account = account
        self.execution_options = execution_options
        self.abi = abi
        self.boc_cache = boc_cache
        self.return_updated_account = return_updated_account
    }
}

public struct TSDKResultOfRunTvm: Codable {
    /// List of output messages' BOCs.
    /// Encoded as `base64`
    public var out_messages: [String]
    /// Optional decoded message bodies according to the optional `abi` parameter.
    public var decoded: TSDKDecodedOutput?
    /// Updated account state BOC.
    /// Encoded as `base64`. Attention! Only `account_state.storage.state.data` part of the BOC is updated.
    public var account: String

    public init(out_messages: [String], decoded: TSDKDecodedOutput? = nil, account: String) {
        self.out_messages = out_messages
        self.decoded = decoded
        self.account = account
    }
}

public struct TSDKParamsOfRunGet: Codable {
    /// Account BOC in `base64`
    public var account: String
    /// Function name
    public var function_name: String
    /// Input parameters
    public var input: AnyValue?
    /// Execution options
    public var execution_options: TSDKExecutionOptions?
    /// Convert lists based on nested tuples in the **result** into plain arrays.
    /// Default is `false`. Input parameters may use any of lists representationsIf you receive this error on Web: "Runtime error. Unreachable code should not be executed...",set this flag to true.
    /// This may happen, for example, when elector contract contains too many participants
    public var tuple_list_as_array: Bool?

    public init(account: String, function_name: String, input: AnyValue? = nil, execution_options: TSDKExecutionOptions? = nil, tuple_list_as_array: Bool? = nil) {
        self.account = account
        self.function_name = function_name
        self.input = input
        self.execution_options = execution_options
        self.tuple_list_as_array = tuple_list_as_array
    }
}

public struct TSDKResultOfRunGet: Codable {
    /// Values returned by get-method on stack
    public var output: AnyValue

    public init(output: AnyValue) {
        self.output = output
    }
}

