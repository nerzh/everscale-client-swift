//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

//Abi
public enum TSDKAbiType: String, Codable {
    case Serialized = "Serialized"
    case Handle = "Handle"
}

public struct TSDKAbiData: Encodable {
    var type: TSDKAbiType
    var value: AnyValue
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

public struct TSDKFunctionHeader: Codable, Equatable {
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
    var input: AnyValue?
}
///function_name: String – Function name.
///header?: FunctionHeader – Function header.
///input?: any – Function input according to ABI.

//DeploySet
public struct TSDKDeploySet: Encodable {
    var tvc: String
    var workchain_id: Int?
    var initial_data: AnyValue?

    public init(tvc: Data, workchain_id: Int? = nil, initial_data: AnyValue? = nil) {
        self.tvc = tvc.base64EncodedString()
        self.workchain_id = workchain_id
        self.initial_data = initial_data
    }
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

public struct TSDKStateInitSource: Encodable {

    var type: TSDKStateInitSourceType
    var source: TSDKMessageSource?
    var code: String?
    var data: String?
    var library: String?
    var tvc: String?
    var public_key: String?
    var init_params: TSDKStateInitParams?

    public init(type: TSDKStateInitSourceType, source: TSDKMessageSource? = nil, code: String? = nil, data: String? = nil, library: String? = nil, tvc: Data? = nil, public_key: String? = nil, init_params: TSDKStateInitParams? = nil) {
        self.type = type
        self.source = source
        self.code = code?.base64Encoded()
        self.data = data?.base64Encoded()
        self.library = library?.base64Encoded()
        self.tvc = tvc?.base64EncodedString()
        self.public_key = public_key
        self.init_params = init_params
    }

    public init(type: TSDKStateInitSourceType, source: TSDKMessageSource? = nil, codeEncodedBase64: String? = nil, dataEncodedBase64: String? = nil, libraryEncodedBase64: String? = nil, tvc: Data? = nil, public_key: String? = nil, init_params: TSDKStateInitParams? = nil) {
        self.type = type
        self.source = source
        self.code = codeEncodedBase64
        self.data = dataEncodedBase64
        self.library = libraryEncodedBase64
        self.tvc = tvc?.base64EncodedString()
        self.public_key = public_key
        self.init_params = init_params
    }
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
public struct TSDKStateInitParams: Encodable {
    var abi: TSDKAbiData
    var value: AnyValue
}
///abi: Abi
///value: any

//MessageSource
public enum TSDKMessageSourceType: String, Codable {
    case Encoded = "Encoded"
    case EncodingParams = "EncodingParams"
}

public struct TSDKMessageSource: Encodable {
    var type: TSDKMessageSourceType
    var message: String?
    var abi: TSDKAbiData?
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
public struct TSDKParamsOfEncodeMessageBody: Encodable {
    var abi: TSDKAbiData
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

    public init(body: String, data_to_sign: String? = nil) {
        self.body = body.base64Encoded() ?? ""
        self.data_to_sign = (data_to_sign?.isBase64() ?? true) ? data_to_sign : data_to_sign?.base64Encoded() ?? ""
    }

    public init(bodyEncodedBase64: String, data_to_sign: String? = nil) {
        self.body = bodyEncodedBase64
        self.data_to_sign = (data_to_sign?.isBase64() ?? true) ? data_to_sign : data_to_sign?.base64Encoded() ?? ""
    }
}
///body: String – Message body BOC encoded with base64.
///data_to_sign?: String – Optional data to sign. Encoded with base64.

//ParamsOfAttachSignatureToMessageBody
public struct TSDKParamsOfAttachSignatureToMessageBody: Encodable {

    var abi: TSDKAbiData
    var public_key: String
    var message: String
    var signature: String

    public init(abi: TSDKAbiData, public_key: String, message: String, signature: String) {
        self.abi = abi
        self.public_key = public_key
        self.message = message.base64Encoded() ?? ""
        self.signature = signature
    }

    public init(abi: TSDKAbiData, public_key: String, messageEncodedBase64: String, signature: String) {
        self.abi = abi
        self.public_key = public_key
        self.message = messageEncodedBase64
        self.signature = signature
    }
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
public struct TSDKParamsOfEncodeMessage: Encodable {
    var abi: TSDKAbiData
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

    public init(message: String, data_to_sign: String? = nil, address: String, message_id: String) {
        self.message = message.base64Encoded() ?? ""
        self.data_to_sign = data_to_sign?.base64Encoded()
        self.address = address
        self.message_id = message_id
    }

    public init(messageEncodedBase64: String, data_to_signEncodedBase64: String? = nil, address: String, message_id: String) {
        self.message = messageEncodedBase64
        self.data_to_sign = data_to_signEncodedBase64
        self.address = address
        self.message_id = message_id
    }
}
///message: String – Message BOC encoded with base64.
///data_to_sign?: String – Optional data to sign. Encoded with base64.
///address: String – Destination address.
///message_id: String – Message id.

//ParamsOfAttachSignature
public struct TSDKParamsOfAttachSignature: Encodable {

    var abi: TSDKAbiData
    var public_key: String
    var message: String
    var signature: String

    public init(abi: TSDKAbiData, public_key: String, message: String, signature: String) {
        self.abi = abi
        self.public_key = public_key
        self.message = message.base64Encoded() ?? ""
        self.signature = signature
    }

    public init(abi: TSDKAbiData, public_key: String, messageEncodedBase64: String, signature: String) {
        self.abi = abi
        self.public_key = public_key
        self.message = messageEncodedBase64
        self.signature = signature
    }
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
public struct TSDKParamsOfDecodeMessage: Encodable {
    var abi: TSDKAbiData
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
public struct TSDKParamsOfDecodeMessageBody: Encodable {

    var abi: TSDKAbiData
    var body: String
    var is_internal: Bool

    public init(abi: TSDKAbiData, body: String, is_internal: Bool) {
        self.abi = abi
        self.body = body.base64Encoded() ?? ""
        self.is_internal = is_internal
    }

    public init(abi: TSDKAbiData, bodyEncodedBase64: String, is_internal: Bool) {
        self.abi = abi
        self.body = bodyEncodedBase64
        self.is_internal = is_internal
    }
}
///abi: Abi – Contract ABI used to decode.
///body: String – Message body BOC. Must be encoded with base64.
///is_internal: Bool – True if the body belongs to the internal message.

//ParamsOfEncodeAccount
public struct TSDKParamsOfEncodeAccount: Encodable {
    var state_init: TSDKStateInitSource
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

    public init(account: String, id: String) {
        self.account = account.base64Encoded() ?? ""
        self.id = id
    }

    public init(accountEncodedBase64: String, id: String) {
        self.account = accountEncodedBase64
        self.id = id
    }
}
///account: String – Account BOC. Encoded with base64.
///id: String – Account id. Encoded with hex.
