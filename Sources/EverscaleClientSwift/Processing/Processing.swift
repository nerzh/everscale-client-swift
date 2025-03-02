public final class TSDKProcessingModule {

    private var binding: TSDKBindingModule
    public let module: String = "processing"

    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }

    /// Starts monitoring for the processing results of the specified messages.
    /// Message monitor performs background monitoring for a message processing resultsfor the specified set of messages.
    /// Message monitor can serve several isolated monitoring queues.
    /// Each monitor queue has a unique application defined identifier (or name) usedto separate several queue's.
    /// There are two important lists inside of the monitoring queue:
    /// - unresolved messages: contains messages requested by the application for monitoring  and not yet resolved;
    /// - resolved results: contains resolved processing results for monitored messages.
    /// Each monitoring queue tracks own unresolved and resolved lists.
    /// Application can add more messages to the monitoring queue at any time.
    /// Message monitor accumulates resolved results.
    /// Application should fetch this results with `fetchNextMonitorResults` function.
    /// When both unresolved and resolved lists becomes empty, monitor stops any background activityand frees all allocated internal memory.
    /// If monitoring queue with specified name already exists then messages will be addedto the unresolved list.
    /// If monitoring queue with specified name does not exist then monitoring queue will be createdwith specified unresolved messages.
    public func monitor_messages(_ payload: TSDKParamsOfMonitorMessages, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "monitor_messages"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Starts monitoring for the processing results of the specified messages.
    /// Message monitor performs background monitoring for a message processing resultsfor the specified set of messages.
    /// Message monitor can serve several isolated monitoring queues.
    /// Each monitor queue has a unique application defined identifier (or name) usedto separate several queue's.
    /// There are two important lists inside of the monitoring queue:
    /// - unresolved messages: contains messages requested by the application for monitoring  and not yet resolved;
    /// - resolved results: contains resolved processing results for monitored messages.
    /// Each monitoring queue tracks own unresolved and resolved lists.
    /// Application can add more messages to the monitoring queue at any time.
    /// Message monitor accumulates resolved results.
    /// Application should fetch this results with `fetchNextMonitorResults` function.
    /// When both unresolved and resolved lists becomes empty, monitor stops any background activityand frees all allocated internal memory.
    /// If monitoring queue with specified name already exists then messages will be addedto the unresolved list.
    /// If monitoring queue with specified name does not exist then monitoring queue will be createdwith specified unresolved messages.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func monitor_messages(_ payload: TSDKParamsOfMonitorMessages) async throws -> TSDKNoneResult {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "monitor_messages"
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

    /// Returns summary information about current state of the specified monitoring queue.
    public func get_monitor_info(_ payload: TSDKParamsOfGetMonitorInfo, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKMonitoringQueueInfo, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "get_monitor_info"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKMonitoringQueueInfo, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Returns summary information about current state of the specified monitoring queue.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func get_monitor_info(_ payload: TSDKParamsOfGetMonitorInfo) async throws -> TSDKMonitoringQueueInfo {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "get_monitor_info"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKMonitoringQueueInfo, TSDKClientError> = .init()
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

    /// Fetches next resolved results from the specified monitoring queue.
    /// Results and waiting options are depends on the `wait` parameter.
    /// All returned results will be removed from the queue's resolved list.
    public func fetch_next_monitor_results(_ payload: TSDKParamsOfFetchNextMonitorResults, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfFetchNextMonitorResults, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "fetch_next_monitor_results"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfFetchNextMonitorResults, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Fetches next resolved results from the specified monitoring queue.
    /// Results and waiting options are depends on the `wait` parameter.
    /// All returned results will be removed from the queue's resolved list.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func fetch_next_monitor_results(_ payload: TSDKParamsOfFetchNextMonitorResults) async throws -> TSDKResultOfFetchNextMonitorResults {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "fetch_next_monitor_results"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfFetchNextMonitorResults, TSDKClientError> = .init()
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

    /// Cancels all background activity and releases all allocated system resources for the specified monitoring queue.
    public func cancel_monitor(_ payload: TSDKParamsOfCancelMonitor, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "cancel_monitor"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Cancels all background activity and releases all allocated system resources for the specified monitoring queue.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func cancel_monitor(_ payload: TSDKParamsOfCancelMonitor) async throws -> TSDKNoneResult {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "cancel_monitor"
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

    /// Sends specified messages to the blockchain.
    public func send_messages(_ payload: TSDKParamsOfSendMessages, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfSendMessages, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "send_messages"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfSendMessages, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Sends specified messages to the blockchain.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func send_messages(_ payload: TSDKParamsOfSendMessages) async throws -> TSDKResultOfSendMessages {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "send_messages"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfSendMessages, TSDKClientError> = .init()
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

    /// Sends message to the network
    /// Sends message to the network and returns the last generated shard block of the destination accountbefore the message was sent. It will be required later for message processing.
    public func send_message(_ payload: TSDKParamsOfSendMessage, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfSendMessage, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "send_message"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfSendMessage, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Sends message to the network
    /// Sends message to the network and returns the last generated shard block of the destination accountbefore the message was sent. It will be required later for message processing.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func send_message(_ payload: TSDKParamsOfSendMessage) async throws -> TSDKResultOfSendMessage {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "send_message"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfSendMessage, TSDKClientError> = .init()
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

    /// Performs monitoring of the network for the result transaction of the external inbound message processing.
    /// `send_events` enables intermediate events, such as `WillFetchNextBlock`,`FetchNextBlockFailed` that may be useful for logging of new shard blocks creationduring message processing.
    /// Note, that presence of the `abi` parameter is critical for ABIcompliant contracts. Message processing uses drasticallydifferent strategy for processing message for contracts whichABI includes "expire" header.
    /// When the ABI header `expire` is present, the processing uses`message expiration` strategy:
    /// - The maximum block gen time is set to  `message_expiration_timeout + transaction_wait_timeout`.
    /// - When maximum block gen time is reached, the processing will  be finished with `MessageExpired` error.
    /// When the ABI header `expire` isn't present or `abi` parameterisn't specified, the processing uses `transaction waiting`strategy:
    /// - The maximum block gen time is set to  `now() + transaction_wait_timeout`.
    /// - If maximum block gen time is reached and no result transaction is found,the processing will exit with an error.
    public func wait_for_transaction(_ payload: TSDKParamsOfWaitForTransaction, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfProcessMessage, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "wait_for_transaction"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfProcessMessage, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Performs monitoring of the network for the result transaction of the external inbound message processing.
    /// `send_events` enables intermediate events, such as `WillFetchNextBlock`,`FetchNextBlockFailed` that may be useful for logging of new shard blocks creationduring message processing.
    /// Note, that presence of the `abi` parameter is critical for ABIcompliant contracts. Message processing uses drasticallydifferent strategy for processing message for contracts whichABI includes "expire" header.
    /// When the ABI header `expire` is present, the processing uses`message expiration` strategy:
    /// - The maximum block gen time is set to  `message_expiration_timeout + transaction_wait_timeout`.
    /// - When maximum block gen time is reached, the processing will  be finished with `MessageExpired` error.
    /// When the ABI header `expire` isn't present or `abi` parameterisn't specified, the processing uses `transaction waiting`strategy:
    /// - The maximum block gen time is set to  `now() + transaction_wait_timeout`.
    /// - If maximum block gen time is reached and no result transaction is found,the processing will exit with an error.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func wait_for_transaction(_ payload: TSDKParamsOfWaitForTransaction) async throws -> TSDKResultOfProcessMessage {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "wait_for_transaction"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfProcessMessage, TSDKClientError> = .init()
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

    /// Creates message, sends it to the network and monitors its processing.
    /// Creates ABI-compatible message,sends it to the network and monitors for the result transaction.
    /// Decodes the output messages' bodies.
    /// If contract's ABI includes "expire" header, thenSDK implements retries in case of unsuccessful message delivery within the expirationtimeout: SDK recreates the message, sends it and processes it again.
    /// The intermediate events, such as `WillFetchFirstBlock`, `WillSend`, `DidSend`,`WillFetchNextBlock`, etc - are switched on/off by `send_events` flagand logged into the supplied callback function.
    /// The retry configuration parameters are defined in the client's `NetworkConfig` and `AbiConfig`.
    /// If contract's ABI does not include "expire" headerthen, if no transaction is found within the network timeout (see config parameter ), exits with error.
    public func process_message(_ payload: TSDKParamsOfProcessMessage, _ handler: @escaping @Sendable (TSDKBindingResponse<TSDKResultOfProcessMessage, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "process_message"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfProcessMessage, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Creates message, sends it to the network and monitors its processing.
    /// Creates ABI-compatible message,sends it to the network and monitors for the result transaction.
    /// Decodes the output messages' bodies.
    /// If contract's ABI includes "expire" header, thenSDK implements retries in case of unsuccessful message delivery within the expirationtimeout: SDK recreates the message, sends it and processes it again.
    /// The intermediate events, such as `WillFetchFirstBlock`, `WillSend`, `DidSend`,`WillFetchNextBlock`, etc - are switched on/off by `send_events` flagand logged into the supplied callback function.
    /// The retry configuration parameters are defined in the client's `NetworkConfig` and `AbiConfig`.
    /// If contract's ABI does not include "expire" headerthen, if no transaction is found within the network timeout (see config parameter ), exits with error.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func process_message(_ payload: TSDKParamsOfProcessMessage) async throws -> TSDKResultOfProcessMessage {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "process_message"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfProcessMessage, TSDKClientError> = .init()
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
