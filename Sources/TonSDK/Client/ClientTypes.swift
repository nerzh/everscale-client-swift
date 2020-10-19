//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

public struct ClientError: Decodable {
    var code: Int
    var message: String
    var data: AnyJSONType
}

public struct ClientConfig: Codable {
    var network: NetworkConfig?
    var crypto: CryptoConfig?
    var abi: AbiConfig?
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
