//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

//ParamsOfParse
public struct TSDKParamsOfParse: Codable {
    public var boc: String

    public init(boc: String) {
        self.boc = boc.base64Encoded() ?? ""
    }

    public init(bocEncodedBase64: String) {
        self.boc = bocEncodedBase64
    }
}
///boc: string – BOC encoded as base64

//ResultOfParse
public struct TSDKResultOfParse: Codable {
    public var parsed: AnyJSONType
}
///parsed: any – JSON containing parsed BOC

//ParamsOfParseShardstate
public struct TSDKParamsOfParseShardstate: Codable {
    public var boc: String
    public var id: String
    public var workchain_id: Int

    public init(boc: String, id: String, workchain_id: Int) {
        self.boc = boc
        self.id = id
        self.workchain_id = workchain_id
    }
}
///boc: string – BOC encoded as base64
///id: string – Shardstate identificator
///workchain_id: number – Workchain shardstate belongs to

//ParamsOfGetBlockchainConfig
public struct TSDKParamsOfGetBlockchainConfig: Codable {
    public var block_boc: String

    public init(block_boc: String) {
        self.block_boc = block_boc.base64Encoded() ?? ""
    }

    public init(block_bocEncodedBase64: String) {
        self.block_boc = block_bocEncodedBase64
    }
}
///block_boc: string – Key block BOC encoded as base64

//ResultOfGetBlockchainConfig
public struct TSDKResultOfGetBlockchainConfig: Codable {
    public var config_boc: String

    public init(config_boc: String) {
        self.config_boc = config_boc.base64Encoded() ?? ""
    }

    public init(config_bocEncodedBase64: String) {
        self.config_boc = config_bocEncodedBase64
    }
}
///config_boc: string – Blockchain config BOC encoded as base64

//ParamsOfGetBocHash
public struct TSDKParamsOfGetBocHash: Codable {
    public var boc: String

    public init(boc: String) {
        self.boc = boc.base64Encoded() ?? ""
    }

    public init(bocEncodedBase64: String) {
        self.boc = bocEncodedBase64
    }
}
///boc: string – BOC encoded as base64

//ResultOfGetBocHash
public struct TSDKResultOfGetBocHash: Codable {
    public var hash: String
}
///hash: string – BOC root hash encoded with hex
