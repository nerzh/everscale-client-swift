//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

public struct TSDKDefault: Decodable {
    public var result: AnyJSONType?
    public var error: AnyJSONType?
    public var data: AnyJSONType?
    public var message: AnyJSONType?
}


public struct ClientError: Decodable {
    public var code: Int
    public var message: String
    public var data: AnyJSONType
}

public struct ClientConfig: Codable {
    public var network: NetworkConfig?
    public var crypto: CryptoConfig?
    public var abi: AbiConfig?
}

public struct NetworkConfig: Codable {
    var server_address: String
    var message_retries_count: Int?
    var message_processing_timeout: Int?
    var wait_for_timeout: Int?
    var out_of_sync_threshold: Int?
    var access_key: String
}

public struct CryptoConfig: Codable {
    var fish_param: String?
}

public struct AbiConfig: Codable {
    var message_expiration_timeout: Int?
    var message_expiration_timeout_grow_factor: Int?
}

public struct ResultOfGetApiReference: Decodable {
    var api: AnyJSONType
}

public struct ResultOfVersion: Codable {
    var version: String
}
