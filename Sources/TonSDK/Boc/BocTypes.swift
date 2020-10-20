//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

//ParamsOfParse
public struct TSDKParamsOfParse: Decodable {
    var boc: String
}
///boc: string – BOC encoded as base64

//ResultOfParse
public struct TSDKResultOfParse: Decodable {
    var parsed: AnyJSONType
}
///parsed: any – JSON containing parsed BOC

//ParamsOfGetBlockchainConfig
public struct TSDKParamsOfGetBlockchainConfig: Decodable {
    var block_boc: String
}
///block_boc: string – Key block BOC encoded as base64

//ResultOfGetBlockchainConfig
public struct TSDKResultOfGetBlockchainConfig: Decodable {
    var config_boc: String
}
///config_boc: string – Blockchain config BOC encoded as base64
