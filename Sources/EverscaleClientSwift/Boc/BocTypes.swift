import Foundation
import SwiftExtensionsPack


public enum TSDKBocCacheTypeEnumTypes: String, Codable {
    case Pinned = "Pinned"
    case Unpinned = "Unpinned"
}

public enum TSDKBuilderOpEnumTypes: String, Codable {
    case Integer = "Integer"
    case BitString = "BitString"
    case Cell = "Cell"
    case CellBoc = "CellBoc"
    case Address = "Address"
}

public enum TSDKTvcEnumTypes: String, Codable {
    case V1 = "V1"
}

public enum TSDKBocErrorCode: Int, Codable {
    case InvalidBoc = 201
    case SerializationError = 202
    case InappropriateBlock = 203
    case MissingSourceBoc = 204
    case InsufficientCacheSize = 205
    case BocRefNotFound = 206
    case InvalidBocRef = 207
}

public struct TSDKBocCacheType: Codable, @unchecked Sendable {
    public var type: TSDKBocCacheTypeEnumTypes
    public var pin: String?

    public init(type: TSDKBocCacheTypeEnumTypes, pin: String? = nil) {
        self.type = type
        self.pin = pin
    }
}

public struct TSDKBuilderOp: Codable, @unchecked Sendable {
    public var type: TSDKBuilderOpEnumTypes
    /// Bit size of the value.
    public var size: UInt32?
    /// Value: - `Number` containing integer number.
    /// e.g. `123`, `-123`. - Decimal string. e.g. `"123"`, `"-123"`.
    /// - `0x` prefixed hexadecimal string.
    ///   e.g `0x123`, `0X123`, `-0x123`.
    public var value: AnyValue?
    /// Nested cell builder.
    public var builder: [TSDKBuilderOp]?
    /// Nested cell BOC encoded with `base64` or BOC cache key.
    public var boc: String?
    /// Address in a common `workchain:account` or base64 format.
    public var address: String?

    public init(type: TSDKBuilderOpEnumTypes, size: UInt32? = nil, value: AnyValue? = nil, builder: [TSDKBuilderOp]? = nil, boc: String? = nil, address: String? = nil) {
        self.type = type
        self.size = size
        self.value = value
        self.builder = builder
        self.boc = boc
        self.address = address
    }
}

/// Cell builder operation.
public struct TSDKTvc: Codable, @unchecked Sendable {
    public var type: TSDKTvcEnumTypes
    public var value: TSDKTvcV1?

    public init(type: TSDKTvcEnumTypes, value: TSDKTvcV1? = nil) {
        self.type = type
        self.value = value
    }
}

public struct TSDKTvcV1: Codable, @unchecked Sendable {
    public var code: String?
    public var description: String?

    public init(code: String? = nil, description: String? = nil) {
        self.code = code
        self.description = description
    }
}

public struct TSDKParamsOfDecodeTvc: Codable, @unchecked Sendable {
    /// Contract TVC BOC encoded as base64 or BOC handle
    public var tvc: String

    public init(tvc: String) {
        self.tvc = tvc
    }
}

public struct TSDKResultOfDecodeTvc: Codable, @unchecked Sendable {
    /// Decoded TVC
    public var tvc: TSDKTvc

    public init(tvc: TSDKTvc) {
        self.tvc = tvc
    }
}

public struct TSDKParamsOfParse: Codable, @unchecked Sendable {
    /// BOC encoded as base64
    public var boc: String

    public init(boc: String) {
        self.boc = boc
    }
}

public struct TSDKResultOfParse: Codable, @unchecked Sendable {
    /// JSON containing parsed BOC
    public var parsed: AnyValue

    public init(parsed: AnyValue) {
        self.parsed = parsed
    }
}

public struct TSDKParamsOfParseShardstate: Codable, @unchecked Sendable {
    /// BOC encoded as base64
    public var boc: String
    /// Shardstate identifier
    public var id: String
    /// Workchain shardstate belongs to
    public var workchain_id: Int32

    public init(boc: String, id: String, workchain_id: Int32) {
        self.boc = boc
        self.id = id
        self.workchain_id = workchain_id
    }
}

public struct TSDKParamsOfGetBlockchainConfig: Codable, @unchecked Sendable {
    /// Key block BOC or zerostate BOC encoded as base64
    public var block_boc: String

    public init(block_boc: String) {
        self.block_boc = block_boc
    }
}

public struct TSDKResultOfGetBlockchainConfig: Codable, @unchecked Sendable {
    /// Blockchain config BOC encoded as base64
    public var config_boc: String

    public init(config_boc: String) {
        self.config_boc = config_boc
    }
}

public struct TSDKParamsOfGetBocHash: Codable, @unchecked Sendable {
    /// BOC encoded as base64 or BOC handle
    public var boc: String

    public init(boc: String) {
        self.boc = boc
    }
}

public struct TSDKResultOfGetBocHash: Codable, @unchecked Sendable {
    /// BOC root hash encoded with hex
    public var hash: String

    public init(hash: String) {
        self.hash = hash
    }
}

public struct TSDKParamsOfGetBocDepth: Codable, @unchecked Sendable {
    /// BOC encoded as base64 or BOC handle
    public var boc: String

    public init(boc: String) {
        self.boc = boc
    }
}

public struct TSDKResultOfGetBocDepth: Codable, @unchecked Sendable {
    /// BOC root cell depth
    public var depth: UInt32

    public init(depth: UInt32) {
        self.depth = depth
    }
}

public struct TSDKParamsOfGetCodeFromTvc: Codable, @unchecked Sendable {
    /// Contract TVC image or image BOC handle
    public var tvc: String

    public init(tvc: String) {
        self.tvc = tvc
    }
}

public struct TSDKResultOfGetCodeFromTvc: Codable, @unchecked Sendable {
    /// Contract code encoded as base64
    public var code: String

    public init(code: String) {
        self.code = code
    }
}

public struct TSDKParamsOfBocCacheGet: Codable, @unchecked Sendable {
    /// Reference to the cached BOC
    public var boc_ref: String

    public init(boc_ref: String) {
        self.boc_ref = boc_ref
    }
}

public struct TSDKResultOfBocCacheGet: Codable, @unchecked Sendable {
    /// BOC encoded as base64.
    public var boc: String?

    public init(boc: String? = nil) {
        self.boc = boc
    }
}

public struct TSDKParamsOfBocCacheSet: Codable, @unchecked Sendable {
    /// BOC encoded as base64 or BOC reference
    public var boc: String
    /// Cache type
    public var cache_type: TSDKBocCacheType

    public init(boc: String, cache_type: TSDKBocCacheType) {
        self.boc = boc
        self.cache_type = cache_type
    }
}

public struct TSDKResultOfBocCacheSet: Codable, @unchecked Sendable {
    /// Reference to the cached BOC
    public var boc_ref: String

    public init(boc_ref: String) {
        self.boc_ref = boc_ref
    }
}

public struct TSDKParamsOfBocCacheUnpin: Codable, @unchecked Sendable {
    /// Pinned name
    public var pin: String
    /// Reference to the cached BOC.
    /// If it is provided then only referenced BOC is unpinned
    public var boc_ref: String?

    public init(pin: String, boc_ref: String? = nil) {
        self.pin = pin
        self.boc_ref = boc_ref
    }
}

public struct TSDKParamsOfEncodeBoc: Codable, @unchecked Sendable {
    /// Cell builder operations.
    public var builder: [TSDKBuilderOp]
    /// Cache type to put the result. The BOC itself returned if no cache type provided.
    public var boc_cache: TSDKBocCacheType?

    public init(builder: [TSDKBuilderOp], boc_cache: TSDKBocCacheType? = nil) {
        self.builder = builder
        self.boc_cache = boc_cache
    }
}

public struct TSDKResultOfEncodeBoc: Codable, @unchecked Sendable {
    /// Encoded cell BOC or BOC cache key.
    public var boc: String

    public init(boc: String) {
        self.boc = boc
    }
}

public struct TSDKParamsOfGetCodeSalt: Codable, @unchecked Sendable {
    /// Contract code BOC encoded as base64 or code BOC handle
    public var code: String
    /// Cache type to put the result. The BOC itself returned if no cache type provided.
    public var boc_cache: TSDKBocCacheType?

    public init(code: String, boc_cache: TSDKBocCacheType? = nil) {
        self.code = code
        self.boc_cache = boc_cache
    }
}

public struct TSDKResultOfGetCodeSalt: Codable, @unchecked Sendable {
    /// Contract code salt if present.
    /// BOC encoded as base64 or BOC handle
    public var salt: String?

    public init(salt: String? = nil) {
        self.salt = salt
    }
}

public struct TSDKParamsOfSetCodeSalt: Codable, @unchecked Sendable {
    /// Contract code BOC encoded as base64 or code BOC handle
    public var code: String
    /// Code salt to set.
    /// BOC encoded as base64 or BOC handle
    public var salt: String
    /// Cache type to put the result. The BOC itself returned if no cache type provided.
    public var boc_cache: TSDKBocCacheType?

    public init(code: String, salt: String, boc_cache: TSDKBocCacheType? = nil) {
        self.code = code
        self.salt = salt
        self.boc_cache = boc_cache
    }
}

public struct TSDKResultOfSetCodeSalt: Codable, @unchecked Sendable {
    /// Contract code with salt set.
    /// BOC encoded as base64 or BOC handle
    public var code: String

    public init(code: String) {
        self.code = code
    }
}

public struct TSDKParamsOfDecodeStateInit: Codable, @unchecked Sendable {
    /// Contract StateInit image BOC encoded as base64 or BOC handle
    public var state_init: String
    /// Cache type to put the result. The BOC itself returned if no cache type provided.
    public var boc_cache: TSDKBocCacheType?

    public init(state_init: String, boc_cache: TSDKBocCacheType? = nil) {
        self.state_init = state_init
        self.boc_cache = boc_cache
    }
}

public struct TSDKResultOfDecodeStateInit: Codable, @unchecked Sendable {
    /// Contract code BOC encoded as base64 or BOC handle
    public var code: String?
    /// Contract code hash
    public var code_hash: String?
    /// Contract code depth
    public var code_depth: UInt32?
    /// Contract data BOC encoded as base64 or BOC handle
    public var data: String?
    /// Contract data hash
    public var data_hash: String?
    /// Contract data depth
    public var data_depth: UInt32?
    /// Contract library BOC encoded as base64 or BOC handle
    public var library: String?
    /// `special.tick` field.
    /// Specifies the contract ability to handle tick transactions
    public var tick: Bool?
    /// `special.tock` field.
    /// Specifies the contract ability to handle tock transactions
    public var tock: Bool?
    /// Is present and non-zero only in instances of large smart contracts
    public var split_depth: UInt32?
    /// Compiler version, for example 'sol 0.49.0'
    public var compiler_version: String?

    public init(code: String? = nil, code_hash: String? = nil, code_depth: UInt32? = nil, data: String? = nil, data_hash: String? = nil, data_depth: UInt32? = nil, library: String? = nil, tick: Bool? = nil, tock: Bool? = nil, split_depth: UInt32? = nil, compiler_version: String? = nil) {
        self.code = code
        self.code_hash = code_hash
        self.code_depth = code_depth
        self.data = data
        self.data_hash = data_hash
        self.data_depth = data_depth
        self.library = library
        self.tick = tick
        self.tock = tock
        self.split_depth = split_depth
        self.compiler_version = compiler_version
    }
}

public struct TSDKParamsOfEncodeStateInit: Codable, @unchecked Sendable {
    /// Contract code BOC encoded as base64 or BOC handle
    public var code: String?
    /// Contract data BOC encoded as base64 or BOC handle
    public var data: String?
    /// Contract library BOC encoded as base64 or BOC handle
    public var library: String?
    /// `special.tick` field.
    /// Specifies the contract ability to handle tick transactions
    public var tick: Bool?
    /// `special.tock` field.
    /// Specifies the contract ability to handle tock transactions
    public var tock: Bool?
    /// Is present and non-zero only in instances of large smart contracts
    public var split_depth: UInt32?
    /// Cache type to put the result. The BOC itself returned if no cache type provided.
    public var boc_cache: TSDKBocCacheType?

    public init(code: String? = nil, data: String? = nil, library: String? = nil, tick: Bool? = nil, tock: Bool? = nil, split_depth: UInt32? = nil, boc_cache: TSDKBocCacheType? = nil) {
        self.code = code
        self.data = data
        self.library = library
        self.tick = tick
        self.tock = tock
        self.split_depth = split_depth
        self.boc_cache = boc_cache
    }
}

public struct TSDKResultOfEncodeStateInit: Codable, @unchecked Sendable {
    /// Contract StateInit image BOC encoded as base64 or BOC handle of boc_cache parameter was specified
    public var state_init: String

    public init(state_init: String) {
        self.state_init = state_init
    }
}

public struct TSDKParamsOfEncodeExternalInMessage: Codable, @unchecked Sendable {
    /// Source address.
    public var src: String?
    /// Destination address.
    public var dst: String
    /// Bag of cells with state init (used in deploy messages).
    public var `init`: String?
    /// Bag of cells with the message body encoded as base64.
    public var body: String?
    /// Cache type to put the result.
    /// The BOC itself returned if no cache type provided
    public var boc_cache: TSDKBocCacheType?

    public init(src: String? = nil, dst: String, `init`: String? = nil, body: String? = nil, boc_cache: TSDKBocCacheType? = nil) {
        self.src = src
        self.dst = dst
        self.`init` = `init`
        self.body = body
        self.boc_cache = boc_cache
    }
}

public struct TSDKResultOfEncodeExternalInMessage: Codable, @unchecked Sendable {
    /// Message BOC encoded with `base64`.
    public var message: String
    /// Message id.
    public var message_id: String

    public init(message: String, message_id: String) {
        self.message = message
        self.message_id = message_id
    }
}

public struct TSDKParamsOfGetCompilerVersion: Codable, @unchecked Sendable {
    /// Contract code BOC encoded as base64 or code BOC handle
    public var code: String

    public init(code: String) {
        self.code = code
    }
}

public struct TSDKResultOfGetCompilerVersion: Codable, @unchecked Sendable {
    /// Compiler version, for example 'sol 0.49.0'
    public var version: String?

    public init(version: String? = nil) {
        self.version = version
    }
}

