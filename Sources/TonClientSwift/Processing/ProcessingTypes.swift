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
}

public struct TSDKProcessingEvent: Decodable {
    public var type: TSDKProcessingEventType
    public var error: TSDKClientError?
    public var shard_block_id: String?
    public var message_id: String?
    public var message: String?

    public init(type: TSDKProcessingEventType, error: TSDKClientError? = nil, shard_block_id: String? = nil, message_id: String? = nil, message: String? = nil) {
        self.type = type
        self.error = error
        self.shard_block_id = shard_block_id
        self.message_id = message_id
        self.message = message?.base64Encoded() ?? ""
    }

    public init(type: TSDKProcessingEventType, error: TSDKClientError? = nil, shard_block_id: String? = nil, message_id: String? = nil, messageEncodedBase64: String? = nil) {
        self.type = type
        self.error = error
        self.shard_block_id = shard_block_id
        self.message_id = message_id
        self.message = messageEncodedBase64
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

//ResultOfProcessMessage
public struct TSDKResultOfProcessMessage: Decodable {
    public var transaction: AnyJSONType
    public var out_messages: [String]
    public var decoded: TSDKDecodedOutput?
    public var fees: TSDKTransactionFees
}
///transaction: any – Parsed transaction.
///out_messages: string[] – List of output messages' BOCs. Encoded as base64
///decoded?: DecodedOutput – Optional decoded message bodies according to the optional
///fees: TransactionFees – Transaction fees

//DecodedOutput
public struct TSDKDecodedOutput: Decodable, Equatable {
    public var out_messages: [TSDKDecodedMessageBody?]
    public var output: AnyJSONType?

    public static func == (lhs: TSDKDecodedOutput, rhs: TSDKDecodedOutput) -> Bool {
        lhs.out_messages == rhs.out_messages &&
            lhs.output == rhs.output
    }
}
///out_messages: DecodedMessageBody?[] – Decoded bodies of the out messages.
///output?: any – Decoded body of the function output message.

//ParamsOfSendMessage
public struct TSDKParamsOfSendMessage: Encodable {
    public var message: String
    public var abi: TSDKAbi?
    public var send_events: Bool

    public init(message: String, abi: TSDKAbi? = nil, send_events: Bool) {
        self.message = message
        self.abi = abi
        self.send_events = send_events
    }
}
///message: string – Message BOC.
///abi?: Abi – Optional message ABI.
///send_events: boolean – Flag for requesting events sending

//ResultOfSendMessage
public struct TSDKResultOfSendMessage: Decodable {
    public var shard_block_id: String
}
///shard_block_id: string – Shard block related to the message dst account before the

//ParamsOfWaitForTransaction
public struct TSDKParamsOfWaitForTransaction: Encodable {
    public var abi: TSDKAbi?
    public var message: String
    public var shard_block_id: String
    public var send_events: Bool

    public init(abi: TSDKAbi? = nil, message: String, shard_block_id: String, send_events: Bool) {
        self.abi = abi
        self.message = message.base64Encoded() ?? ""
        self.shard_block_id = shard_block_id
        self.send_events = send_events
    }

    public init(abi: TSDKAbi? = nil, messageEncodedBase64: String, shard_block_id: String, send_events: Bool) {
        self.abi = abi
        self.message = messageEncodedBase64
        self.shard_block_id = shard_block_id
        self.send_events = send_events
    }
}
///abi?: Abi – Optional ABI for decoding transaction results.
///  If it is specified, then the output messages' bodies will be
///  decoded according to this ABI.
///  The abi_decoded result field will be filled out.
///message: string – Message BOC. Encoded with base64.
///shard_block_id: string – The last generated block id of the destination account shard before the message was sent. You must provide the same value as the send_message has returned.
///send_events: boolean – Flag that enables/disables intermediate events

//ParamsOfProcessMessage
public struct TSDKParamsOfProcessMessage: Encodable {
    public var message_encode_params: TSDKParamsOfEncodeMessage
    public var send_events: Bool

    public init(message_encode_params: TSDKParamsOfEncodeMessage, send_events: Bool) {
        self.message_encode_params = message_encode_params
        self.send_events = send_events
    }
}
///message_encode_params: ParamsOfEncodeMessage – Message encode parameters
///send_events: boolean – Flag for requesting events sending
