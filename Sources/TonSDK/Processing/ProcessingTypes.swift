//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

//ProcessingEvent
public enum TSDKProcessingEventType: String, Decodable {
    case WillFetchFirstBlock = "WillFetchFirstBlock"
    case FetchFirstBlockFailed = "FetchFirstBlockFailed"
    case WillSend = "WillSend"
    case DidSend = "DidSend"
    case SendFailed = "SendFailed"
    case WillFetchNextBlock = "WillFetchNextBlock"
    case FetchNextBlockFailed = "FetchNextBlockFailed"
    case MessageExpired = "MessageExpired"
    case TransactionReceived = "TransactionReceived"
}

public struct TSDKProcessingEvent: Decodable {

    var type: TSDKProcessingEventType
    var error: TSDKClientError?
    var shard_block_id: String?
    var message_id: String?
    var message: String?
    var result: TSDKResultOfProcessMessage?

    public init(type: TSDKProcessingEventType, error: TSDKClientError? = nil, shard_block_id: String? = nil, message_id: String? = nil, message: String? = nil, result: TSDKResultOfProcessMessage? = nil) {
        self.type = type
        self.error = error
        self.shard_block_id = shard_block_id
        self.message_id = message_id
        self.message = message?.base64Encoded() ?? ""
        self.result = result
    }

    public init(type: TSDKProcessingEventType, error: TSDKClientError? = nil, shard_block_id: String? = nil, message_id: String? = nil, messageEncodedBase64: String? = nil, result: TSDKResultOfProcessMessage? = nil) {
        self.type = type
        self.error = error
        self.shard_block_id = shard_block_id
        self.message_id = message_id
        self.message = messageEncodedBase64
        self.result = result
    }
}
///Depends on value of the public struct TSDKfield.
///When public struct TSDKis 'WillFetchFirstBlock'
///When public struct TSDKis 'FetchFirstBlockFailed'
///error: ClientError

///When public struct TSDKis 'WillSend'
///shard_block_id: string
///message_id: string
///message: string

///When public struct TSDKis 'DidSend'
///shard_block_id: string
///message_id: string
///message: string

///When public struct TSDKis 'SendFailed'
///shard_block_id: string
///message_id: string
///message: string
///error: ClientError

///When public struct TSDKis 'WillFetchNextBlock'
///shard_block_id: string
///message_id: string
///message: string

///When public struct TSDKis 'FetchNextBlockFailed'
///shard_block_id: string
///message_id: string
///message: string
///error: ClientError

///When public struct TSDKis 'MessageExpired'
///message_id: string
///message: string
///error: ClientError

///When public struct TSDKis 'TransactionReceived'
///message_id: string – Input message id. Encoded with hex.
///message: string – Input message. BOC encoded with base64.
///result: ResultOfProcessMessage – Results of transaction.

//ResultOfProcessMessage
public struct TSDKResultOfProcessMessage: Decodable {
    var transaction: AnyJSONType
    var out_messages: [AnyJSONType]
    var decoded: TSDKDecodedOutput?
}
///transaction: any – Parsed transaction.
///out_messages: any[] – List of parsed output messages.
///decoded?: DecodedOutput – Optional decoded message bodies according to the optional

//DecodedOutput
public struct TSDKDecodedOutput: Decodable {
    var out_messages: [TSDKDecodedMessageBody?]
    var output: AnyJSONType?
}
///out_messages: DecodedMessageBody?[] – Decoded bodies of the out messages.
///output?: any – Decoded body of the function output message.

//ParamsOfSendMessage
public struct TSDKParamsOfSendMessage: Encodable {
    var message: String
    var abi: TSDKAbiData?
    var send_events: Bool
}
///message: string – Message BOC.
///abi?: Abi – Optional message ABI.
///send_events: boolean – Flag for requesting events sending

//ResultOfSendMessage
public struct TSDKResultOfSendMessage: Decodable {
    var shard_block_id: String
}
///shard_block_id: string – Shard block related to the message dst account before the

//ParamsOfWaitForTransaction
public struct TSDKParamsOfWaitForTransaction: Encodable {

    var abi: TSDKAbiData?
    var message: String
    var shard_block_id: String
    var send_events: Bool

    public init(abi: TSDKAbiData? = nil, message: String, shard_block_id: String, send_events: Bool) {
        self.abi = abi
        self.message = message.base64Encoded() ?? ""
        self.shard_block_id = shard_block_id
        self.send_events = send_events
    }

    public init(abi: TSDKAbiData? = nil, messageEncodedBase64: String, shard_block_id: String, send_events: Bool) {
        self.abi = abi
        self.message = messageEncodedBase64
        self.shard_block_id = shard_block_id
        self.send_events = send_events
    }
}
///abi?: Abi – Optional ABI for decoding transaction results.
///message: string – Message BOC. Encoded with base64.
///shard_block_id: string – Dst account shard block id before the message had been sent.
///send_events: boolean – Flag for requesting events sending

//ParamsOfProcessMessage
public struct TSDKParamsOfProcessMessage: Encodable {
    var message: TSDKMessageSource
    var send_events: Bool
}
///message: MessageSource – Message source.
///send_events: boolean – Flag for requesting events sending
