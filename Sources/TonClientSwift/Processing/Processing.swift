public final class TSDKProcessingModule {

    private var binding: TSDKBindingModule
    public let module: String = "processing"

    public init(binding: TSDKBindingModule) {
        self.binding = binding
    }

    /// Sends message to the network
    /// Sends message to the network and returns the last generated shard block of the destination accountbefore the message was sent. It will be required later for message processing.
    public func send_message(_ payload: TSDKParamsOfSendMessage, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfSendMessage, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "send_message"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfSendMessage, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
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
    public func wait_for_transaction(_ payload: TSDKParamsOfWaitForTransaction, _ handler: @escaping (TSDKBindingResponse<TSDKResultOfProcessMessage, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "wait_for_transaction"
        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
            var response: TSDKBindingResponse<TSDKResultOfProcessMessage, TSDKClientError, TSDKDefault> = .init()
            response.update(requestId, params, responseType, finished)
            handler(response)
        })
    }

    /// Creates message, sends it to the network and monitors its processing.
    /// Creates ABI-compatible message,sends it to the network and monitors for the result transaction.
    /// Decodes the output messages' bodies.
    /// If contract's ABI includes "expire" header, thenSDK implements retries in case of unsuccessful message delivery within the expirationtimeout: SDK recreates the message, sends it and processes it again.
    /// The intermediate events, such as `WillFetchFirstBlock`, `WillSend`, `DidSend`,`WillFetchNextBlock`, etc - are switched on/off by `send_events` flagand logged into the supplied callback function.
    /// The retry configuration parameters are defined in the client's `NetworkConfig` and `AbiConfig`.
    /// If contract's ABI does not include "expire" headerthen, if no transaction is found within the network timeout (see config parameter ), exits with error.
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
