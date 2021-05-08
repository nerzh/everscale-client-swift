public final class TSDKNetModule {

    private var binding: TSDKBindingModule
    public let module: String = "net"

    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }

    public func query(_ payload: TSDKParamsOfQuery, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfQuery, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "query"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfQuery, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func batch_query(_ payload: TSDKParamsOfBatchQuery, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfBatchQuery, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "batch_query"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfBatchQuery, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func query_collection(_ payload: TSDKParamsOfQueryCollection, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfQueryCollection, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "query_collection"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfQueryCollection, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func aggregate_collection(_ payload: TSDKParamsOfAggregateCollection, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfAggregateCollection, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "aggregate_collection"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfAggregateCollection, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func wait_for_collection(_ payload: TSDKParamsOfWaitForCollection, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfWaitForCollection, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "wait_for_collection"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfWaitForCollection, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func unsubscribe(_ payload: TSDKResultOfSubscribeCollection, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "unsubscribe"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func subscribe_collection(_ payload: TSDKParamsOfSubscribeCollection, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfSubscribeCollection, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "subscribe_collection"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfSubscribeCollection, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func suspend(_ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "suspend"
        binding.requestLibraryAsync(methodName(module, method), "", { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func resume(_ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "resume"
        binding.requestLibraryAsync(methodName(module, method), "", { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func find_last_shard_block(_ payload: TSDKParamsOfFindLastShardBlock, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfFindLastShardBlock, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "find_last_shard_block"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfFindLastShardBlock, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func fetch_endpoints(_ handler: @escaping (TSDKBindingResponse<TSDKEndpointsSet, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "fetch_endpoints"
        binding.requestLibraryAsync(methodName(module, method), "", { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKEndpointsSet, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func set_endpoints(_ payload: TSDKEndpointsSet, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "set_endpoints"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func query_counterparties(_ payload: TSDKParamsOfQueryCounterparties, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfQueryCollection, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "query_counterparties"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfQueryCollection, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

}
