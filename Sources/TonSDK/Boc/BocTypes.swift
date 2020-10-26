//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

//ParamsOfParse
public struct TSDKParamsOfParse: Encodable {
    var boc: String

    public init(boc: String) {
        self.boc = boc.base64Encoded() ?? ""
    }

    public init(bocEncodedBase64: String) {
        self.boc = bocEncodedBase64
    }
}
///boc: string – BOC encoded as base64

//ResultOfParse
public struct TSDKResultOfParse: Decodable {
    var parsed: AnyJSONType
}
///parsed: any – JSON containing parsed BOC

//ParamsOfGetBlockchainConfig
public struct TSDKParamsOfGetBlockchainConfig: Encodable {
    var block_boc: String

    public init(block_boc: String) {
        self.block_boc = block_boc.base64Encoded() ?? ""
    }

    public init(block_bocEncodedBase64: String) {
        self.block_boc = block_bocEncodedBase64
    }
}
///block_boc: string – Key block BOC encoded as base64

//ResultOfGetBlockchainConfig
public struct TSDKResultOfGetBlockchainConfig: Decodable {
    var config_boc: String

    public init(config_boc: String) {
        self.config_boc = config_boc.base64Encoded() ?? ""
    }

    public init(config_bocEncodedBase64: String) {
        self.config_boc = config_bocEncodedBase64
    }
}
///config_boc: string – Blockchain config BOC encoded as base64
