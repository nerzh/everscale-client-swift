//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

//ExecutionOptions
public struct TSDKExecutionOptions: Codable {
    var blockchain_config: String?
    var block_time: Int?
    var block_lt: Int?
    var transaction_lt: Int?
}
/// blockchain_config?: String – boc with config
/// block_time?: Int – time that is used as transaction time
/// block_lt?: Int – block logical time
/// transaction_lt?: Int – transaction logical time

//ParamsOfRunExecutor
public struct TSDKParamsOfRunExecutor: Encodable {
    var message: String
    var account: String?
    var execution_options: TSDKExecutionOptions?
    var abi: TSDKAbiData?
}
/// message: String – Input message BOC. Must be encoded as base64.
/// account?: String – Account BOC. Must be encoded as base64.
/// execution_options?: ExecutionOptions – Execution options.
/// abi?: Abi – Contract ABI for dedcoding output messages

//ResultOfRunExecutor
public struct TSDKTransactionFees: Codable {
    var in_msg_fwd_fee: UInt64
        var storage_fee: UInt64
        var gas_fee: UInt64
        var out_msgs_fwd_fee: UInt64
        var total_account_fees: UInt64
        var total_output: UInt64
}

public struct TSDKResultOfRunExecutor: Decodable {
    var transaction: AnyJSONType
    var out_messages: [String]
    var decoded: TSDKDecodedOutput?
    var account: String
    var fees: TSDKTransactionFees
}
/// transaction: AnyJSONType – Parsed transaction.
/// out_messages: String[] – List of output messages' BOCs. Encoded as base64
/// decoded?: DecodedOutput – Optional decoded message bodies according to the optional
/// account: String – Updated account state BOC. Encoded as base64
/// fees: TransactionFees – Transaction fees

//ParamsOfRunTvm
public struct TSDKParamsOfRunTvm: Encodable {
    var message: String
    var account: String
    var execution_options: TSDKExecutionOptions?
    var abi: TSDKAbiData?
}
/// message: String – Input message BOC. Must be encoded as base64.
/// account: String – Account BOC. Must be encoded as base64.
/// execution_options?: ExecutionOptions – Execution options.
/// abi?: Abi – Contract ABI for dedcoding output messages

//ResultOfRunTvm
public struct TSDKResultOfRunTvm: Decodable {
    var out_messages: [String]
    var decoded: TSDKDecodedOutput?
    var account: String
}
/// out_messages: String[] – List of output messages' BOCs. Encoded as base64
/// decoded?: DecodedOutput – Optional decoded message bodies according to the optional
/// account: String – Updated account state BOC. Encoded as base64.

//ParamsOfRunGet
public struct TSDKParamsOfRunGet: Encodable {
    var account: String
    var function_name: String
    var input: AnyValue?
    var execution_options: TSDKExecutionOptions?
}
/// account: String – Account BOC in base64
/// function_name: String – Function name
/// input?: AnyJSONType – Input parameters
/// execution_options?: ExecutionOptions

//ResultOfRunGet
public struct TSDKResultOfRunGet: Decodable {
    var output: AnyJSONType
}
/// output: AnyJSONType – Values returned by getmethod on stack
