//
//  TypeConverter.swift
//  
//
//  Created by Oleh Hudeichuk on 04.05.2021.
//

import Foundation
import FileUtils
import SwiftRegularExpression

private let types: [String: String] = [
    "Number": "Double",
    "UInt": "UInt",
    "UInt8": "UInt8",
    "UInt16": "UInt16",
    "UInt32": "UInt32",
    "UInt64": "UInt64",
    "Int": "Int",
    "Int8": "Int8",
    "Int16": "Int16",
    "Int32": "Int32",
    "Int64": "Int64",
    "String": "String",
    "Value": "AnyJSONType",
    "BigInt": "Int",
    "Boolean": "Bool"
]

class SDKApi {

    private var _filePath: String = ""
    var filePath: String
    var sdkApi: SDKApiJSON!
    var libPrefix: String = "TSDK"
    var libEnumPostfix: String = "EnumTypes"
    var defaultEnumParents: [String] = ["String", "Codable"]
    var defaultStructTypeParents: [String] = ["Codable"]

    init(_ filePath: String) throws {
        self.filePath = filePath
        self.sdkApi = try Self.readSDKFile(filePath)
    }

    func convertToSwift() -> SDKSwiftTypes {
        var swiftTypes: SDKSwiftTypes = .init(version: sdkApi.version)
        for module in sdkApi.modules {
            var swiftModule: SDKSwiftTypes.Module = .init(name: module.name,
                                                          summary: module.summary,
                                                          description: module.description,
                                                          enums: [],
                                                          types: [],
                                                          functions: [])
            for type in module.types {
                if type.type == "EnumOfTypes" {
                    let (newEnum, newStruct) = convertEnumOfTypes(type)
                    swiftModule.enums.append(newEnum)
                    swiftModule.types.append(newStruct)
                } else if type.type == "EnumOfConsts" {
                    let newEnum: SDKSwiftEnum = convertEnumOfConsts(type)
                    swiftModule.enums.append(newEnum)
                } else if type.type == "Struct" {
                    let newStruct: SDKSwiftStruct = convertStruct(type)
                    swiftModule.types.append(newStruct)
                }
            }
            swiftTypes.modules.append(swiftModule)
        }

        return swiftTypes
    }

    func convertStruct(_ from: SDKApiJSON.Module.ModuleType) -> SDKSwiftStruct {
        var result: SDKSwiftStruct = .init(name: from.name, parents: defaultStructTypeParents, properties: [], functions: [])
        for field in (from.struct_fields ?? []) {
            let property: SDKSwiftProperty = .init(name: field.name, type: generateType(field), summary: field.summary, description: field.description)
            result.properties.append(property)
        }
        return result
    }

    func convertEnumOfConsts(_ from: SDKApiJSON.Module.ModuleType) -> SDKSwiftEnum {
        var result: SDKSwiftEnum = .init(name: generateEnumName(from.name), parents: defaultEnumParents, cases: [], summary: from.summary, description: from.description)
        for enumConst in (from.enum_consts ?? []) {
            let caseName: String = enumConst.name
            var caseValue: String = .init()
            if enumConst.type == "Number" {
                guard let value = enumConst.value else { fatalError("Don't get Number value is nil") }
                caseValue = value
            } else if enumConst.type == "String" {
                guard let value = enumConst.value else { fatalError("Don't get String value is nil") }
                caseValue = value
            } else if enumConst.type == "Boolean" {
                guard let value = enumConst.value else { fatalError("Don't get Boolean value is nil") }
                caseValue = value
            } else if enumConst.type == "None" {
                caseValue = enumConst.name
            } else {
                fatalError("Unkown type: \(enumConst.type)")
            }
            result.cases.append(.init(name: caseName, value: caseValue, summary: enumConst.summary, description: enumConst.description))
        }

        return result
    }

    func convertEnumOfTypes(_ from: SDKApiJSON.Module.ModuleType) -> (enum: SDKSwiftEnum, struct: SDKSwiftStruct) {
        var result: (enum: SDKSwiftEnum, struct: SDKSwiftStruct) = (
            enum: .init(name: generateEnumName(from.name), parents: defaultEnumParents, cases: []),
            struct: .init(name: generateStructName(from.name), parents: defaultStructTypeParents, properties: [], functions: [], summary: from.summary, description: from.description)
        )
        var propertiesNameSet: Set<String> = .init()
        var properties: [SDKApiJSON.Module.ModuleType.EnumType.EnumTypeField] = .init()
        for enum_type in (from.enum_types ?? []) {
            result.enum.cases.append(.init(name: enum_type.name, value: enum_type.name))
            for field in (enum_type.struct_fields ?? []) {
                if !propertiesNameSet.contains(field.name) {
                    properties.append(field)
                }
                propertiesNameSet.insert(field.name)
            }
        }
        for property in properties {
            result.struct.properties.append(.init(name: property.name, type: generateType(property), summary: property.summary, description: property.description))
        }
        return result
    }

    private static func readSDKFile(_ path: String) throws -> SDKApiJSON {
        let json: String? = try FileUtils.readFile(URL(fileURLWithPath: path))
        guard let data: Data = json?.data(using: .utf16) else {
            fatalError("Error - Get Data from json string")
        }
        return try JSONDecoder().decode(SDKApiJSON.self, from: data)
    }

    private func generateEnumName(_ name: String) -> String {
        "\(name)\(libEnumPostfix)"
    }

    private func generateStructName(_ name: String) -> String {
        "\(libPrefix)\(name)"
    }

    private func generateSimpleType(_ type: SDKApiJSONTypePrtcl) -> String {
        var tempType: String = ""

        if type.type == "Ref" {
            if type.ref_name == "Value" {
                tempType = type.ref_name!
            } else {
                return generateRefType(type.ref_name ?? "nil")
            }
        } else if type.type == "Number",
                  let numberType = type.number_type,
                  let numberSize = type.number_size
        {
            tempType = "\(numberType)\(numberSize)"
        } else if type.type == "Array",
                  let arrayItem = type.array_item
        {
            tempType = generateSimpleType(arrayItem)
            let matches: [Int: String] = tempType.regexp(#"^(.+)(\?|\!)$"#)
            if let type: String = matches[1], let symbol: String = matches[2] {
                tempType = "[\(type)]\(symbol)"
            }
        } else {
            tempType = type.type
        }

//        guard let result = types[tempType] else {
//            fatalError("Didn't find any type for \(tempType)")
//        }

        if let result = types[tempType] {
            return result
        } else {
            return tempType
        }
//        return ""
    }

    private func generateType(_ type: SDKApiJSONFieldPrtcl) -> String {
        if type.type == "Optional", let optionalInner = type.optional_inner {
            return "\(generateSimpleType(optionalInner))?"
        } else {
            return generateSimpleType(type)
        }
    }

    private func generateRefType(_ type: String) -> String {
        var result: String = ""
        let matches: [Int: String] = type.regexp(#"(.+)\.(.+)"#)
        if let module: String = matches[1],
           let typeName: String = matches[2]
        {
            _ = module
            result = "\(libPrefix)\(typeName)"
        } else {
            result = "\(libPrefix)\(type)"
//            fatalError("generateRefType: parse error - module not found for \(type)")
        }

        return result
    }
}


struct SDKSwiftEnum {
    var accessType: String = "public"
    var name: String
    var parents: [String]
    var cases: [Case]
    var summary: String?
    var description: String?

    struct Case {
        var name: String
        var value: String
        var summary: String?
        var description: String?
    }
}

struct SDKSwiftStruct {
    var accessType: String = "public"
    var name: String
    var parents: [String]
    var properties: [SDKSwiftProperty]
    var functions: [SDKSwiftFunction]
    var summary: String?
    var description: String?
}

struct SDKSwiftFunction {
    var accessType: String = "public"
    var name: String
    var params: [SDKSwiftParametr]
    var willReturn: SDKSwiftReturn
    var summary: String?
    var description: String?
}

struct SDKSwiftProperty {
    var accessType: String = "public"
    var name: String
    var type: String
    var value: String? = nil
    var summary: String?
    var description: String?
}

struct SDKSwiftParametr {
    var name: String
    var type: String
    var value: String
}

struct SDKSwiftReturn {
    var type: String
}

struct SDKSwiftTypes {
    var version: String
    var modules: [Module] = []

    struct Module {
        var name: String
        var summary: String?
        var description: String?
        var enums: [SDKSwiftEnum]
        var types: [SDKSwiftStruct]
        var functions: [SDKSwiftFunction]
    }
}










//protocol SDKApiJSONFieldSimplePrtcl: Codable {
//    var name: String {get set}
//    var type: String {get set}
//    var ref_name: String? {get set}
//    var number_type: String? {get set}
//    var number_size: Int? {get set}
//    var array_item: SDKApiJSON.Module.ModuleType.ArrayItem? {get set}
//    var summary: String? {get set}
//    var description: String? {get set}
//}
//
//protocol SDKApiJSONFieldPrtcl: SDKApiJSONFieldSimplePrtcl {
//    var optional_inner: SDKApiJSON.Module.ModuleType.OptionalInner? {get set}
//}

struct SDKApiJSON: Codable {
    var version: String
    var modules: [Module]

    struct Module: Codable {
        var name: String
        var summary: String?
        var description: String?
        var types: [ModuleType]
        var functions: [ModuleFunction]

        struct ModuleFunction: Codable {
            var name: String
            var summary: String?
            var description: String?
            var params: [FunctionParameter]
            var result: FunctionResult
            var errors: String?

            struct FunctionParameter: Codable {
                var name: String
                var type: String
                var generic_name: String?
                var generic_args: [GenericArg]?
                var ref_name: String?
                var summary: String?
                var description: String?
            }

            struct FunctionResult: Codable {
                var type: String
                var generic_name: String
                var generic_args: [GenericArg]
            }

            struct GenericArg: Codable {
                var type: String
                var ref_name: String?
            }
        }

        struct ModuleType: Codable {
            var name: String
            var type: String
            var enum_consts: [ConstantType]?
            var struct_fields: [StructField]?
            var enum_types: [EnumType]?
            var summary: String?
            var description: String?

            struct ConstantType: Codable {
                var name: String
                var type: String
                var value: String?
                var summary: String?
                var description: String?
            }

            struct EnumType: Codable {
                var name: String
                var type: String
                var struct_fields: [EnumTypeField]?

                struct EnumTypeField: SDKApiJSONFieldPrtcl {
                    var name: String
                    var type: String
                    var ref_name: String?
                    var number_type: String?
                    var number_size: Int?
                    var array_item: ArrayItem?
                    var optional_inner: OptionalInner?
                    var summary: String?
                    var description: String?
                }
            }

            struct StructField: SDKApiJSONFieldPrtcl {
                var name: String
                var type: String
                var ref_name: String?
                var number_type: String?
                var number_size: Int?
                var array_item: ArrayItem?
                var optional_inner: OptionalInner?
                var summary: String?
                var description: String?
            }

            struct OptionalInner: SDKApiJSONTypePrtcl {
                var type: String
                var ref_name: String?
                var number_type: String?
                var number_size: Int?
                var array_item: ArrayItem?
                var summary: String?
                var description: String?

                enum CodingKeys: String, CodingKey {
                    case type
                    case ref_name
                    case number_type
                    case number_size
                    case array_item
                    case summary
                    case description
                }

                init(from decoder: Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
//                    name = try container.decodeIfPresent(String.self, forKey: CodingKeys.name) ?? ""
                    type = try container.decode(String.self, forKey: CodingKeys.type)
                    ref_name = try container.decodeIfPresent(String.self, forKey: CodingKeys.ref_name)
                    number_type = try container.decodeIfPresent(String.self, forKey: CodingKeys.number_type)
                    number_size = try container.decodeIfPresent(Int.self, forKey: CodingKeys.number_size)
                    array_item = try container.decodeIfPresent(ArrayItem.self, forKey: CodingKeys.array_item)
                    summary = try container.decodeIfPresent(String.self, forKey: CodingKeys.summary)
                    description = try container.decodeIfPresent(String.self, forKey: CodingKeys.description)
                }
            }

            class ArrayItem: SDKApiJSONTypePrtcl {
                var type: String
                var ref_name: String?
                var number_type: String?
                var number_size: Int?
                var optional_inner: OptionalInner?
                var array_item: ArrayItem?
                var summary: String?
                var description: String?

                init(
                              type: String,
                              ref_name: String? = nil,
                              number_type: String? = nil,
                              number_size: Int? = nil,
                              optional_inner: OptionalInner? = nil,
                              array_item: ArrayItem? = nil,
                              summary: String? = nil,
                              description: String? = nil
                ) {
                    self.type = type
                    self.ref_name = ref_name
                    self.number_type = number_type
                    self.number_size = number_size
                    self.optional_inner = optional_inner
                    self.array_item = array_item
                    self.summary = summary
                    self.description = description
                }
            }
        }
    }
}

protocol SDKApiJSONTypePrtcl: Codable {
    var type: String {get set}
    var ref_name: String? {get set}
    var number_type: String? {get set}
    var number_size: Int? {get set}
    var array_item: SDKApiJSON.Module.ModuleType.ArrayItem? {get set}
    var summary: String? {get set}
    var description: String? {get set}
}


//protocol SDKApiJSONFieldSimplePrtcl: SDKApiJSONTypePrtcl {
//    var name: String {get set}
//}

protocol SDKApiJSONFieldPrtcl: SDKApiJSONTypePrtcl {
    var name: String {get set}
    var optional_inner: SDKApiJSON.Module.ModuleType.OptionalInner? {get set}
}

