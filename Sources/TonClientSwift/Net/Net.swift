public final class TSDKNetModule {

    private var binding: TSDKBindingModule
    public let module: String = "net"

    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }

    /// Performs DAppServer GraphQL query.
    public func query(_ payload: TSDKParamsOfQuery, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfQuery, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "query"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfQuery, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Performs multiple queries per single fetch.
    public func batch_query(_ payload: TSDKParamsOfBatchQuery, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfBatchQuery, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "batch_query"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfBatchQuery, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Queries collection data
    /// Queries data that satisfies the `filter` conditions,limits the number of returned records and orders them.
    /// The projection fields are limited to `result` fields
    public func query_collection(_ payload: TSDKParamsOfQueryCollection, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfQueryCollection, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "query_collection"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfQueryCollection, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Aggregates collection data.
    /// Aggregates values from the specified `fields` for recordsthat satisfies the `filter` conditions,
    public func aggregate_collection(_ payload: TSDKParamsOfAggregateCollection, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfAggregateCollection, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "aggregate_collection"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfAggregateCollection, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Returns an object that fulfills the conditions or waits for its appearance
    /// Triggers only once.
    /// If object that satisfies the `filter` conditionsalready exists - returns it immediately.
    /// If not - waits for insert/update of data within the specified `timeout`,and returns it.
    /// The projection fields are limited to `result` fields
    public func wait_for_collection(_ payload: TSDKParamsOfWaitForCollection, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfWaitForCollection, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "wait_for_collection"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfWaitForCollection, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Cancels a subscription
    /// Cancels a subscription specified by its handle.
    public func unsubscribe(_ payload: TSDKResultOfSubscribeCollection, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "unsubscribe"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Creates a subscription
    /// Triggers for each insert/update of data that satisfiesthe `filter` conditions.
    /// The projection fields are limited to `result` fields.
    /// The subscription is a persistent communication channel betweenclient and Free TON Network.
    /// All changes in the blockchain will be reflected in realtime.
    /// Changes means inserts and updates of the blockchain entities.
    /// ### Important Notes on SubscriptionsUnfortunately sometimes the connection with the network brakes down.
    /// In this situation the library attempts to reconnect to the network.
    /// This reconnection sequence can take significant time.
    /// All of this time the client is disconnected from the network.
    /// Bad news is that all blockchain changes that happened whilethe client was disconnected are lost.
    /// Good news is that the client report errors to the callback whenit loses and resumes connection.
    /// So, if the lost changes are important to the application thenthe application must handle these error reports.
    /// Library reports errors with `responseType` == 101and the error object passed via `params`.
    /// When the library has successfully reconnectedthe application receives callback with`responseType` == 101 and `params.code` == 614 (NetworkModuleResumed).
    /// Application can use several ways to handle this situation:
    /// - If application monitors changes for the single blockchainobject (for example specific account):  applicationcan perform a query for this object and handle actual data as aregular data from the subscription.
    /// - If application monitors sequence of some blockchain objects(for example transactions of the specific account): application mustrefresh all cached (or visible to user) lists where this sequences presents.
    public func subscribe_collection(_ payload: TSDKParamsOfSubscribeCollection, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfSubscribeCollection, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "subscribe_collection"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfSubscribeCollection, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Suspends network module to stop any network activity
    public func suspend(_ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "suspend"
        binding.requestLibraryAsync(methodName(module, method), "", { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Resumes network module to enable network activity
    public func resume(_ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "resume"
        binding.requestLibraryAsync(methodName(module, method), "", { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Returns ID of the last block in a specified account shard
    public func find_last_shard_block(_ payload: TSDKParamsOfFindLastShardBlock, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfFindLastShardBlock, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "find_last_shard_block"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfFindLastShardBlock, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Requests the list of alternative endpoints from server
    public func fetch_endpoints(_ handler: @escaping (TSDKBindingResponse<TSDKEndpointsSet, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "fetch_endpoints"
        binding.requestLibraryAsync(methodName(module, method), "", { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKEndpointsSet, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Sets the list of endpoints to use on reinit
    public func set_endpoints(_ payload: TSDKEndpointsSet, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "set_endpoints"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Requests the list of alternative endpoints from server
    public func get_endpoints(_ handler: @escaping (TSDKBindingResponse<TSDKResultOfGetEndpoints, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "get_endpoints"
        binding.requestLibraryAsync(methodName(module, method), "", { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetEndpoints, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Allows to query and paginate through the list of accounts that the specified account has interacted with, sorted by the time of the last internal message between accounts
    /// *Attention* this query retrieves data from 'Counterparties' service which is not supported inthe opensource version of DApp Server (and will not be supported) as well as in TON OS SE (will be supported in SE in future),but is always accessible via [TON OS Devnet/Mainnet Clouds](https://docs.ton.dev/86757ecb2/p/85c869-networks)
    public func query_counterparties(_ payload: TSDKParamsOfQueryCounterparties, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfQueryCollection, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "query_counterparties"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfQueryCollection, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Returns transactions tree for specific message.
    /// Performs recursive retrieval of the transactions tree produced by the specific message:
    /// in_msg -> dst_transaction -> out_messages -> dst_transaction -> ...
    /// All retrieved messages and transactions will be includedinto `result.messages` and `result.transactions` respectively.
    /// The retrieval process will stop when the retrieved transaction count is more than 50.
    /// It is guaranteed that each message in `result.messages` has the corresponding transactionin the `result.transactions`.
    /// But there are no guaranties that all messages from transactions `out_msgs` arepresented in `result.messages`.
    /// So the application have to continue retrieval for missing messages if it requires.
    public func query_transaction_tree(_ payload: TSDKParamsOfQueryTransactionTree, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfQueryTransactionTree, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "query_transaction_tree"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfQueryTransactionTree, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

}
