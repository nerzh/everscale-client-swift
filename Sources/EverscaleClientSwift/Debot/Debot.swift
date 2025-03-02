public final class TSDKDebotModule {

    private var binding: TSDKBindingModule
    public let module: String = "debot"

    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }

    /// [UNSTABLE](UNSTABLE.md) [DEPRECATED](DEPRECATED.md) Creates and instance of DeBot.
    /// Downloads debot smart contract (code and data) from blockchain and createsan instance of Debot Engine for it.
    /// # RemarksIt does not switch debot to context 0. Browser Callbacks are not called.
    public func initialize(_ payload: TSDKParamsOfInit, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKRegisteredDebot, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "init"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKRegisteredDebot, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// [UNSTABLE](UNSTABLE.md) [DEPRECATED](DEPRECATED.md) Creates and instance of DeBot.
    /// Downloads debot smart contract (code and data) from blockchain and createsan instance of Debot Engine for it.
    /// # RemarksIt does not switch debot to context 0. Browser Callbacks are not called.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func initialize(_ payload: TSDKParamsOfInit) async throws -> TSDKRegisteredDebot {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "init"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKRegisteredDebot, TSDKClientError> = .init()
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

    /// [UNSTABLE](UNSTABLE.md) [DEPRECATED](DEPRECATED.md) Starts the DeBot.
    /// Downloads debot smart contract from blockchain and switches it tocontext zero.
    /// This function must be used by Debot Browser to start a dialog with debot.
    /// While the function is executing, several Browser Callbacks can be called,since the debot tries to display all actions from the context 0 to the user.
    /// When the debot starts SDK registers `BrowserCallbacks` AppObject.
    /// Therefore when `debote.remove` is called the debot is being deleted and the callback is calledwith `finish`=`true` which indicates that it will never be used again.
    public func start(_ payload: TSDKParamsOfStart, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "start"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// [UNSTABLE](UNSTABLE.md) [DEPRECATED](DEPRECATED.md) Starts the DeBot.
    /// Downloads debot smart contract from blockchain and switches it tocontext zero.
    /// This function must be used by Debot Browser to start a dialog with debot.
    /// While the function is executing, several Browser Callbacks can be called,since the debot tries to display all actions from the context 0 to the user.
    /// When the debot starts SDK registers `BrowserCallbacks` AppObject.
    /// Therefore when `debote.remove` is called the debot is being deleted and the callback is calledwith `finish`=`true` which indicates that it will never be used again.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func start(_ payload: TSDKParamsOfStart) async throws -> TSDKNoneResult {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "start"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
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

    /// [UNSTABLE](UNSTABLE.md) [DEPRECATED](DEPRECATED.md) Fetches DeBot metadata from blockchain.
    /// Downloads DeBot from blockchain and creates and fetches its metadata.
    public func fetch(_ payload: TSDKParamsOfFetch, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfFetch, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "fetch"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfFetch, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// [UNSTABLE](UNSTABLE.md) [DEPRECATED](DEPRECATED.md) Fetches DeBot metadata from blockchain.
    /// Downloads DeBot from blockchain and creates and fetches its metadata.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func fetch(_ payload: TSDKParamsOfFetch) async throws -> TSDKResultOfFetch {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "fetch"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfFetch, TSDKClientError> = .init()
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

    /// [UNSTABLE](UNSTABLE.md) [DEPRECATED](DEPRECATED.md) Executes debot action.
    /// Calls debot engine referenced by debot handle to execute input action.
    /// Calls Debot Browser Callbacks if needed.
    /// # RemarksChain of actions can be executed if input action generates a list of subactions.
    public func execute(_ payload: TSDKParamsOfExecute, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "execute"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// [UNSTABLE](UNSTABLE.md) [DEPRECATED](DEPRECATED.md) Executes debot action.
    /// Calls debot engine referenced by debot handle to execute input action.
    /// Calls Debot Browser Callbacks if needed.
    /// # RemarksChain of actions can be executed if input action generates a list of subactions.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func execute(_ payload: TSDKParamsOfExecute) async throws -> TSDKNoneResult {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "execute"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
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

    /// [UNSTABLE](UNSTABLE.md) [DEPRECATED](DEPRECATED.md) Sends message to Debot.
    /// Used by Debot Browser to send response on Dinterface call or from other Debots.
    public func send(_ payload: TSDKParamsOfSend, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "send"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// [UNSTABLE](UNSTABLE.md) [DEPRECATED](DEPRECATED.md) Sends message to Debot.
    /// Used by Debot Browser to send response on Dinterface call or from other Debots.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func send(_ payload: TSDKParamsOfSend) async throws -> TSDKNoneResult {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "send"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
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

    /// [UNSTABLE](UNSTABLE.md) [DEPRECATED](DEPRECATED.md) Destroys debot handle.
    /// Removes handle from Client Context and drops debot engine referenced by that handle.
    public func remove(_ payload: TSDKParamsOfRemove, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "remove"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// [UNSTABLE](UNSTABLE.md) [DEPRECATED](DEPRECATED.md) Destroys debot handle.
    /// Removes handle from Client Context and drops debot engine referenced by that handle.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func remove(_ payload: TSDKParamsOfRemove) async throws -> TSDKNoneResult {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "remove"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
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

}
