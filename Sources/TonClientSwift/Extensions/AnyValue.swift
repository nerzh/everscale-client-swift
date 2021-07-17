//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation
import BigInt

public enum AnyValue: Decodable, Encodable, Equatable {
    case string(String)
    case int(Int)
    case bigInt(BigInt)
    case int8(Int8)
    case int16(Int16)
    case int32(Int32)
    case int64(Int64)
    case uint(UInt)
    case uint8(UInt8)
    case uint16(UInt16)
    case uint32(UInt32)
    case uint64(UInt64)
    case float(Float)
    case float32(Float32)
    case float64(Float64)
    case double(Double)
    case decimal(Decimal)
    case bool(Bool)
    case object([String: AnyValue])
    case array([AnyValue])
    case `nil`(Int8?)

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .bool(value):
            try container.encode(value)
        case let .string(value):
            try container.encode(value)
        case let .int(value):
            try container.encode(value)
        case let .bigInt(value):
            try container.encode(value)
        case let .object(value):
            try container.encode(value)
        case let .array(value):
            try container.encode(value)
        case let .double(value):
            try container.encode(value)
        case let .int8(value):
            try container.encode(value)
        case let .int16(value):
            try container.encode(value)
        case let .int32(value):
            try container.encode(value)
        case let .int64(value):
            try container.encode(value)
        case let .uint(value):
            try container.encode(value)
        case let .uint8(value):
            try container.encode(value)
        case let .uint16(value):
            try container.encode(value)
        case let .uint32(value):
            try container.encode(value)
        case let .uint64(value):
            try container.encode(value)
        case let .float(value):
            try container.encode(value)
        case let .float32(value):
            try container.encode(value)
        case let .float64(value):
            try container.encode(value)
        case let .decimal(value):
            try container.encode(value)
        case let .nil(value):
            try container.encode(value)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode(BigInt.self) {
            self = .bigInt(value)
        } else if let value = try? container.decode(Int.self) {
            self = .int(value)
        } else if let value = try? container.decode(Double.self) {
            self = .double(value)
        } else if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode([String: AnyValue].self) {
            self = .object(value)
        } else if let value = try? container.decode([AnyValue].self) {
            self = .array(value)
        } else {
            self = .nil(nil)
//            throw DecodingError.typeMismatch(JSONValue.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "Not a JSON"))
        }
    }

    public func toJSON() -> String {
        var result: String = .init()

        switch self {
        case let .bool(value):
            result = String(value)
        case let .string(value):
            result = "\"\(value)\""
        case let .int(value):
            result = String(value)
        case let .bigInt(value):
            result = String(value)
        case let .object(value):
            result.append("{")
            var first: Bool = true
            for (key, val) in value {
                if first {
                    result.append("\"\(key)\": \(val.toJSON())")
                } else {
                    result.append(", \"\(key)\": \(val.toJSON())")
                }
                first = false
            }
            result.append("}")
        case let .array(value):
            result.append("[")
            var first: Bool = true
            for val in value {
                if first {
                    result.append("\(val.toJSON())")
                } else {
                    result.append(", \(val.toJSON())")
                }
                first = false
            }
            result.append("]")
        case .nil(_):
            result = "null"
        case let .double(value):
            result = String(value)
        default:
            result = "null"
        }

        return result
    }

    public func toAny() -> Any? {
        var result: Any?

        switch self {
        case let .bool(value):
            result = value
        case let .string(value):
            result = value
        case let .int(value):
            result = value
        case let .bigInt(value):
            result = value
        case let .object(value):
            var tmpResult: [String: Any?] = .init()
            for (key, val) in value {
                tmpResult[key] = val.toAny()
            }
            result = tmpResult
        case let .array(value):
            var tmpResult: [Any?] = .init()
            for val in value {
                tmpResult.append(val.toAny())
            }
            result = tmpResult
        case .nil(_):
            result = nil
        case let .double(value):
            result = value
        case let .int8(value):
            result = value
        case let .int16(value):
            result = value
        case let .int32(value):
            result = value
        case let .int64(value):
            result = value
        case let .uint(value):
            result = value
        case let .uint8(value):
            result = value
        case let .uint16(value):
            result = value
        case let .uint32(value):
            result = value
        case let .uint64(value):
            result = value
        case let .float(value):
            result = value
        case let .float32(value):
            result = value
        case let .float64(value):
            result = value
        case let .decimal(value):
            result = value
        }

        return result
    }

    public func toDictionary() -> [String: Any?]? {
        toAny() as? [String: Any?]
    }
}


public func toAnyValue(_ value: Any) -> AnyValue {
    if let value = value as? String {
        return AnyValue.string(value)
    } else if let value = value as? Int {
        return AnyValue.int(value)
    } else if let value = value as? BigInt {
        return AnyValue.bigInt(value)
    } else if let value = value as? Int8 {
        return AnyValue.int8(value)
    } else if let value = value as? Int16 {
        return AnyValue.int16(value)
    } else if let value = value as? Int32 {
        return AnyValue.int32(value)
    } else if let value = value as? Int64 {
        return AnyValue.int64(value)
    } else if let value = value as? UInt {
        return AnyValue.uint(value)
    } else if let value = value as? UInt8 {
        return AnyValue.uint8(value)
    } else if let value = value as? UInt16 {
        return AnyValue.uint16(value)
    } else if let value = value as? UInt32 {
        return AnyValue.uint32(value)
    } else if let value = value as? UInt64 {
        return AnyValue.uint64(value)
    } else if let value = value as? Float {
        return AnyValue.float(value)
    } else if let value = value as? Float32 {
        return AnyValue.float32(value)
    } else if let value = value as? Float64 {
        return AnyValue.float64(value)
    } else if let value = value as? Decimal {
        return AnyValue.decimal(value)
    } else if let value = value as? Double {
        return AnyValue.double(value)
    } else if let value = value as? Bool {
        return AnyValue.bool(value)
    } else if let value = value as? [String: Any] {
        var dict: [String: AnyValue] = .init()
        for (key, val) in value {
            dict[key] = toAnyValue(val)
        }
        return AnyValue.object(dict)
    } else if let value = value as? [Any] {
        var array: [AnyValue] = .init()
        for (val) in value {
            array.append(toAnyValue(val))
        }
        return AnyValue.array(array)
    } else {
        return AnyValue.nil(nil)
//            throw DecodingError.typeMismatch(JSONValue.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "Not a JSON"))
    }
}

