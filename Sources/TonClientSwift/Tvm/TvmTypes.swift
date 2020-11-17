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

public enum TSDKAccountForExecutorType: String, Codable {
    case None = "None"
    case Uninit = "Uninit"
    case Account = "Account"
}

//AccountForExecutor
public struct TSDKAccountForExecutor: Codable {

    public var type: TSDKAccountForExecutorType
    public var boc: String?
    public var unlimited_balance: Bool?

    public init(type: TSDKAccountForExecutorType, boc: String, unlimited_balance: Bool? = nil) {
        self.type = type
        self.boc = boc.base64Encoded() ?? ""
        self.unlimited_balance = unlimited_balance
    }

    public init(type: TSDKAccountForExecutorType, bocEncodedBase64: String, unlimited_balance: Bool? = nil) {
        self.type = type
        self.boc = bocEncodedBase64
        self.unlimited_balance = unlimited_balance
    }

    public init(type: TSDKAccountForExecutorType) {
        self.type = type
    }
}
///Depends on value of the type field.
///When type is 'None'
///Non-existing account to run a creation internal message. Should be used with skip_transaction_check = true if the message has no deploy data since transaction on the unitialized account are always aborted

///When type is 'Uninit'
///Emulate unitialized account to run deploy message

///When type is 'Account'
///Account state to run message

///boc: string – Account BOC. Encoded as base64.
///unlimited_balance?: boolean – Flag for running account with the unlimited balance. Can be used to calculate transaction fees without balance check

//ParamsOfRunExecutor
public struct TSDKParamsOfRunExecutor: Encodable {

    public var message: String
    public var account: TSDKAccountForExecutor
    public var execution_options: TSDKExecutionOptions?
    public var abi: TSDKAbi?
    public var skip_transaction_check: Bool?

    public init(message: String, account: TSDKAccountForExecutor, execution_options: TSDKExecutionOptions? = nil, abi: TSDKAbi? = nil, skip_transaction_check: Bool?) {
        self.message = message.base64Encoded() ?? ""
        self.account = account
        self.execution_options = execution_options
        self.abi = abi
        self.skip_transaction_check = skip_transaction_check
    }

    public init(messageEncodedBsae64: String, account: TSDKAccountForExecutor, execution_options: TSDKExecutionOptions? = nil, abi: TSDKAbi? = nil, skip_transaction_check: Bool?) {
        self.message = messageEncodedBsae64
        self.account = account
        self.execution_options = execution_options
        self.abi = abi
        self.skip_transaction_check = skip_transaction_check
    }
}
/// message: String – Input message BOC. Must be encoded as base64.
/// account?: String – Account BOC. Must be encoded as base64.
/// execution_options?: ExecutionOptions – Execution options.
/// abi?: Abi – Contract ABI for decoding output messages
/// skip_transaction_check?: boolean – Skip transaction check flag

//ResultOfRunExecutor
public struct TSDKTransactionFees: Codable {
    public var in_msg_fwd_fee: Int
    public var storage_fee: Int
    public var gas_fee: Int
    public var out_msgs_fwd_fee: Int
    public var total_account_fees: Int
    public var total_output: Int
}
///in_msg_fwd_fee: bigint
///storage_fee: bigint
///gas_fee: bigint
///out_msgs_fwd_fee: bigint
///total_account_fees: bigint
///total_output: bigint

public struct TSDKResultOfRunExecutor: Decodable {

    public var transaction: AnyJSONType
    public var out_messages: [String]
    public var decoded: TSDKDecodedOutput?
    public var account: String
    public var fees: TSDKTransactionFees

    public init(transaction: AnyJSONType, out_messages: [String], decoded: TSDKDecodedOutput? = nil, account: String, fees: TSDKTransactionFees) {
        self.transaction = transaction
        self.out_messages = out_messages.map { $0.base64Encoded() ?? "" }
        self.decoded = decoded
        self.account = account.base64Encoded() ?? ""
        self.fees = fees
    }

    public init(transactionEncodedBase64: AnyJSONType,
                out_messages: [String],
                decoded: TSDKDecodedOutput? = nil,
                accountEncodedBase64: String,
                fees: TSDKTransactionFees
    ) {
        self.transaction = transactionEncodedBase64
        self.out_messages = out_messages
        self.decoded = decoded
        self.account = accountEncodedBase64
        self.fees = fees
    }
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
    var abi: TSDKAbi?

    public init(message: String, account: String, execution_options: TSDKExecutionOptions? = nil, abi: TSDKAbi? = nil) {
        self.message = message.base64Encoded() ?? ""
        self.account = account.base64Encoded() ?? ""
        self.execution_options = execution_options
        self.abi = abi
    }

    public init(messageEncodedBase64: String, accountEncodedBase64: String, execution_options: TSDKExecutionOptions? = nil, abi: TSDKAbi? = nil) {
        self.message = messageEncodedBase64
        self.account = accountEncodedBase64
        self.execution_options = execution_options
        self.abi = abi
    }
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

    public init(out_messages: [String], decoded: TSDKDecodedOutput? = nil, account: String) {
        self.out_messages = out_messages.map { $0.base64Encoded() ?? "" }
        self.decoded = decoded
        self.account = account.base64Encoded() ?? ""
    }

    public init(out_messagesEncodedBase64: [String], decoded: TSDKDecodedOutput? = nil, accountEncodedBase64: String) {
        self.out_messages = out_messagesEncodedBase64
        self.decoded = decoded
        self.account = accountEncodedBase64
    }
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

    public init(account: String, function_name: String, input: AnyValue? = nil, execution_options: TSDKExecutionOptions? = nil) {
        self.account = account.base64Encoded() ?? ""
        self.function_name = function_name
        self.input = input
        self.execution_options = execution_options
    }

    public init(accountEncodedBase64: String, function_name: String, input: AnyValue? = nil, execution_options: TSDKExecutionOptions? = nil) {
        self.account = accountEncodedBase64
        self.function_name = function_name
        self.input = input
        self.execution_options = execution_options
    }
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
