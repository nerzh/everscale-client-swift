public final class TSDKDebotModule {

    private var binding: TSDKBindingModule
    public let module: String = "debot"

    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }

    public func initialize(_ payload: TSDKParamsOfInit, _ handler: @escaping (TSDKBindingResponse<TSDKRegisteredDebot, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "initialize"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKRegisteredDebot, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func start(_ payload: TSDKParamsOfStart, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "start"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func fetch(_ payload: TSDKParamsOfFetch, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfFetch, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "fetch"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfFetch, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func execute(_ payload: TSDKParamsOfExecute, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "execute"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func send(_ payload: TSDKParamsOfSend, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "send"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func remove(_ payload: TSDKParamsOfRemove, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "remove"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

}
