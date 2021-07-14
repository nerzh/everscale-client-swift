//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

public enum AnyValue: Decodable, Encodable, Equatable {
    case string(String)
    case int(Int)
    case double(Double)
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
        case let .object(value):
            try container.encode(value)
        case let .array(value):
            try container.encode(value)
        case let .nil(value):
            try container.encode(value)
        case let .double(value):
            try container.encode(value)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self) {
            self = .string(value)
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
        }

        return result
    }

    public func toDictionary() -> [String: Any?]? {
        toAny() as? [String: Any?]
    }

}
