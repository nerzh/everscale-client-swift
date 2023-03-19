public final class TSDKNetModule {

    private var binding: TSDKBindingModule
    public let module: String = "net"

    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }

    /// Performs DAppServer GraphQL query.
    public func query(_ payload: TSDKParamsOfQuery, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfQuery, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "query"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfQuery, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Performs multiple queries per single fetch.
    public func batch_query(_ payload: TSDKParamsOfBatchQuery, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfBatchQuery, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "batch_query"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfBatchQuery, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Queries collection data
    /// Queries data that satisfies the `filter` conditions,limits the number of returned records and orders them.
    /// The projection fields are limited to `result` fields
    public func query_collection(_ payload: TSDKParamsOfQueryCollection, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfQueryCollection, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "query_collection"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfQueryCollection, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Aggregates collection data.
    /// Aggregates values from the specified `fields` for recordsthat satisfies the `filter` conditions,
    public func aggregate_collection(_ payload: TSDKParamsOfAggregateCollection, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfAggregateCollection, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "aggregate_collection"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfAggregateCollection, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Returns an object that fulfills the conditions or waits for its appearance
    /// Triggers only once.
    /// If object that satisfies the `filter` conditionsalready exists - returns it immediately.
    /// If not - waits for insert/update of data within the specified `timeout`,and returns it.
    /// The projection fields are limited to `result` fields
    public func wait_for_collection(_ payload: TSDKParamsOfWaitForCollection, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfWaitForCollection, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "wait_for_collection"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfWaitForCollection, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Cancels a subscription
    /// Cancels a subscription specified by its handle.
    public func unsubscribe(_ payload: TSDKResultOfSubscribeCollection, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "unsubscribe"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Creates a collection subscription
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
    public func subscribe_collection(_ payload: TSDKParamsOfSubscribeCollection, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfSubscribeCollection, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "subscribe_collection"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfSubscribeCollection, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Creates a subscription
    /// The subscription is a persistent communication channel betweenclient and Everscale Network.
    /// ### Important Notes on SubscriptionsUnfortunately sometimes the connection with the network breaks down.
    /// In this situation the library attempts to reconnect to the network.
    /// This reconnection sequence can take significant time.
    /// All of this time the client is disconnected from the network.
    /// Bad news is that all changes that happened whilethe client was disconnected are lost.
    /// Good news is that the client report errors to the callback whenit loses and resumes connection.
    /// So, if the lost changes are important to the application thenthe application must handle these error reports.
    /// Library reports errors with `responseType` == 101and the error object passed via `params`.
    /// When the library has successfully reconnectedthe application receives callback with`responseType` == 101 and `params.code` == 614 (NetworkModuleResumed).
    /// Application can use several ways to handle this situation:
    /// - If application monitors changes for the singleobject (for example specific account):  applicationcan perform a query for this object and handle actual data as aregular data from the subscription.
    /// - If application monitors sequence of some objects(for example transactions of the specific account): application mustrefresh all cached (or visible to user) lists where this sequences presents.
    public func subscribe(_ payload: TSDKParamsOfSubscribe, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfSubscribeCollection, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "subscribe"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfSubscribeCollection, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Suspends network module to stop any network activity
    public func suspend(_ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "suspend"
        try binding.requestLibraryAsync(methodName(module, method), "") { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Resumes network module to enable network activity
    public func resume(_ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "resume"
        try binding.requestLibraryAsync(methodName(module, method), "") { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Returns ID of the last block in a specified account shard
    public func find_last_shard_block(_ payload: TSDKParamsOfFindLastShardBlock, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfFindLastShardBlock, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "find_last_shard_block"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfFindLastShardBlock, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Requests the list of alternative endpoints from server
    public func fetch_endpoints(_ handler: @escaping (TSDKBindingResponse<TSDKEndpointsSet, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "fetch_endpoints"
        try binding.requestLibraryAsync(methodName(module, method), "") { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKEndpointsSet, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Sets the list of endpoints to use on reinit
    public func set_endpoints(_ payload: TSDKEndpointsSet, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "set_endpoints"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Requests the list of alternative endpoints from server
    public func get_endpoints(_ handler: @escaping (TSDKBindingResponse<TSDKResultOfGetEndpoints, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "get_endpoints"
        try binding.requestLibraryAsync(methodName(module, method), "") { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetEndpoints, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }
    
    public func get_endpoints() async throws -> TSDKResultOfGetEndpoints {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "get_endpoints"
                try binding.requestLibraryAsync(methodName(module, method), "") { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfGetEndpoints, TSDKClientError> = .init()
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

    /// Allows to query and paginate through the list of accounts that the specified account has interacted with, sorted by the time of the last internal message between accounts
    /// *Attention* this query retrieves data from 'Counterparties' service which is not supported inthe opensource version of DApp Server (and will not be supported) as well as in Evernode SE (will be supported in SE in future),but is always accessible via [EVER OS Clouds](../ton-os-api/networks.md)
    public func query_counterparties(_ payload: TSDKParamsOfQueryCounterparties, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfQueryCollection, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "query_counterparties"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfQueryCollection, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Returns a tree of transactions triggered by a specific message.
    /// Performs recursive retrieval of a transactions tree produced by a specific message:
    /// in_msg -> dst_transaction -> out_messages -> dst_transaction -> ...
    /// If the chain of transactions execution is in progress while the function is running,it will wait for the next transactions to appear until the full tree or more than 50 transactionsare received.
    /// All the retrieved messages and transactions are includedinto `result.messages` and `result.transactions` respectively.
    /// Function reads transactions layer by layer, by pages of 20 transactions.
    /// The retrieval process goes like this:
    /// Let's assume we have an infinite chain of transactions and each transaction generates 5 messages.
    /// 1. Retrieve 1st message (input parameter) and corresponding transaction - put it into result.
    /// It is the first level of the tree of transactions - its root.
    /// Retrieve 5 out message ids from the transaction for next steps.
    /// 2. Retrieve 5 messages and corresponding transactions on the 2nd layer. Put them into result.
    /// Retrieve 5*5 out message ids from these transactions for next steps3. Retrieve 20 (size of the page) messages and transactions (3rd layer) and 20*5=100 message ids (4th layer).
    /// 4. Retrieve the last 5 messages and 5 transactions on the 3rd layer + 15 messages and transactions (of 100) from the 4th layer+ 25 message ids of the 4th layer + 75 message ids of the 5th layer.
    /// 5. Retrieve 20 more messages and 20 more transactions of the 4th layer + 100 more message ids of the 5th layer.
    /// 6. Now we have 1+5+20+20+20 = 66 transactions, which is more than 50. Function exits with the tree of1m->1t->5m->5t->25m->25t->35m->35t. If we see any message ids in the last transactions out_msgs, which don't havecorresponding messages in the function result, it means that the full tree was not received and we need to continue iteration.
    /// To summarize, it is guaranteed that each message in `result.messages` has the corresponding transactionin the `result.transactions`.
    /// But there is no guarantee that all messages from transactions `out_msgs` arepresented in `result.messages`.
    /// So the application has to continue retrieval for missing messages if it requires.
    public func query_transaction_tree(_ payload: TSDKParamsOfQueryTransactionTree, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfQueryTransactionTree, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "query_transaction_tree"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfQueryTransactionTree, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Creates block iterator.
    /// Block iterator uses robust iteration methods that guaranties that everyblock in the specified range isn't missed or iterated twice.
    /// Iterated range can be reduced with some filters:
    /// - `start_time` – the bottom time range. Only blocks with `gen_utime`more or equal to this value is iterated. If this parameter is omitted then there isno bottom time edge, so all blocks since zero state is iterated.
    /// - `end_time` – the upper time range. Only blocks with `gen_utime`less then this value is iterated. If this parameter is omitted then there isno upper time edge, so iterator never finishes.
    /// - `shard_filter` – workchains and shard prefixes that reduce the set of interestingblocks. Block conforms to the shard filter if it belongs to the filter workchainand the first bits of block's `shard` fields matches to the shard prefix.
    /// Only blocks with suitable shard are iterated.
    /// Items iterated is a JSON objects with block data. The minimal set of returnedfields is:
    /// ```textidgen_utimeworkchain_idshardafter_splitafter_mergeprev_ref {    root_hash}prev_alt_ref {    root_hash}```Application can request additional fields in the `result` parameter.
    /// Application should call the `remove_iterator` when iterator is no longer required.
    public func create_block_iterator(_ payload: TSDKParamsOfCreateBlockIterator, _ handler: @escaping (TSDKBindingResponse<TSDKRegisteredIterator, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "create_block_iterator"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKRegisteredIterator, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Resumes block iterator.
    /// The iterator stays exactly at the same position where the `resume_state` was caught.
    /// Application should call the `remove_iterator` when iterator is no longer required.
    public func resume_block_iterator(_ payload: TSDKParamsOfResumeBlockIterator, _ handler: @escaping (TSDKBindingResponse<TSDKRegisteredIterator, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "resume_block_iterator"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKRegisteredIterator, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Creates transaction iterator.
    /// Transaction iterator uses robust iteration methods that guaranty that everytransaction in the specified range isn't missed or iterated twice.
    /// Iterated range can be reduced with some filters:
    /// - `start_time` – the bottom time range. Only transactions with `now`more or equal to this value are iterated. If this parameter is omitted then there isno bottom time edge, so all the transactions since zero state are iterated.
    /// - `end_time` – the upper time range. Only transactions with `now`less then this value are iterated. If this parameter is omitted then there isno upper time edge, so iterator never finishes.
    /// - `shard_filter` – workchains and shard prefixes that reduce the set of interestingaccounts. Account address conforms to the shard filter ifit belongs to the filter workchain and the first bits of address match tothe shard prefix. Only transactions with suitable account addresses are iterated.
    /// - `accounts_filter` – set of account addresses whose transactions must be iterated.
    /// Note that accounts filter can conflict with shard filter so application must combinethese filters carefully.
    /// Iterated item is a JSON objects with transaction data. The minimal set of returnedfields is:
    /// ```textidaccount_addrnowbalance_delta(format:DEC)bounce { bounce_type }in_message {    id    value(format:DEC)    msg_type    src}out_messages {    id    value(format:DEC)    msg_type    dst}```Application can request an additional fields in the `result` parameter.
    /// Another parameter that affects on the returned fields is the `include_transfers`.
    /// When this parameter is `true` the iterator computes and adds `transfer` field containinglist of the useful `TransactionTransfer` objects.
    /// Each transfer is calculated from the particular message related to the transactionand has the following structure:
    /// - message – source message identifier.
    /// - isBounced – indicates that the transaction is bounced, which means the value will be returned back to the sender.
    /// - isDeposit – indicates that this transfer is the deposit (true) or withdraw (false).
    /// - counterparty – account address of the transfer source or destination depending on `isDeposit`.
    /// - value – amount of nano tokens transferred. The value is represented as a decimal stringbecause the actual value can be more precise than the JSON number can represent. Applicationmust use this string carefully – conversion to number can follow to loose of precision.
    /// Application should call the `remove_iterator` when iterator is no longer required.
    public func create_transaction_iterator(_ payload: TSDKParamsOfCreateTransactionIterator, _ handler: @escaping (TSDKBindingResponse<TSDKRegisteredIterator, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "create_transaction_iterator"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKRegisteredIterator, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Resumes transaction iterator.
    /// The iterator stays exactly at the same position where the `resume_state` was caught.
    /// Note that `resume_state` doesn't store the account filter. If the application requiresto use the same account filter as it was when the iterator was created then the applicationmust pass the account filter again in `accounts_filter` parameter.
    /// Application should call the `remove_iterator` when iterator is no longer required.
    public func resume_transaction_iterator(_ payload: TSDKParamsOfResumeTransactionIterator, _ handler: @escaping (TSDKBindingResponse<TSDKRegisteredIterator, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "resume_transaction_iterator"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKRegisteredIterator, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Returns next available items.
    /// In addition to available items this function returns the `has_more` flagindicating that the iterator isn't reach the end of the iterated range yet.
    /// This function can return the empty list of available items butindicates that there are more items is available.
    /// This situation appears when the iterator doesn't reach iterated rangebut database doesn't contains available items yet.
    /// If application requests resume state in `return_resume_state` parameterthen this function returns `resume_state` that can be used later toresume the iteration from the position after returned items.
    /// The structure of the items returned depends on the iterator used.
    /// See the description to the appropriated iterator creation function.
    public func iterator_next(_ payload: TSDKParamsOfIteratorNext, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfIteratorNext, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "iterator_next"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfIteratorNext, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Removes an iterator
    /// Frees all resources allocated in library to serve iterator.
    /// Application always should call the `remove_iterator` when iteratoris no longer required.
    public func remove_iterator(_ payload: TSDKRegisteredIterator, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "remove_iterator"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Returns signature ID for configured network if it should be used in messages signature
    public func get_signature_id(_ handler: @escaping (TSDKBindingResponse<TSDKResultOfGetSignatureId, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "get_signature_id"
        try binding.requestLibraryAsync(methodName(module, method), "") { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfGetSignatureId, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

}
