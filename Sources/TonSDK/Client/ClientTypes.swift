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


public struct TSDKClientError: Decodable {
    public var code: Int
    public var message: String
    public var data: AnyJSONType
}

public struct TSDKClientConfig: Encodable {
    public var network: TSDKNetworkConfig?
    public var crypto: TSDKCryptoConfig?
    public var abi: TSDKAbiConfig?

    public init() {}
}

public struct TSDKNetworkConfig: Encodable {
    var server_address: String
    var message_retries_count: Int?
    var message_processing_timeout: Int?
    var wait_for_timeout: Int?
    var out_of_sync_threshold: Int?
    var access_key: String?

    public init(server_address: String, message_retries_count: Int? = nil, message_processing_timeout: Int? = nil, wait_for_timeout: Int? = nil, out_of_sync_threshold: Int? = nil, access_key: String? = nil) {
        self.server_address = server_address
        self.message_retries_count = message_retries_count
        self.message_processing_timeout = message_processing_timeout
        self.wait_for_timeout = wait_for_timeout
        self.out_of_sync_threshold = out_of_sync_threshold
        self.access_key = access_key
    }
}

public struct TSDKCryptoConfig: Codable {
    var fish_param: String?
}

public struct TSDKAbiConfig: Codable {
    var message_expiration_timeout: Int?
    var message_expiration_timeout_grow_factor: Int?
}

public struct TSDKResultOfGetApiReference: Decodable {
    var api: AnyJSONType
}

public struct TSDKResultOfVersion: Codable {
    var version: String
}
