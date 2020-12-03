//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

public struct TSDKDefault: Decodable {
    public var result: AnyJSONType?
    public var error: AnyJSONType?
    public var data: AnyJSONType?
    public var message: AnyJSONType?

    public init(result: AnyJSONType? = nil, error: AnyJSONType? = nil, data: AnyJSONType? = nil, message: AnyJSONType? = nil) {
        self.result = result
        self.error = error
        self.data = data
        self.message = message
    }
}

public struct TSDKClientError: Decodable {
    public var code: Int
    public var message: String
    public var data: AnyJSONType

    public init(code: Int, message: String, data: AnyJSONType) {
        self.code = code
        self.message = message
        self.data = data
    }
}

public struct TSDKClientConfig: Encodable {
    public var network: TSDKNetworkConfig?
    public var crypto: TSDKCryptoConfig?
    public var abi: TSDKAbiConfig?

    public init() {}

    public init(network: TSDKNetworkConfig? = nil, crypto: TSDKCryptoConfig? = nil, abi: TSDKAbiConfig? = nil) {
        self.network = network
        self.crypto = crypto
        self.abi = abi
    }
}

public struct TSDKNetworkConfig: Encodable {
    public var server_address: String
    public var message_retries_count: Int?
    public var message_processing_timeout: Int?
    public var wait_for_timeout: Int?
    public var out_of_sync_threshold: Int?
    public var access_key: String?

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
    public var mnemonic_dictionary: Int?
    public var mnemonic_word_count: Int?
    public var hdkey_derivation_path: String?
    public var hdkey_compliant: Bool?

    public init(mnemonic_dictionary: Int? = nil, mnemonic_word_count: Int? = nil, hdkey_derivation_path: String? = nil, hdkey_compliant: Bool? = nil) {
        self.mnemonic_dictionary = mnemonic_dictionary
        self.mnemonic_word_count = mnemonic_word_count
        self.hdkey_derivation_path = hdkey_derivation_path
        self.hdkey_compliant = hdkey_compliant
    }
}
///mnemonic_dictionary?: number
///mnemonic_word_count?: number
///hdkey_derivation_path?: string
///hdkey_compliant?: boolean

public struct TSDKAbiConfig: Codable {
    public var workchain: Int?
    public var message_expiration_timeout: Int?
    public var message_expiration_timeout_grow_factor: Int?

    public init(workchain: Int? = nil, message_expiration_timeout: Int? = nil, message_expiration_timeout_grow_factor: Int? = nil) {
        self.workchain = workchain
        self.message_expiration_timeout = message_expiration_timeout
        self.message_expiration_timeout_grow_factor = message_expiration_timeout_grow_factor
    }
}
///workchain?: number
///message_expiration_timeout?: number
///message_expiration_timeout_grow_factor?: number

//BuildInfoDependency
public struct TSDKBuildInfoDependency: Codable {
    public init(name: String, git_commit: String) {
        self.name = name
        self.git_commit = git_commit
    }

    public var name: String
    public var git_commit: String
}
///name: string – Dependency name. Usually it is a crate name.
///git_commit: string – Git commit hash of the related repository.

public struct TSDKResultOfGetApiReference: Decodable {
    public var api: AnyJSONType
}
///api: API

public struct TSDKResultOfVersion: Codable {
    public var version: String
}
///version: string – Core Library version

//ResultOfBuildInfo
public struct TSDKResultOfBuildInfo: Codable {
    public var build_number: Int
    public var dependencies: [TSDKBuildInfoDependency]
}
///build_number: number – Build number assigned to this build by the CI.
///dependencies: BuildInfoDependency[] – Fingerprint of the most important dependencies.
