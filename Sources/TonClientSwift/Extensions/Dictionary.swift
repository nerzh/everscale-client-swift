//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 04.12.2020.
//

import Foundation

public extension Dictionary {

    private func checkAnyValue(_ value: Any) -> AnyValue {
        if let value = value as? String {
            return AnyValue.string(value)
        } else if let value = value as? Int {
            return AnyValue.int(value)
        } else if let value = value as? Double {
            return AnyValue.double(value)
        } else if let value = value as? Bool {
            return AnyValue.bool(value)
        } else if let value = value as? [String: Any] {
            var dict: [String: AnyValue] = .init()
            for (key, val) in value {
                dict[key] = checkAnyValue(val)
            }
            return AnyValue.object(dict)
        } else if let value = value as? [Any] {
            var array: [AnyValue] = .init()
            for (val) in value {
                array.append(checkAnyValue(val))
            }
            return AnyValue.array(array)
        } else {
            return AnyValue.nil(nil)
//            self = .nil(nil)
//            throw DecodingError.typeMismatch(JSONValue.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "Not a JSON"))
        }
    }

    func toAnyValue() -> AnyValue {
        checkAnyValue(self)
    }
}
