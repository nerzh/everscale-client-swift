//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

//Abi
public enum TSDKAbiType: String, Codable {
    case Serialized = "Serialized"
    case Handle = "Handle"
}

public struct TSDKAbiData<T: Encodable>: Encodable {
    var type: TSDKAbiType
    var value: AnyEncodable<T>
}
///Depends on value of the public struct TSDKfield.
///When public struct TSDKis 'Serialized'
///value: any
///
///When public struct TSDKis 'Handle'
///value: Int

//AbiHandle
typealias TSDKAbiHandle = Int
///Int

//FunctionHeader
///The ABI function header.
///Includes several hidden function parameters that contract uses for security and replay protection reasons.
///The actual set of header fields depends on the contract's ABI.

public struct TSDKFunctionHeader: Codable {
    var expire: Int?
    var time: Int?
    var pubkey: String?
}
///expire?: Int – Message expiration time in seconds.
///time?: bigint – Message creation time in milliseconds.
///pubkey?: String – Public key used to sign message. Encoded with hex.

//CallSet
public struct TSDKCallSet: Encodable {
    var function_name: String
    var header: TSDKFunctionHeader?
    var input: String?
}
///function_name: String – Function name.
///header?: FunctionHeader – Function header.
///input?: any – Function input according to ABI.

//DeploySet
public struct TSDKDeploySet: Encodable {
    var tvc: String
    var workchain_id: Int?
    var initial_data: String?
}
///tvc: String – Content of TVC file. Must be encoded with base64.
///workchain_id?: Int – Target workchain for destination address. Default is 0.
///initial_data?: any – List of initial values for contract's public variables.

//Signer
public enum TSDKSignerType: String, Codable {
    case None = "None"
    case External = "External"
    case Keys = "Keys"
    case SigningBox = "SigningBox"
}

public struct TSDKSigner: Codable {
    var type: TSDKSignerType
    var public_key: String?
    var keys: TSDKKeyPair?
    var handle: TSDKSigningBoxHandle?
}
///Depends on value of the public struct TSDKfield.
///When public struct TSDKis 'None'

///When public struct TSDKis 'External'
///public_key: String

///When public struct TSDKis 'Keys'
///keys: KeyPair

///When public struct TSDKis 'SigningBox'
///handle: SigningBoxHandle

//MessageBodyType
public enum TSDKMessageBodyType: String, Codable {
    case Input = "Input"
    case Output = "Output"
    case InternalOutput = "InternalOutput"
    case Event = "Event"
}
///One of the following value:
///Input – Message contains the input of the ABI function.
///Output – Message contains the output of the ABI function.
///InternalOutput – Message contains the input of the imported ABI function.
///Event – Message contains the input of the ABI event.

//StateInitSource
public enum TSDKStateInitSourceType: String, Codable {
    case Message = "Message"
    case StateInit = "StateInit"
    case Tvc = "Tvc"
}

public struct TSDKStateInitSource<A: Encodable, B: Encodable>: Encodable {
    var type: TSDKStateInitSourceType
    var source: TSDKMessageSource<A>?
    var code: String?
    var data: String?
    var library: String?
    var tvc: String?
    var public_key: String?
    var init_params: TSDKStateInitParams<A, B>?
}
///Depends on value of the public struct TSDKfield.
///When public struct TSDKis 'Message'
///source: MessageSource

///When public struct TSDKis 'StateInit'
///code: String – Code BOC. Encoded with base64.
///data: String – Data BOC. Encoded with base64.
///library?: String – Library BOC. Encoded with base64.

///When public struct TSDKis 'Tvc'
///tvc: String
///public_key?: String
///init_params?: StateInitParams

//StateInitParams
public struct TSDKStateInitParams<A: Encodable, B: Encodable>: Encodable {
    var abi: TSDKAbiData<A>
    var value: AnyEncodable<B>
}
///abi: Abi
///value: any

//MessageSource
public enum TSDKMessageSourceType: String, Codable {
    case Encoded = "Encoded"
    case EncodingParams = "EncodingParams"
}

public struct TSDKMessageSource<T: Encodable>: Encodable {
    var type: TSDKMessageSourceType
    var message: String?
    var abi: TSDKAbiData<T>?
    var address: String?
    var deploy_set: TSDKDeploySet?
    var call_set: TSDKCallSet?
    var signer: TSDKSigner?
    var processing_try_index: Int?
}
///Depends on value of the public struct TSDKfield.
///When public struct TSDKis 'Encoded'
///message: String
///abi?: Abi

///When public struct TSDKis 'EncodingParams'
///abi: Abi – Contract ABI.
///address?: String – Contract address.
///deploy_set?: DeploySet – Deploy parameters.
///call_set?: CallSet – Function call parameters.
///signer: Signer – Signing parameters.
///processing_try_index?: Int – Processing try index.

//ParamsOfEncodeMessageBody
public struct TSDKParamsOfEncodeMessageBody<T: Encodable>: Encodable {
    var abi: TSDKAbiData<T>
    var call_set: TSDKCallSet
    var is_internal: Bool
    var signer: TSDKSigner
    var processing_try_index: Int?
}
///abi: Abi – Contract ABI.
///call_set: CallSet – Function call parameters.
///is_internal: Bool – True if internal message body must be encoded.
///signer: Signer – Signing parameters.
///processing_try_index?: Int – Processing try index.

//ResultOfEncodeMessageBody
public struct TSDKResultOfEncodeMessageBody: Codable {
    var body: String
    var data_to_sign: String?
}
///body: String – Message body BOC encoded with base64.
///data_to_sign?: String – Optional data to sign. Encoded with base64.

//ParamsOfAttachSignatureToMessageBody
public struct TSDKParamsOfAttachSignatureToMessageBody<T: Encodable>: Encodable {
    var abi: TSDKAbiData<T>
    var public_key: String
    var message: String
    var signature: String
}
///abi: Abi – Contract ABI
///public_key: String – Public key. Must be encoded with hex.
///message: String – Unsigned message BOC. Must be encoded with base64.
///signature: String – Signature. Must be encoded with hex.

//ResultOfAttachSignatureToMessageBody
public struct TSDKResultOfAttachSignatureToMessageBody: Codable {
    var body: String
}
///body: String

//ParamsOfEncodeMessage
public struct TSDKParamsOfEncodeMessage<T: Encodable>: Encodable {
    var abi: TSDKAbiData<T>
    var address: String?
    var deploy_set: TSDKDeploySet?
    var call_set: TSDKCallSet?
    var signer: TSDKSigner
    var processing_try_index: Int?
}
///abi: Abi – Contract ABI.
///address?: String – Contract address.
///deploy_set?: DeploySet – Deploy parameters.
///call_set?: CallSet – Function call parameters.
///signer: Signer – Signing parameters.
///processing_try_index?: Int – Processing try index.

//ResultOfEncodeMessage
public struct TSDKResultOfEncodeMessage: Codable {
    var message: String
    var data_to_sign: String?
    var address: String
    var message_id: String
}
///message: String – Message BOC encoded with base64.
///data_to_sign?: String – Optional data to sign. Encoded with base64.
///address: String – Destination address.
///message_id: String – Message id.

//ParamsOfAttachSignature
public struct TSDKParamsOfAttachSignature<T: Encodable>: Encodable {
    var abi: TSDKAbiData<T>
    var public_key: String
    var message: String
    var signature: String
}
///abi: Abi – Contract ABI
///public_key: String – Public key. Must be encoded with hex.
///message: String – Unsigned message BOC. Must be encoded with base64.
///signature: String – Signature. Must be encoded with hex.

//ResultOfAttachSignature
public struct TSDKResultOfAttachSignature: Codable {
    var message: String
    var message_id: String
}
///message: String
///message_id: String

//ParamsOfDecodeMessage
public struct TSDKParamsOfDecodeMessage<T: Encodable>: Encodable {
    var abi: TSDKAbiData<T>
    var message: String
}
///abi: Abi – contract ABI
///message: String – Message BOC

//DecodedMessageBody
public struct TSDKDecodedMessageBody: Decodable {
    var body_type: TSDKMessageBodyType
    var name: String
    var value: AnyJSONType?
    var header: TSDKFunctionHeader?
}
///body_type: MessageBodyType – Type of the message body content.
///name: String – Function or event name.
///value?: any – Parameters or result value.
///header?: FunctionHeader – Function header.

//ParamsOfDecodeMessageBody
public struct TSDKParamsOfDecodeMessageBody<T: Encodable>: Encodable {
    var abi: TSDKAbiData<T>
    var body: String
    var is_internal: Bool
}
///abi: Abi – Contract ABI used to decode.
///body: String – Message body BOC. Must be encoded with base64.
///is_internal: Bool – True if the body belongs to the internal message.

//ParamsOfEncodeAccount
public struct TSDKParamsOfEncodeAccount<A: Encodable, B: Encodable>: Encodable {
    var state_init: TSDKStateInitSource<A, B>
    var balance: Int?
    var last_trans_lt: Int?
    var last_paid: Int?
}
///state_init: StateInitSource – Source of the account state init.
///balance?: bigint – Initial balance.
///last_trans_lt?: bigint – Initial value for the last_trans_lt.
///last_paid?: Int – Initial value for the last_paid.

//ResultOfEncodeAccount
public struct TSDKResultOfEncodeAccount: Codable {
    var account: String
    var id: String
}
///account: String – Account BOC. Encoded with base64.
///id: String – Account id. Encoded with hex.
