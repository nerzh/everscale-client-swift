public final class TSDKProofsModule {

    private var binding: TSDKBindingModule
    public let module: String = "proofs"

    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }

    /// Proves that a given block's data, which is queried from TONOS API, can be trusted.
    /// This function checks block proofs and compares given data with the proven.
    /// If the given data differs from the proven, the exception will be thrown.
    /// The input param is a single block's JSON object, which was queried from DApp server usingfunctions such as `net.query`, `net.query_collection` or `net.wait_for_collection`.
    /// If block's BOC is not provided in the JSON, it will be queried from DApp server(in this case it is required to provide at least `id` of block).
    /// Please note, that joins (like `signatures` in `Block`) are separated entities and not supported,so function will throw an exception in a case if JSON being checked has such entities in it.
    /// If `cache_in_local_storage` in config is set to `true` (default), downloaded proofs andmaster-chain BOCs are saved into the persistent local storage (e.g. file system for nativeenvironments or browser's IndexedDB for the web); otherwise all the data is cached only inmemory in current client's context and will be lost after destruction of the client.
    /// **Why Proofs are needed**Proofs are needed to ensure that the data downloaded from a DApp server is real blockchaindata. Checking proofs can protect from the malicious DApp server which can potentially providefake data, or also from "Man in the Middle" attacks class.
    /// **What Proofs are**Simply, proof is a list of signatures of validators', which have signed this particular master-block.
    /// The very first validator set's public keys are included in the zero-state. Whe know a root hashof the zero-state, because it is stored in the network configuration file, it is our authorityroot. For proving zero-state it is enough to calculate and compare its root hash.
    /// In each new validator cycle the validator set is changed. The new one is stored in a key-block,which is signed by the validator set, which we already trust, the next validator set will bestored to the new key-block and signed by the current validator set, and so on.
    /// In order to prove any block in the master-chain we need to check, that it has been signed bya trusted validator set. So we need to check all key-blocks' proofs, started from the zero-stateand until the block, which we want to prove. But it can take a lot of time and traffic todownload and prove all key-blocks on a client. For solving this, special trusted blocks are usedin Ever-SDK.
    /// The trusted block is the authority root, as well, as the zero-state. Each trusted block is the`id` (e.g. `root_hash`) of the already proven key-block. There can be plenty of trustedblocks, so there can be a lot of authority roots. The hashes of trusted blocks for MainNetand DevNet are hardcoded in SDK in a separated binary file (trusted_key_blocks.bin) and isbeing updated for each release by using `update_trusted_blocks` utility.
    /// See [update_trusted_blocks](../../../tools/update_trusted_blocks) directory for more info.
    /// In future SDK releases, one will also be able to provide their hashes of trusted blocks forother networks, besides for MainNet and DevNet.
    /// By using trusted key-blocks, in order to prove any block, we can prove chain of key-blocks tothe closest previous trusted key-block, not only to the zero-state.
    /// But shard-blocks don't have proofs on DApp server. In this case, in order to prove any shard-block data, we search for a corresponding master-block, which contains the root hash of thisshard-block, or some shard block which is linked to that block in shard-chain. After provingthis master-block, we traverse through each link and calculate and compare hashes with links,one-by-one. After that we can ensure that this shard-block has also been proven.
    public func proof_block_data(_ payload: TSDKParamsOfProofBlockData, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "proof_block_data"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Proves that a given block's data, which is queried from TONOS API, can be trusted.
    /// This function checks block proofs and compares given data with the proven.
    /// If the given data differs from the proven, the exception will be thrown.
    /// The input param is a single block's JSON object, which was queried from DApp server usingfunctions such as `net.query`, `net.query_collection` or `net.wait_for_collection`.
    /// If block's BOC is not provided in the JSON, it will be queried from DApp server(in this case it is required to provide at least `id` of block).
    /// Please note, that joins (like `signatures` in `Block`) are separated entities and not supported,so function will throw an exception in a case if JSON being checked has such entities in it.
    /// If `cache_in_local_storage` in config is set to `true` (default), downloaded proofs andmaster-chain BOCs are saved into the persistent local storage (e.g. file system for nativeenvironments or browser's IndexedDB for the web); otherwise all the data is cached only inmemory in current client's context and will be lost after destruction of the client.
    /// **Why Proofs are needed**Proofs are needed to ensure that the data downloaded from a DApp server is real blockchaindata. Checking proofs can protect from the malicious DApp server which can potentially providefake data, or also from "Man in the Middle" attacks class.
    /// **What Proofs are**Simply, proof is a list of signatures of validators', which have signed this particular master-block.
    /// The very first validator set's public keys are included in the zero-state. Whe know a root hashof the zero-state, because it is stored in the network configuration file, it is our authorityroot. For proving zero-state it is enough to calculate and compare its root hash.
    /// In each new validator cycle the validator set is changed. The new one is stored in a key-block,which is signed by the validator set, which we already trust, the next validator set will bestored to the new key-block and signed by the current validator set, and so on.
    /// In order to prove any block in the master-chain we need to check, that it has been signed bya trusted validator set. So we need to check all key-blocks' proofs, started from the zero-stateand until the block, which we want to prove. But it can take a lot of time and traffic todownload and prove all key-blocks on a client. For solving this, special trusted blocks are usedin Ever-SDK.
    /// The trusted block is the authority root, as well, as the zero-state. Each trusted block is the`id` (e.g. `root_hash`) of the already proven key-block. There can be plenty of trustedblocks, so there can be a lot of authority roots. The hashes of trusted blocks for MainNetand DevNet are hardcoded in SDK in a separated binary file (trusted_key_blocks.bin) and isbeing updated for each release by using `update_trusted_blocks` utility.
    /// See [update_trusted_blocks](../../../tools/update_trusted_blocks) directory for more info.
    /// In future SDK releases, one will also be able to provide their hashes of trusted blocks forother networks, besides for MainNet and DevNet.
    /// By using trusted key-blocks, in order to prove any block, we can prove chain of key-blocks tothe closest previous trusted key-block, not only to the zero-state.
    /// But shard-blocks don't have proofs on DApp server. In this case, in order to prove any shard-block data, we search for a corresponding master-block, which contains the root hash of thisshard-block, or some shard block which is linked to that block in shard-chain. After provingthis master-block, we traverse through each link and calculate and compare hashes with links,one-by-one. After that we can ensure that this shard-block has also been proven.
    public func proof_block_data(_ payload: TSDKParamsOfProofBlockData) async throws -> TSDKNoneResult {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "proof_block_data"
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

    /// Proves that a given transaction's data, which is queried from TONOS API, can be trusted.
    /// This function requests the corresponding block, checks block proofs, ensures that giventransaction exists in the proven block and compares given data with the proven.
    /// If the given data differs from the proven, the exception will be thrown.
    /// The input parameter is a single transaction's JSON object (see params description),which was queried from TONOS API using functions such as `net.query`, `net.query_collection`or `net.wait_for_collection`.
    /// If transaction's BOC and/or `block_id` are not provided in the JSON, they will be queried fromTONOS API.
    /// Please note, that joins (like `account`, `in_message`, `out_messages`, etc. in `Transaction`entity) are separated entities and not supported, so function will throw an exception in a caseif JSON being checked has such entities in it.
    /// For more information about proofs checking, see description of `proof_block_data` function.
    public func proof_transaction_data(_ payload: TSDKParamsOfProofTransactionData, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "proof_transaction_data"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Proves that a given transaction's data, which is queried from TONOS API, can be trusted.
    /// This function requests the corresponding block, checks block proofs, ensures that giventransaction exists in the proven block and compares given data with the proven.
    /// If the given data differs from the proven, the exception will be thrown.
    /// The input parameter is a single transaction's JSON object (see params description),which was queried from TONOS API using functions such as `net.query`, `net.query_collection`or `net.wait_for_collection`.
    /// If transaction's BOC and/or `block_id` are not provided in the JSON, they will be queried fromTONOS API.
    /// Please note, that joins (like `account`, `in_message`, `out_messages`, etc. in `Transaction`entity) are separated entities and not supported, so function will throw an exception in a caseif JSON being checked has such entities in it.
    /// For more information about proofs checking, see description of `proof_block_data` function.
    public func proof_transaction_data(_ payload: TSDKParamsOfProofTransactionData) async throws -> TSDKNoneResult {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "proof_transaction_data"
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

    /// Proves that a given message's data, which is queried from TONOS API, can be trusted.
    /// This function first proves the corresponding transaction, ensures that the proven transactionrefers to the given message and compares given data with the proven.
    /// If the given data differs from the proven, the exception will be thrown.
    /// The input parameter is a single message's JSON object (see params description),which was queried from TONOS API using functions such as `net.query`, `net.query_collection`or `net.wait_for_collection`.
    /// If message's BOC and/or non-null `src_transaction.id` or `dst_transaction.id` are not providedin the JSON, they will be queried from TONOS API.
    /// Please note, that joins (like `block`, `dst_account`, `dst_transaction`, `src_account`,`src_transaction`, etc. in `Message` entity) are separated entities and not supported,so function will throw an exception in a case if JSON being checked has such entities in it.
    /// For more information about proofs checking, see description of `proof_block_data` function.
    public func proof_message_data(_ payload: TSDKParamsOfProofMessageData, _ handler: @escaping (TSDKBindingResponse<TSDKNoneResult, TSDKClientError>) throws -> Void
    ) throws {
        let method: String = "proof_message_data"
        try binding.requestLibraryAsync(methodName(module, method), payload) { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKNoneResult, TSDKClientError> = .init()
            response.update(requestId, params, responseType, finished)
            try handler(response)
        }
    }

    /// Proves that a given message's data, which is queried from TONOS API, can be trusted.
    /// This function first proves the corresponding transaction, ensures that the proven transactionrefers to the given message and compares given data with the proven.
    /// If the given data differs from the proven, the exception will be thrown.
    /// The input parameter is a single message's JSON object (see params description),which was queried from TONOS API using functions such as `net.query`, `net.query_collection`or `net.wait_for_collection`.
    /// If message's BOC and/or non-null `src_transaction.id` or `dst_transaction.id` are not providedin the JSON, they will be queried from TONOS API.
    /// Please note, that joins (like `block`, `dst_account`, `dst_transaction`, `src_account`,`src_transaction`, etc. in `Message` entity) are separated entities and not supported,so function will throw an exception in a case if JSON being checked has such entities in it.
    /// For more information about proofs checking, see description of `proof_block_data` function.
    public func proof_message_data(_ payload: TSDKParamsOfProofMessageData) async throws -> TSDKNoneResult {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let method: String = "proof_message_data"
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
