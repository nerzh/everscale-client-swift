public final class TSDKTvmModule {

    private var binding: TSDKBindingModule
    public let module: String = "tvm"

    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }

    /// Emulates all the phases of contract execution locally
    /// Performs all the phases of contract execution on Transaction Executor -the same component that is used on Validator Nodes.
    /// Can be used for contract debugging, to find out the reason why a message was not delivered successfully.
    /// Validators throw away the failed external inbound messages (if they failed before `ACCEPT`) in the real network.
    /// This is why these messages are impossible to debug in the real network.
    /// With the help of run_executor you can do that. In fact, `process_message` functionperforms local check with `run_executor` if there was no transaction as a result of processingand returns the error, if there is one.
    /// Another use case to use `run_executor` is to estimate fees for message execution.
    /// Set  `AccountForExecutor::Account.unlimited_balance`to `true` so that emulation will not depend on the actual balance.
    /// This may be needed to calculate deploy fees for an account that does not exist yet.
    /// JSON with fees is in `fees` field of the result.
    /// One more use case - you can produce the sequence of operations,thus emulating the sequential contract calls locally.
    /// And so on.
    /// Transaction executor requires account BOC (bag of cells) as a parameter.
    /// To get the account BOC - use `net.query` method to download it from GraphQL API(field `boc` of `account`) or generate it with `abi.encode_account` method.
    /// Also it requires message BOC. To get the message BOC - use `abi.encode_message` or `abi.encode_internal_message`.
    /// If you need this emulation to be as precise as possible (for instance - emulate transactionwith particular lt in particular block or use particular blockchain config,downloaded from a particular key block - then specify `execution_options` parameter.
    /// If you need to see the aborted transaction as a result, not as an error, set `skip_transaction_check` to `true`.
    public func run_executor(_ payload: TSDKParamsOfRunExecutor, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfRunExecutor, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "run_executor"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfRunExecutor, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Emulates all the phases of contract execution locally
    /// Performs all the phases of contract execution on Transaction Executor -the same component that is used on Validator Nodes.
    /// Can be used for contract debugging, to find out the reason why a message was not delivered successfully.
    /// Validators throw away the failed external inbound messages (if they failed before `ACCEPT`) in the real network.
    /// This is why these messages are impossible to debug in the real network.
    /// With the help of run_executor you can do that. In fact, `process_message` functionperforms local check with `run_executor` if there was no transaction as a result of processingand returns the error, if there is one.
    /// Another use case to use `run_executor` is to estimate fees for message execution.
    /// Set  `AccountForExecutor::Account.unlimited_balance`to `true` so that emulation will not depend on the actual balance.
    /// This may be needed to calculate deploy fees for an account that does not exist yet.
    /// JSON with fees is in `fees` field of the result.
    /// One more use case - you can produce the sequence of operations,thus emulating the sequential contract calls locally.
    /// And so on.
    /// Transaction executor requires account BOC (bag of cells) as a parameter.
    /// To get the account BOC - use `net.query` method to download it from GraphQL API(field `boc` of `account`) or generate it with `abi.encode_account` method.
    /// Also it requires message BOC. To get the message BOC - use `abi.encode_message` or `abi.encode_internal_message`.
    /// If you need this emulation to be as precise as possible (for instance - emulate transactionwith particular lt in particular block or use particular blockchain config,downloaded from a particular key block - then specify `execution_options` parameter.
    /// If you need to see the aborted transaction as a result, not as an error, set `skip_transaction_check` to `true`.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func run_executor(_ payload: TSDKParamsOfRunExecutor) async throws -> TSDKResultOfRunExecutor {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "run_executor"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfRunExecutor, TSDKClientError> = .init()
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

    /// Executes get-methods of ABI-compatible contracts
    /// Performs only a part of compute phase of transaction executionthat is used to run get-methods of ABI-compatible contracts.
    /// If you try to run get-methods with `run_executor` you will get an error, because it checks ACCEPT and exitsif there is none, which is actually true for get-methods.
    ///  To get the account BOC (bag of cells) - use `net.query` method to download it from GraphQL API(field `boc` of `account`) or generate it with `abi.encode_account method`.
    /// To get the message BOC - use `abi.encode_message` or prepare it any other way, for instance, with FIFT script.
    /// Attention! Updated account state is produces as well, but only`account_state.storage.state.data`  part of the BOC is updated.
    public func run_tvm(_ payload: TSDKParamsOfRunTvm, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfRunTvm, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "run_tvm"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfRunTvm, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Executes get-methods of ABI-compatible contracts
    /// Performs only a part of compute phase of transaction executionthat is used to run get-methods of ABI-compatible contracts.
    /// If you try to run get-methods with `run_executor` you will get an error, because it checks ACCEPT and exitsif there is none, which is actually true for get-methods.
    ///  To get the account BOC (bag of cells) - use `net.query` method to download it from GraphQL API(field `boc` of `account`) or generate it with `abi.encode_account method`.
    /// To get the message BOC - use `abi.encode_message` or prepare it any other way, for instance, with FIFT script.
    /// Attention! Updated account state is produces as well, but only`account_state.storage.state.data`  part of the BOC is updated.
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func run_tvm(_ payload: TSDKParamsOfRunTvm) async throws -> TSDKResultOfRunTvm {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "run_tvm"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfRunTvm, TSDKClientError> = .init()
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

    /// Executes a get-method of FIFT contract
    /// Executes a get-method of FIFT contract that fulfills the smc-guidelines https://test.ton.org/smc-guidelines.txtand returns the result data from TVM's stack
    public func run_get(_ payload: TSDKParamsOfRunGet, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfRunGet, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "run_get"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfRunGet, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Executes a get-method of FIFT contract
    /// Executes a get-method of FIFT contract that fulfills the smc-guidelines https://test.ton.org/smc-guidelines.txtand returns the result data from TVM's stack
    @available(iOS 13, *)
    @available(macOS 12, *)
    public func run_get(_ payload: TSDKParamsOfRunGet) async throws -> TSDKResultOfRunGet {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "run_get"
                try binding.requestLibraryAsyncAwait(methodName(module, method), payload) { (requestId, params, responseType, finished) in
                    var response: TSDKBindingResponse<TSDKResultOfRunGet, TSDKClientError> = .init()
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
