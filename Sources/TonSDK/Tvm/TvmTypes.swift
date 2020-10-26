//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

//ExecutionMode
public enum TSDKExecutionMode: String, Codable {
    case Full = "Full"
    case TvmOnly = "TvmOnly"
}
///One of the following value:
///Full – Executes all phases and performs all checks
///TvmOnly – Executes contract only on TVM (part of compute phase)

//ExecutionOptions
public struct TSDKExecutionOptions: Codable {
    var blockchain_config: String?
    var block_time: Int?
    var block_lt: Int?
    var transaction_lt: Int?
}
///blockchain_config?: string – boc with config
///block_time?: number – time that is used as transaction time
///block_lt?: bigint – block logical time
///transaction_lt?: bigint – transaction logical time

//ParamsOfExecuteMessage
public struct TSDKParamsOfExecuteMessage: Encodable {

    var message: TSDKMessageSource
    var account: String
    var mode: TSDKExecutionMode
    var execution_options: TSDKExecutionOptions?

    public init(message: TSDKMessageSource, account: String, mode: TSDKExecutionMode, execution_options: TSDKExecutionOptions? = nil) {
        self.message = message
        self.account = account.base64Encoded() ?? ""
        self.mode = mode
        self.execution_options = execution_options
    }

    public init(message: TSDKMessageSource, accountEncodedBase64: String, mode: TSDKExecutionMode, execution_options: TSDKExecutionOptions? = nil) {
        self.message = message
        self.account = accountEncodedBase64
        self.mode = mode
        self.execution_options = execution_options
    }
}
///message: MessageSource – Input message.
///account: string – Account BOC. Must be encoded as base64.
///mode: ExecutionMode – Execution mode.
///execution_options?: ExecutionOptions – Execution options.

//ResultOfExecuteMessage
public struct TSDKResultOfExecuteMessage: Decodable {
    var transaction: AnyJSONType?
    var out_messages: [AnyJSONType]
    var decoded: TSDKDecodedOutput?
    var account: AnyJSONType?
}
///transaction?: any – Parsed transaction.
///out_messages: any[] – List of parsed output messages.
///decoded?: DecodedOutput – Optional decoded message bodies according to the optional
///account?: any – JSON with parsed updated account state. Attention! When used in

//ParamsOfExecuteGet
public struct TSDKParamsOfExecuteGet: Encodable {

    var account: String
    var function_name: String
    var input: AnyValue?
    var execution_options: TSDKExecutionOptions?

    public init(accountEncodedBase64: String, function_name: String, input: AnyValue? = nil, execution_options: TSDKExecutionOptions? = nil) {
        self.account = accountEncodedBase64
        self.function_name = function_name
        self.input = input
        self.execution_options = execution_options
    }
}
///account: string
///function_name: string
///input?: any
///execution_options?: ExecutionOptions

//ResultOfExecuteGet
public struct TSDKResultOfExecuteGet: Decodable {
    var output: AnyJSONType
}
///output: any
