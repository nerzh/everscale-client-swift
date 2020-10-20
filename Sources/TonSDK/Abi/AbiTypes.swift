//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

//Abi
type Abi = {
    type: 'Serialized'
    value: any
} | {
    type: 'Handle'
    value: number
};
///Depends on value of the type field.
///When type is 'Serialized'
///value: any
///
///When type is 'Handle'
///value: number

//AbiHandle
typealias TSDKAbiHandle = Int
///number

//FunctionHeader
///The ABI function header.
///Includes several hidden function parameters that contract uses for security and replay protection reasons.
///The actual set of header fields depends on the contract's ABI.

type FunctionHeader = {
    expire?: number,
    time?: bigint,
    pubkey?: string
};
///expire?: number – Message expiration time in seconds.
///time?: bigint – Message creation time in milliseconds.
///pubkey?: string – Public key used to sign message. Encoded with hex.

//CallSet
type CallSet = {
    function_name: string,
    header?: FunctionHeader,
    input?: any
};
///function_name: string – Function name.
///header?: FunctionHeader – Function header.
///input?: any – Function input according to ABI.

//DeploySet
type DeploySet = {
    tvc: string,
    workchain_id?: number,
    initial_data?: any
};
///tvc: string – Content of TVC file. Must be encoded with base64.
///workchain_id?: number – Target workchain for destination address. Default is 0.
///initial_data?: any – List of initial values for contract's public variables.

//Signer
type Signer = {
    type: 'None'
} | {
    type: 'External'
    public_key: string
} | {
    type: 'Keys'
    keys: KeyPair
} | {
    type: 'SigningBox'
    handle: SigningBoxHandle
};
///Depends on value of the type field.
///When type is 'None'

///When type is 'External'
///public_key: string

///When type is 'Keys'
///keys: KeyPair

///When type is 'SigningBox'
///handle: SigningBoxHandle

//MessageBodyType
type MessageBodyType = 'Input' | 'Output' | 'InternalOutput' | 'Event';
///One of the following value:
///Input – Message contains the input of the ABI function.
///Output – Message contains the output of the ABI function.
///InternalOutput – Message contains the input of the imported ABI function.
///Event – Message contains the input of the ABI event.

//StateInitSource
type StateInitSource = {
    type: 'Message'
    source: MessageSource
} | {
    type: 'StateInit'
    code: string,
    data: string,
    library?: string
} | {
    type: 'Tvc'
    tvc: string,
    public_key?: string,
    init_params?: StateInitParams
};
///Depends on value of the type field.
///When type is 'Message'
///source: MessageSource

///When type is 'StateInit'
///code: string – Code BOC. Encoded with base64.
///data: string – Data BOC. Encoded with base64.
///library?: string – Library BOC. Encoded with base64.

///When type is 'Tvc'
///tvc: string
///public_key?: string
///init_params?: StateInitParams

//StateInitParams
type StateInitParams = {
    abi: Abi,
    value: any
};
///abi: Abi
///value: any

//MessageSource
type MessageSource = {
    type: 'Encoded'
    message: string,
    abi?: Abi
} | {
    type: 'EncodingParams'
    abi: Abi,
    address?: string,
    deploy_set?: DeploySet,
    call_set?: CallSet,
    signer: Signer,
    processing_try_index?: number
};
///Depends on value of the type field.
///When type is 'Encoded'
///message: string
///abi?: Abi

///When type is 'EncodingParams'
///abi: Abi – Contract ABI.
///address?: string – Contract address.
///deploy_set?: DeploySet – Deploy parameters.
///call_set?: CallSet – Function call parameters.
///signer: Signer – Signing parameters.
///processing_try_index?: number – Processing try index.

//ParamsOfEncodeMessageBody
type ParamsOfEncodeMessageBody = {
    abi: Abi,
    call_set: CallSet,
    is_internal: boolean,
    signer: Signer,
    processing_try_index?: number
};
///abi: Abi – Contract ABI.
///call_set: CallSet – Function call parameters.
///is_internal: boolean – True if internal message body must be encoded.
///signer: Signer – Signing parameters.
///processing_try_index?: number – Processing try index.

//ResultOfEncodeMessageBody
type ResultOfEncodeMessageBody = {
    body: string,
    data_to_sign?: string
};
///body: string – Message body BOC encoded with base64.
///data_to_sign?: string – Optional data to sign. Encoded with base64.

//ParamsOfAttachSignatureToMessageBody
type ParamsOfAttachSignatureToMessageBody = {
    abi: Abi,
    public_key: string,
    message: string,
    signature: string
};
///abi: Abi – Contract ABI
///public_key: string – Public key. Must be encoded with hex.
///message: string – Unsigned message BOC. Must be encoded with base64.
///signature: string – Signature. Must be encoded with hex.

//ResultOfAttachSignatureToMessageBody
type ResultOfAttachSignatureToMessageBody = {
    body: string
};
///body: string

//ParamsOfEncodeMessage
type ParamsOfEncodeMessage = {
    abi: Abi,
    address?: string,
    deploy_set?: DeploySet,
    call_set?: CallSet,
    signer: Signer,
    processing_try_index?: number
};
///abi: Abi – Contract ABI.
///address?: string – Contract address.
///deploy_set?: DeploySet – Deploy parameters.
///call_set?: CallSet – Function call parameters.
///signer: Signer – Signing parameters.
///processing_try_index?: number – Processing try index.

//ResultOfEncodeMessage
type ResultOfEncodeMessage = {
    message: string,
    data_to_sign?: string,
    address: string,
    message_id: string
};
///message: string – Message BOC encoded with base64.
///data_to_sign?: string – Optional data to sign. Encoded with base64.
///address: string – Destination address.
///message_id: string – Message id.

//ParamsOfAttachSignature
type ParamsOfAttachSignature = {
    abi: Abi,
    public_key: string,
    message: string,
    signature: string
};
///abi: Abi – Contract ABI
///public_key: string – Public key. Must be encoded with hex.
///message: string – Unsigned message BOC. Must be encoded with base64.
///signature: string – Signature. Must be encoded with hex.

//ResultOfAttachSignature
type ResultOfAttachSignature = {
    message: string,
    message_id: string
};
///message: string
///message_id: string

//ParamsOfDecodeMessage
type ParamsOfDecodeMessage = {
    abi: Abi,
    message: string
};
///abi: Abi – contract ABI
///message: string – Message BOC

//DecodedMessageBody
type DecodedMessageBody = {
    body_type: MessageBodyType,
    name: string,
    value?: any,
    header?: FunctionHeader
};
///body_type: MessageBodyType – Type of the message body content.
///name: string – Function or event name.
///value?: any – Parameters or result value.
///header?: FunctionHeader – Function header.

//ParamsOfDecodeMessageBody
type ParamsOfDecodeMessageBody = {
    abi: Abi,
    body: string,
    is_internal: boolean
};
///abi: Abi – Contract ABI used to decode.
///body: string – Message body BOC. Must be encoded with base64.
///is_internal: boolean – True if the body belongs to the internal message.

//ParamsOfEncodeAccount
type ParamsOfEncodeAccount = {
    state_init: StateInitSource,
    balance?: bigint,
    last_trans_lt?: bigint,
    last_paid?: number
};
///state_init: StateInitSource – Source of the account state init.
///balance?: bigint – Initial balance.
///last_trans_lt?: bigint – Initial value for the last_trans_lt.
///last_paid?: number – Initial value for the last_paid.

//ResultOfEncodeAccount
type ResultOfEncodeAccount = {
    account: string,
    id: string
};
///account: string – Account BOC. Encoded with base64.
///id: string – Account id. Encoded with hex.
