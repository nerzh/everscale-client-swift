public final class TSDKProcessingModule {

    private var binding: TSDKBindingModule
    public let module: String = "processing"

    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }

    public func send_message(_ payload: TSDKParamsOfSendMessage, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfSendMessage, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "send_message"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfSendMessage, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func wait_for_transaction(_ payload: TSDKParamsOfWaitForTransaction, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfProcessMessage, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "wait_for_transaction"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfProcessMessage, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    public func process_message(_ payload: TSDKParamsOfProcessMessage, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfProcessMessage, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "process_message"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfProcessMessage, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

}
