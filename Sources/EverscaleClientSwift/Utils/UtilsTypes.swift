import Foundation
import SwiftExtensionsPack


public enum TSDKAddressStringFormatEnumTypes: String, Codable {
    case AccountId = "AccountId"
    case Hex = "Hex"
    case Base64 = "Base64"
}

public enum TSDKAccountAddressType: String, Codable {
    case AccountId = "AccountId"
    case Hex = "Hex"
    case Base64 = "Base64"
}

public struct TSDKAddressStringFormat: Codable, @unchecked Sendable {
    public var type: TSDKAddressStringFormatEnumTypes
    public var url: Bool?
    public var test: Bool?
    public var bounce: Bool?

    public init(type: TSDKAddressStringFormatEnumTypes, url: Bool? = nil, test: Bool? = nil, bounce: Bool? = nil) {
        self.type = type
        self.url = url
        self.test = test
        self.bounce = bounce
    }
}

public struct TSDKParamsOfConvertAddress: Codable, @unchecked Sendable {
    /// Account address in any TON format.
    public var address: String
    /// Specify the format to convert to.
    public var output_format: TSDKAddressStringFormat

    public init(address: String, output_format: TSDKAddressStringFormat) {
        self.address = address
        self.output_format = output_format
    }
}

public struct TSDKResultOfConvertAddress: Codable, @unchecked Sendable {
    /// Address in the specified format
    public var address: String

    public init(address: String) {
        self.address = address
    }
}

public struct TSDKParamsOfGetAddressType: Codable, @unchecked Sendable {
    /// Account address in any TON format.
    public var address: String

    public init(address: String) {
        self.address = address
    }
}

public struct TSDKResultOfGetAddressType: Codable, @unchecked Sendable {
    /// Account address type.
    public var address_type: TSDKAccountAddressType

    public init(address_type: TSDKAccountAddressType) {
        self.address_type = address_type
    }
}

public struct TSDKParamsOfCalcStorageFee: Codable, @unchecked Sendable {
    public var account: String
    public var period: UInt32

    public init(account: String, period: UInt32) {
        self.account = account
        self.period = period
    }
}

public struct TSDKResultOfCalcStorageFee: Codable, @unchecked Sendable {
    public var fee: String

    public init(fee: String) {
        self.fee = fee
    }
}

public struct TSDKParamsOfCompressZstd: Codable, @unchecked Sendable {
    /// Uncompressed data.
    /// Must be encoded as base64.
    public var uncompressed: String
    /// Compression level, from 1 to 21. Where: 1 - lowest compression level (fastest compression); 21 - highest compression level (slowest compression). If level is omitted, the default compression level is used (currently `3`).
    public var level: Int32?

    public init(uncompressed: String, level: Int32? = nil) {
        self.uncompressed = uncompressed
        self.level = level
    }
}

public struct TSDKResultOfCompressZstd: Codable, @unchecked Sendable {
    /// Compressed data.
    /// Must be encoded as base64.
    public var compressed: String

    public init(compressed: String) {
        self.compressed = compressed
    }
}

public struct TSDKParamsOfDecompressZstd: Codable, @unchecked Sendable {
    /// Compressed data.
    /// Must be encoded as base64.
    public var compressed: String

    public init(compressed: String) {
        self.compressed = compressed
    }
}

public struct TSDKResultOfDecompressZstd: Codable, @unchecked Sendable {
    /// Decompressed data.
    /// Must be encoded as base64.
    public var decompressed: String

    public init(decompressed: String) {
        self.decompressed = decompressed
    }
}

