public enum TSDKBocCacheTypeEnumTypes: String, Codable {
    case Pinned = "Pinned"
    case Unpinned = "Unpinned"
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

public enum TSDKBuilderOpEnumTypes: String, Codable {
    case Integer = "Integer"
    case BitString = "BitString"
    case Cell = "Cell"
    case CellBoc = "CellBoc"
}

public struct TSDKBocCacheType: Codable {
    public var type: TSDKBocCacheTypeEnumTypes
    public var pin: String?

    public init(type: TSDKBocCacheTypeEnumTypes, pin: String? = nil) {
        self.type = type
        self.pin = pin
    }
}

public struct TSDKParamsOfParse: Codable {
    /// BOC encoded as base64
    public var boc: String

    public init(boc: String) {
        self.boc = boc
    }
}

public struct TSDKResultOfParse: Codable {
    /// JSON containing parsed BOC
    public var parsed: AnyJSONType

    public init(parsed: AnyJSONType) {
        self.parsed = parsed
    }
}

public struct TSDKParamsOfParseShardstate: Codable {
    /// BOC encoded as base64
    public var boc: String
    /// Shardstate identificator
    public var id: String
    /// Workchain shardstate belongs to
    public var workchain_id: Int32

    public init(boc: String, id: String, workchain_id: Int32) {
        self.boc = boc
        self.id = id
        self.workchain_id = workchain_id
    }
}

public struct TSDKParamsOfGetBlockchainConfig: Codable {
    /// Key block BOC or zerostate BOC encoded as base64
    public var block_boc: String

    public init(block_boc: String) {
        self.block_boc = block_boc
    }
}

public struct TSDKResultOfGetBlockchainConfig: Codable {
    /// Blockchain config BOC encoded as base64
    public var config_boc: String

    public init(config_boc: String) {
        self.config_boc = config_boc
    }
}

public struct TSDKParamsOfGetBocHash: Codable {
    /// BOC encoded as base64
    public var boc: String

    public init(boc: String) {
        self.boc = boc
    }
}

public struct TSDKResultOfGetBocHash: Codable {
    /// BOC root hash encoded with hex
    public var hash: String

    public init(hash: String) {
        self.hash = hash
    }
}

public struct TSDKParamsOfGetCodeFromTvc: Codable {
    /// Contract TVC image encoded as base64
    public var tvc: String

    public init(tvc: String) {
        self.tvc = tvc
    }
}

public struct TSDKResultOfGetCodeFromTvc: Codable {
    /// Contract code encoded as base64
    public var code: String

    public init(code: String) {
        self.code = code
    }
}

public struct TSDKParamsOfBocCacheGet: Codable {
    /// Reference to the cached BOC
    public var boc_ref: String

    public init(boc_ref: String) {
        self.boc_ref = boc_ref
    }
}

public struct TSDKResultOfBocCacheGet: Codable {
    /// BOC encoded as base64.
    public var boc: String?

    public init(boc: String? = nil) {
        self.boc = boc
    }
}

public struct TSDKParamsOfBocCacheSet: Codable {
    /// BOC encoded as base64 or BOC reference
    public var boc: String
    /// Cache type
    public var cache_type: TSDKBocCacheType

    public init(boc: String, cache_type: TSDKBocCacheType) {
        self.boc = boc
        self.cache_type = cache_type
    }
}

public struct TSDKResultOfBocCacheSet: Codable {
    /// Reference to the cached BOC
    public var boc_ref: String

    public init(boc_ref: String) {
        self.boc_ref = boc_ref
    }
}

public struct TSDKParamsOfBocCacheUnpin: Codable {
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

public struct TSDKBuilderOp: Codable {
    public var type: TSDKBuilderOpEnumTypes
    /// Bit size of the value.
    public var size: UInt32?
    /// Value: - `Number` containing integer number.
    /// e.g. `123`, `-123`. - Decimal string. e.g. `"123"`, `"-123"`.
    /// - `0x` prefixed hexadecimal string.
    ///   e.g `0x123`, `0X123`, `-0x123`.
    public var value: AnyJSONType?
    /// Nested cell builder
    public var builder: [TSDKBuilderOp]?
    /// Nested cell BOC encoded with `base64` or BOC cache key.
    public var boc: String?

    public init(type: TSDKBuilderOpEnumTypes, size: UInt32? = nil, value: AnyJSONType? = nil, builder: [TSDKBuilderOp]? = nil, boc: String? = nil) {
        self.type = type
        self.size = size
        self.value = value
        self.builder = builder
        self.boc = boc
    }
}

/// Cell builder operation.
public struct TSDKParamsOfEncodeBoc: Codable {
    /// Cell builder operations.
    public var builder: [TSDKBuilderOp]
    /// Cache type to put the result. The BOC itself returned if no cache type provided.
    public var boc_cache: TSDKBocCacheType?

    public init(builder: [TSDKBuilderOp], boc_cache: TSDKBocCacheType? = nil) {
        self.builder = builder
        self.boc_cache = boc_cache
    }
}

public struct TSDKResultOfEncodeBoc: Codable {
    /// Encoded cell BOC or BOC cache key.
    public var boc: String

    public init(boc: String) {
        self.boc = boc
    }
}

