import Foundation
import SwiftExtensionsPack


public enum TSDKNetErrorCode: Int, Codable {
    case QueryFailed = 601
    case SubscribeFailed = 602
    case WaitForFailed = 603
    case GetSubscriptionResultFailed = 604
    case InvalidServerResponse = 605
    case ClockOutOfSync = 606
    case WaitForTimeout = 607
    case GraphqlError = 608
    case NetworkModuleSuspended = 609
    case WebsocketDisconnected = 610
    case NotSupported = 611
    case NoEndpointsProvided = 612
    case GraphqlWebsocketInitError = 613
    case NetworkModuleResumed = 614
    case Unauthorized = 615
    case QueryTransactionTreeTimeout = 616
    case GraphqlConnectionError = 617
}

public enum TSDKSortDirection: String, Codable {
    case ASC = "ASC"
    case DESC = "DESC"
}

public enum TSDKParamsOfQueryOperationEnumTypes: String, Codable {
    case QueryCollection = "QueryCollection"
    case WaitForCollection = "WaitForCollection"
    case AggregateCollection = "AggregateCollection"
    case QueryCounterparties = "QueryCounterparties"
}

public enum TSDKAggregationFn: String, Codable {
    case COUNT = "COUNT"
    case MIN = "MIN"
    case MAX = "MAX"
    case SUM = "SUM"
    case AVERAGE = "AVERAGE"
}

public struct TSDKOrderBy: Codable {
    public var path: String
    public var direction: TSDKSortDirection

    public init(path: String, direction: TSDKSortDirection) {
        self.path = path
        self.direction = direction
    }
}

public struct TSDKParamsOfQueryOperation: Codable {
    public var type: TSDKParamsOfQueryOperationEnumTypes

    public init(type: TSDKParamsOfQueryOperationEnumTypes) {
        self.type = type
    }
}

public struct TSDKFieldAggregation: Codable {
    /// Dot separated path to the field
    public var field: String
    /// Aggregation function that must be applied to field values
    public var fn: TSDKAggregationFn

    public init(field: String, fn: TSDKAggregationFn) {
        self.field = field
        self.fn = fn
    }
}

public struct TSDKTransactionNode: Codable {
    /// Transaction id.
    public var id: String
    /// In message id.
    public var in_msg: String
    /// Out message ids.
    public var out_msgs: [String]
    /// Account address.
    public var account_addr: String
    /// Transactions total fees.
    public var total_fees: String
    /// Aborted flag.
    public var aborted: Bool
    /// Compute phase exit code.
    public var exit_code: UInt32?

    public init(id: String, in_msg: String, out_msgs: [String], account_addr: String, total_fees: String, aborted: Bool, exit_code: UInt32? = nil) {
        self.id = id
        self.in_msg = in_msg
        self.out_msgs = out_msgs
        self.account_addr = account_addr
        self.total_fees = total_fees
        self.aborted = aborted
        self.exit_code = exit_code
    }
}

public struct TSDKMessageNode: Codable {
    /// Message id.
    public var id: String
    /// Source transaction id.
    /// This field is missing for an external inbound messages.
    public var src_transaction_id: String?
    /// Destination transaction id.
    /// This field is missing for an external outbound messages.
    public var dst_transaction_id: String?
    /// Source address.
    public var src: String?
    /// Destination address.
    public var dst: String?
    /// Transferred tokens value.
    public var value: String?
    /// Bounce flag.
    public var bounce: Bool
    /// Decoded body.
    /// Library tries to decode message body using provided `params.abi_registry`.
    /// This field will be missing if none of the provided abi can be used to decode.
    public var decoded_body: TSDKDecodedMessageBody?

    public init(id: String, src_transaction_id: String? = nil, dst_transaction_id: String? = nil, src: String? = nil, dst: String? = nil, value: String? = nil, bounce: Bool, decoded_body: TSDKDecodedMessageBody? = nil) {
        self.id = id
        self.src_transaction_id = src_transaction_id
        self.dst_transaction_id = dst_transaction_id
        self.src = src
        self.dst = dst
        self.value = value
        self.bounce = bounce
        self.decoded_body = decoded_body
    }
}

public struct TSDKParamsOfQuery: Codable {
    /// GraphQL query text.
    public var query: String
    /// Variables used in query.
    /// Must be a map with named values that can be used in query.
    public var variables: AnyValue?

    public init(query: String, variables: AnyValue? = nil) {
        self.query = query
        self.variables = variables
    }
}

public struct TSDKResultOfQuery: Codable {
    /// Result provided by DAppServer.
    public var result: AnyValue

    public init(result: AnyValue) {
        self.result = result
    }
}

public struct TSDKParamsOfBatchQuery: Codable {
    /// List of query operations that must be performed per single fetch.
    public var operations: [TSDKParamsOfQueryOperation]

    public init(operations: [TSDKParamsOfQueryOperation]) {
        self.operations = operations
    }
}

public struct TSDKResultOfBatchQuery: Codable {
    /// Result values for batched queries.
    /// Returns an array of values. Each value corresponds to `queries` item.
    public var results: [AnyValue]

    public init(results: [AnyValue]) {
        self.results = results
    }
}

public struct TSDKParamsOfQueryCollection: Codable {
    /// Collection name (accounts, blocks, transactions, messages, block_signatures)
    public var collection: String
    /// Collection filter
    public var filter: AnyValue?
    /// Projection (result) string
    public var result: String
    /// Sorting order
    public var order: [TSDKOrderBy]?
    /// Number of documents to return
    public var limit: UInt32?

    public init(collection: String, filter: AnyValue? = nil, result: String, order: [TSDKOrderBy]? = nil, limit: UInt32? = nil) {
        self.collection = collection
        self.filter = filter
        self.result = result
        self.order = order
        self.limit = limit
    }
}

public struct TSDKResultOfQueryCollection: Codable {
    /// Objects that match the provided criteria
    public var result: [AnyValue]

    public init(result: [AnyValue]) {
        self.result = result
    }
}

public struct TSDKParamsOfAggregateCollection: Codable {
    /// Collection name (accounts, blocks, transactions, messages, block_signatures)
    public var collection: String
    /// Collection filter
    public var filter: AnyValue?
    /// Projection (result) string
    public var fields: [TSDKFieldAggregation]?

    public init(collection: String, filter: AnyValue? = nil, fields: [TSDKFieldAggregation]? = nil) {
        self.collection = collection
        self.filter = filter
        self.fields = fields
    }
}

public struct TSDKResultOfAggregateCollection: Codable {
    /// Values for requested fields.
    /// Returns an array of strings. Each string refers to the corresponding `fields` item.
    /// Numeric value is returned as a decimal string representations.
    public var values: AnyValue

    public init(values: AnyValue) {
        self.values = values
    }
}

public struct TSDKParamsOfWaitForCollection: Codable {
    /// Collection name (accounts, blocks, transactions, messages, block_signatures)
    public var collection: String
    /// Collection filter
    public var filter: AnyValue?
    /// Projection (result) string
    public var result: String
    /// Query timeout
    public var timeout: UInt32?

    public init(collection: String, filter: AnyValue? = nil, result: String, timeout: UInt32? = nil) {
        self.collection = collection
        self.filter = filter
        self.result = result
        self.timeout = timeout
    }
}

public struct TSDKResultOfWaitForCollection: Codable {
    /// First found object that matches the provided criteria
    public var result: AnyValue

    public init(result: AnyValue) {
        self.result = result
    }
}

public struct TSDKResultOfSubscribeCollection: Codable {
    /// Subscription handle.
    /// Must be closed with `unsubscribe`
    public var handle: UInt32

    public init(handle: UInt32) {
        self.handle = handle
    }
}

public struct TSDKParamsOfSubscribeCollection: Codable {
    /// Collection name (accounts, blocks, transactions, messages, block_signatures)
    public var collection: String
    /// Collection filter
    public var filter: AnyValue?
    /// Projection (result) string
    public var result: String

    public init(collection: String, filter: AnyValue? = nil, result: String) {
        self.collection = collection
        self.filter = filter
        self.result = result
    }
}

public struct TSDKParamsOfSubscribe: Codable {
    /// GraphQL subscription text.
    public var subscription: String
    /// Variables used in subscription.
    /// Must be a map with named values that can be used in query.
    public var variables: AnyValue?

    public init(subscription: String, variables: AnyValue? = nil) {
        self.subscription = subscription
        self.variables = variables
    }
}

public struct TSDKParamsOfFindLastShardBlock: Codable {
    /// Account address
    public var address: String

    public init(address: String) {
        self.address = address
    }
}

public struct TSDKResultOfFindLastShardBlock: Codable {
    /// Account shard last block ID
    public var block_id: String

    public init(block_id: String) {
        self.block_id = block_id
    }
}

public struct TSDKEndpointsSet: Codable {
    /// List of endpoints provided by server
    public var endpoints: [String]

    public init(endpoints: [String]) {
        self.endpoints = endpoints
    }
}

public struct TSDKResultOfGetEndpoints: Codable {
    /// Current query endpoint
    public var query: String
    /// List of all endpoints used by client
    public var endpoints: [String]

    public init(query: String, endpoints: [String]) {
        self.query = query
        self.endpoints = endpoints
    }
}

public struct TSDKParamsOfQueryCounterparties: Codable {
    /// Account address
    public var account: String
    /// Projection (result) string
    public var result: String
    /// Number of counterparties to return
    public var first: UInt32?
    /// `cursor` field of the last received result
    public var after: String?

    public init(account: String, result: String, first: UInt32? = nil, after: String? = nil) {
        self.account = account
        self.result = result
        self.first = first
        self.after = after
    }
}

public struct TSDKParamsOfQueryTransactionTree: Codable {
    /// Input message id.
    public var in_msg: String
    /// List of contract ABIs that will be used to decode message bodies. Library will try to decode each returned message body using any ABI from the registry.
    public var abi_registry: [TSDKAbi]?
    /// Timeout used to limit waiting time for the missing messages and transaction.
    /// If some of the following messages and transactions are missing yetThe maximum waiting time is regulated by this option.
    /// Default value is 60000 (1 min). If `timeout` is set to 0 then function will wait infinitelyuntil the whole transaction tree is executed
    public var timeout: UInt32?
    /// Maximum transaction count to wait.
    /// If transaction tree contains more transaction then this parameter then only first `transaction_max_count` transaction are awaited and returned.
    /// Default value is 50. If `transaction_max_count` is set to 0 then no limitation ontransaction count is used and all transaction are returned.
    public var transaction_max_count: UInt32?

    public init(in_msg: String, abi_registry: [TSDKAbi]? = nil, timeout: UInt32? = nil, transaction_max_count: UInt32? = nil) {
        self.in_msg = in_msg
        self.abi_registry = abi_registry
        self.timeout = timeout
        self.transaction_max_count = transaction_max_count
    }
}

public struct TSDKResultOfQueryTransactionTree: Codable {
    /// Messages.
    public var messages: [TSDKMessageNode]
    /// Transactions.
    public var transactions: [TSDKTransactionNode]

    public init(messages: [TSDKMessageNode], transactions: [TSDKTransactionNode]) {
        self.messages = messages
        self.transactions = transactions
    }
}

public struct TSDKParamsOfCreateBlockIterator: Codable {
    /// Starting time to iterate from.
    /// If the application specifies this parameter then the iterationincludes blocks with `gen_utime` >= `start_time`.
    /// Otherwise the iteration starts from zero state.
    /// Must be specified in seconds.
    public var start_time: UInt32?
    /// Optional end time to iterate for.
    /// If the application specifies this parameter then the iterationincludes blocks with `gen_utime` < `end_time`.
    /// Otherwise the iteration never stops.
    /// Must be specified in seconds.
    public var end_time: UInt32?
    /// Shard prefix filter.
    /// If the application specifies this parameter and it is not the empty arraythen the iteration will include items related to accounts that belongs tothe specified shard prefixes.
    /// Shard prefix must be represented as a string "workchain:prefix".
    /// Where `workchain` is a signed integer and the `prefix` if a hexadecimalrepresentation if the 64-bit unsigned integer with tagged shard prefix.
    /// For example: "0:3800000000000000".
    public var shard_filter: [String]?
    /// Projection (result) string.
    /// List of the fields that must be returned for iterated items.
    /// This field is the same as the `result` parameter ofthe `query_collection` function.
    /// Note that iterated items can contains additional fields that arenot requested in the `result`.
    public var result: String?

    public init(start_time: UInt32? = nil, end_time: UInt32? = nil, shard_filter: [String]? = nil, result: String? = nil) {
        self.start_time = start_time
        self.end_time = end_time
        self.shard_filter = shard_filter
        self.result = result
    }
}

public struct TSDKRegisteredIterator: Codable {
    /// Iterator handle.
    /// Must be removed using `remove_iterator`when it is no more needed for the application.
    public var handle: UInt32

    public init(handle: UInt32) {
        self.handle = handle
    }
}

public struct TSDKParamsOfResumeBlockIterator: Codable {
    /// Iterator state from which to resume.
    /// Same as value returned from `iterator_next`.
    public var resume_state: AnyValue

    public init(resume_state: AnyValue) {
        self.resume_state = resume_state
    }
}

public struct TSDKParamsOfCreateTransactionIterator: Codable {
    /// Starting time to iterate from.
    /// If the application specifies this parameter then the iterationincludes blocks with `gen_utime` >= `start_time`.
    /// Otherwise the iteration starts from zero state.
    /// Must be specified in seconds.
    public var start_time: UInt32?
    /// Optional end time to iterate for.
    /// If the application specifies this parameter then the iterationincludes blocks with `gen_utime` < `end_time`.
    /// Otherwise the iteration never stops.
    /// Must be specified in seconds.
    public var end_time: UInt32?
    /// Shard prefix filters.
    /// If the application specifies this parameter and it is not an empty arraythen the iteration will include items related to accounts that belongs tothe specified shard prefixes.
    /// Shard prefix must be represented as a string "workchain:prefix".
    /// Where `workchain` is a signed integer and the `prefix` if a hexadecimalrepresentation if the 64-bit unsigned integer with tagged shard prefix.
    /// For example: "0:3800000000000000".
    /// Account address conforms to the shard filter ifit belongs to the filter workchain and the first bits of address match tothe shard prefix. Only transactions with suitable account addresses are iterated.
    public var shard_filter: [String]?
    /// Account address filter.
    /// Application can specify the list of accounts for whichit wants to iterate transactions.
    /// If this parameter is missing or an empty list then the library iteratestransactions for all accounts that pass the shard filter.
    /// Note that the library doesn't detect conflicts between the account filter and the shard filterif both are specified.
    /// So it is an application responsibility to specify the correct filter combination.
    public var accounts_filter: [String]?
    /// Projection (result) string.
    /// List of the fields that must be returned for iterated items.
    /// This field is the same as the `result` parameter ofthe `query_collection` function.
    /// Note that iterated items can contain additional fields that arenot requested in the `result`.
    public var result: String?
    /// Include `transfers` field in iterated transactions.
    /// If this parameter is `true` then each transaction contains field`transfers` with list of transfer. See more about this structure in function description.
    public var include_transfers: Bool?

    public init(start_time: UInt32? = nil, end_time: UInt32? = nil, shard_filter: [String]? = nil, accounts_filter: [String]? = nil, result: String? = nil, include_transfers: Bool? = nil) {
        self.start_time = start_time
        self.end_time = end_time
        self.shard_filter = shard_filter
        self.accounts_filter = accounts_filter
        self.result = result
        self.include_transfers = include_transfers
    }
}

public struct TSDKParamsOfResumeTransactionIterator: Codable {
    /// Iterator state from which to resume.
    /// Same as value returned from `iterator_next`.
    public var resume_state: AnyValue
    /// Account address filter.
    /// Application can specify the list of accounts for whichit wants to iterate transactions.
    /// If this parameter is missing or an empty list then the library iteratestransactions for all accounts that passes the shard filter.
    /// Note that the library doesn't detect conflicts between the account filter and the shard filterif both are specified.
    /// So it is the application's responsibility to specify the correct filter combination.
    public var accounts_filter: [String]?

    public init(resume_state: AnyValue, accounts_filter: [String]? = nil) {
        self.resume_state = resume_state
        self.accounts_filter = accounts_filter
    }
}

public struct TSDKParamsOfIteratorNext: Codable {
    /// Iterator handle
    public var iterator: UInt32
    /// Maximum count of the returned items.
    /// If value is missing or is less than 1 the library uses 1.
    public var limit: UInt32?
    /// Indicates that function must return the iterator state that can be used for resuming iteration.
    public var return_resume_state: Bool?

    public init(iterator: UInt32, limit: UInt32? = nil, return_resume_state: Bool? = nil) {
        self.iterator = iterator
        self.limit = limit
        self.return_resume_state = return_resume_state
    }
}

public struct TSDKResultOfIteratorNext: Codable {
    /// Next available items.
    /// Note that `iterator_next` can return an empty items and `has_more` equals to `true`.
    /// In this case the application have to continue iteration.
    /// Such situation can take place when there is no data yet butthe requested `end_time` is not reached.
    public var items: [AnyValue]
    /// Indicates that there are more available items in iterated range.
    public var has_more: Bool
    /// Optional iterator state that can be used for resuming iteration.
    /// This field is returned only if the `return_resume_state` parameteris specified.
    /// Note that `resume_state` corresponds to the iteration positionafter the returned items.
    public var resume_state: AnyValue?

    public init(items: [AnyValue], has_more: Bool, resume_state: AnyValue? = nil) {
        self.items = items
        self.has_more = has_more
        self.resume_state = resume_state
    }
}

public struct TSDKResultOfGetSignatureId: Codable {
    /// Signature ID for configured network if it should be used in messages signature
    public var signature_id: Int32?

    public init(signature_id: Int32? = nil) {
        self.signature_id = signature_id
    }
}

