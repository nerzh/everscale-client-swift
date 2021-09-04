public final class TSDKDebotModule {

    private var binding: TSDKBindingModule
    public let module: String = "debot"

    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }

    /// [UNSTABLE](UNSTABLE.md) Creates and instance of DeBot.
    /// Downloads debot smart contract (code and data) from blockchain and createsan instance of Debot Engine for it.
    /// # RemarksIt does not switch debot to context 0. Browser Callbacks are not called.
    public func initialize(_ payload: TSDKParamsOfInit, _ handler: @escaping (TSDKBindingResponse<TSDKRegisteredDebot, TSDKClientError, TSDKDefault>) throws -> Void
    ) {
        let method: String = "init"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKRegisteredDebot, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// [UNSTABLE](UNSTABLE.md) Starts the DeBot.
    /// Downloads debot smart contract from blockchain and switches it tocontext zero.
    /// This function must be used by Debot Browser to start a dialog with debot.
    /// While the function is executing, several Browser Callbacks can be called,since the debot tries to display all actions from the context 0 to the user.
    /// When the debot starts SDK registers `BrowserCallbacks` AppObject.
    /// Therefore when `debote.remove` is called the debot is being deleted and the callback is calledwith `finish`=`true` which indicates that it will never be used again.
    public func start(_ payload: TSDKParamsOfStart, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault>) throws -> Void
    ) {
        let method: String = "start"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// [UNSTABLE](UNSTABLE.md) Fetches DeBot metadata from blockchain.
    /// Downloads DeBot from blockchain and creates and fetches its metadata.
    public func fetch(_ payload: TSDKParamsOfFetch, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfFetch, TSDKClientError, TSDKDefault>) throws -> Void
    ) {
        let method: String = "fetch"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfFetch, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// [UNSTABLE](UNSTABLE.md) Executes debot action.
    /// Calls debot engine referenced by debot handle to execute input action.
    /// Calls Debot Browser Callbacks if needed.
    /// # RemarksChain of actions can be executed if input action generates a list of subactions.
    public func execute(_ payload: TSDKParamsOfExecute, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault>) throws -> Void
    ) {
        let method: String = "execute"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// [UNSTABLE](UNSTABLE.md) Sends message to Debot.
    /// Used by Debot Browser to send response on Dinterface call or from other Debots.
    public func send(_ payload: TSDKParamsOfSend, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault>) throws -> Void
    ) {
        let method: String = "send"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// [UNSTABLE](UNSTABLE.md) Destroys debot handle.
    /// Removes handle from Client Context and drops debot engine referenced by that handle.
    public func remove(_ payload: TSDKParamsOfRemove, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault>) throws -> Void
    ) {
        let method: String = "remove"
        binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

}
