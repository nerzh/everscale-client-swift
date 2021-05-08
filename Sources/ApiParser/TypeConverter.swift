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

    init(_ filePath: String) throws {
        self.filePath = filePath
        self.sdkApi = try Self.readSDKFile(filePath)
    }

    func convertToSwift() -> SDKSwiftApi {
        var swiftTypes: SDKSwiftApi = .init(version: sdkApi.version)
        for module in sdkApi.modules {
            var swiftModule: SDKSwiftApi.Module = .init(name: module.name,
                                                        summary: module.summary,
                                                        description: module.description,
                                                        enums: [],
                                                        types: [],
                                                        functions: [],
                                                        alias: [])
            /// TYPE
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
                } else if type.type == "Number" {
                    let newAlias: SDKSwiftTypeAlias = convertTypeAlias(type)
                    swiftModule.alias.append(newAlias)
                } else {
                    fatalError("Unkown NEW TYPE for module \(type.name ?? "") \"types\": \(type.type)")
                }
            }

            /// FUNCTIONS
            for function in module.functions {
                var result: SDKSwiftReturn = .init(type: "")
                if function.result.type == "Generic" {
                    let ref_type: String = function.result.generic_args.first?.type ?? ""
                    if ref_type == "Ref" {
                        let ref_name: String = function.result.generic_args.first?.ref_name ?? ""
                        let matches: [Int: String] = ref_name.regexp(#"^(.+)\.(.+)$"#)
                        if let module: String = matches[1],
                           let type: String = matches[2]
                        {
                            _ = module
                            result.type = "\(libPrefix)\(type)"
                        } else {
                            fatalError("Bad function result ref_name: \(ref_name), function name: \(function.name), result: \(function.result)")
                        }
                    } else if ref_type == "None" {
                        result.type = "Void"
                    }
                } else {
                    fatalError("New function result type !")
                }

                /// function
                var newFunction: SDKSwiftFunction = .init(name: checkFunctionName(function.name),
                                                          params: [],
                                                          willReturn: result,
                                                          summary: function.summary,
                                                          description: function.description,
                                                          errors: function.errors)
                /// FUNCTION PARAMETERS
                var paramsCount: Int8 = 0
                for parameter in function.params {
                    if parameter.name == "params" {
                        paramsCount += 1
                        if parameter.type == "Ref" {
                            let ref_name: String = parameter.ref_name ?? ""
                            let matches: [Int: String] = ref_name.regexp(#"^(.+)\.(.+)$"#)
                            if let module: String = matches[1],
                               let type: String = matches[2]
                            {
                                _ = module
                                newFunction.params.append(.init(name: "payload", type: "\(libPrefix)\(type)"))
                            } else {
                                fatalError("Bad function params ref_name: \(ref_name), function name: \(function.name), result: \(function.result)")
                            }
                        } else {
                            fatalError("NEW CASE! New parameter type: \(parameter.type)")
                        }
                    }
                    if paramsCount > 1 { fatalError("NEW CASE ! More then one parameter for functions !") }
                }

                swiftModule.functions.append(newFunction)
            }

            swiftTypes.modules.append(swiftModule)
        }

        return swiftTypes
    }

    func convertTypeAlias(_ from: SDKApiJSON.Module.ModuleType) -> SDKSwiftTypeAlias {
        let result: SDKSwiftTypeAlias = .init(name: "\(libPrefix)\(from.name ?? "")", type: generateType(from))
        return result
    }

    func convertStruct(_ from: SDKApiJSON.Module.ModuleType) -> SDKSwiftStruct {
        var result: SDKSwiftStruct = .init(name: "\(libPrefix)\(from.name ?? "")", parents: defaultStructTypeParents, properties: [], functions: [])
        for field in (from.struct_fields ?? []) {
            if isValidPropertyName(field.name) {
                let property: SDKSwiftProperty = .init(name: checkPropertyName(field.name), type: generateType(field), summary: field.summary, description: field.description)
                result.properties.append(property)
            }
        }
        return result
    }

    func convertEnumOfConsts(_ from: SDKApiJSON.Module.ModuleType) -> SDKSwiftEnum {
        var result: SDKSwiftEnum = .init(name: "\(libPrefix)\(from.name ?? "")", parents: defaultEnumParents, cases: [], summary: from.summary, description: from.description)
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
            let isNumber: Bool = Int(caseValue) != nil
            if isNumber { result.parents = ["Int", "Codable"] }
            result.cases.append(.init(name: caseName, value: caseValue, summary: enumConst.summary, description: enumConst.description))
        }

        return result
    }

    func convertEnumOfTypes(_ from: SDKApiJSON.Module.ModuleType) -> (enum: SDKSwiftEnum, struct: SDKSwiftStruct) {
        var result: (enum: SDKSwiftEnum, struct: SDKSwiftStruct) = (
            enum: .init(name: generateEnumName(from.name ?? ""), parents: defaultEnumParents, cases: []),
            struct: .init(name: generateStructName(from.name ?? ""), parents: defaultStructTypeParents, properties: [], functions: [], summary: from.summary, description: from.description)
        )
        var propertiesNameSet: Set<String> = .init()
        var properties: [SDKApiJSON.Module.ModuleType.EnumType.EnumTypeField] = .init()
        for enum_type in (from.enum_types ?? []) {
            let isNumber: Bool = Int(enum_type.name) != nil
            if isNumber { result.enum.parents = ["Int", "Codable"] }
            result.enum.cases.append(.init(name: enum_type.name, value: enum_type.name))
            for field in (enum_type.struct_fields ?? []) {
                if !propertiesNameSet.contains(field.name ?? "") {
                    properties.append(field)
                }
                propertiesNameSet.insert(field.name ?? "")
            }
        }
        result.struct.properties.append(.init(name: "type", type: generateEnumName(from.name ?? "")))
        for property in properties {
            result.struct.properties.append(.init(name: property.name ?? "", type: "\(generateType(property))?", summary: property.summary, description: property.description))
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
        "\(libPrefix)\(name)\(libEnumPostfix)"
    }

    private func generateStructName(_ name: String) -> String {
        "\(libPrefix)\(name)"
    }

    private func generateSimpleType(_ type: SDKApiJSONTypePrtcl) -> String {
        var tempType: String = ""

        if type.type == "Ref" {
            if type.ref_name == "Value" || type.ref_name == "API" {
                tempType = "Value"
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
            tempType = generateType(arrayItem)
            let matches: [Int: String] = tempType.regexp(#"^(.+)(\?|\!)$"#)
            if let type: String = matches[1], let symbol: String = matches[2] {
                tempType = "[\(type)]\(symbol)"
            } else {
                tempType = "[\(tempType)]"
            }
        } else {
            tempType = type.type
        }

        if let result = types[tempType] {
            return result
        } else {
            return tempType
        }
    }

    private func generateType(_ type: SDKApiJSONFieldPrtcl) -> String {
        if type.type == "Optional", let optionalInner = type.optional_inner {
            if optionalInner.type == "Optional" {
                return generateType(optionalInner)
            } else {
                return "\(generateSimpleType(optionalInner))?"
            }
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

    private func checkPropertyName(_ name: String?) -> String {
        var result: String = ""
        guard let name = name else {
            fatalError("Property Name is nil")
        }
        switch name {
        case "public":
            result = "`public`"
        default:
            result = name
        }

        return result
    }

    private func isValidPropertyName(_ name: String?) -> Bool {
        !(name ?? "")[#" "#]
    }

    private func checkFunctionName(_ name: String?) -> String {
        var result: String = ""
        guard let name = name else {
            fatalError("Property Name is nil")
        }
        switch name {
        case "init":
            result = "initialize"
        default:
            result = name
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

struct SDKSwiftTypeAlias {
    var accessType: String = "public"
    var name: String
    var type: String
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
    var params: [SDKSwiftParameter]
    var willReturn: SDKSwiftReturn
    var summary: String?
    var description: String?
    var errors: String?
}

struct SDKSwiftProperty {
    var accessType: String = "public"
    var name: String
    var type: String
    var value: String? = nil
    var summary: String?
    var description: String?
}

struct SDKSwiftParameter {
    var name: String
    var type: String
    var value: String?
}

struct SDKSwiftReturn {
    var type: String
}

struct SDKSwiftApi {
    var version: String
    var modules: [Module] = []

    struct Module {
        var name: String
        var summary: String?
        var description: String?
        var enums: [SDKSwiftEnum]
        var types: [SDKSwiftStruct]
        var functions: [SDKSwiftFunction]
        var alias: [SDKSwiftTypeAlias]
    }
}





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

        struct ModuleType: SDKApiJSONFieldPrtcl {
            var name: String?
            var optional_inner: OptionalInner?
            var ref_name: String?
            var number_type: String?
            var number_size: Int?
            var array_item: ArrayItem?
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
                    var name: String?
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
                var name: String?
                var type: String
                var ref_name: String?
                var number_type: String?
                var number_size: Int?
                var array_item: ArrayItem?
                var optional_inner: OptionalInner?
                var summary: String?
                var description: String?
            }

            class OptionalInner: SDKApiJSONFieldPrtcl {
                var name: String?
                var optional_inner: SDKApiJSON.Module.ModuleType.OptionalInner?
                var type: String
                var ref_name: String?
                var number_type: String?
                var number_size: Int?
                var array_item: ArrayItem?
                var summary: String?
                var description: String?
            }

            class ArrayItem: SDKApiJSONFieldPrtcl {
                var name: String?
                var type: String
                var ref_name: String?
                var number_type: String?
                var number_size: Int?
                var optional_inner: OptionalInner?
                var array_item: ArrayItem?
                var summary: String?
                var description: String?

                init(type: String,
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

/// needed for optional_inner - fix recursive protocol
protocol SDKApiJSONTypePrtcl: Codable {
    var type: String {get set}
    var ref_name: String? {get set}
    var number_type: String? {get set}
    var number_size: Int? {get set}
    var array_item: SDKApiJSON.Module.ModuleType.ArrayItem? {get set}
    var summary: String? {get set}
    var description: String? {get set}
}

protocol SDKApiJSONFieldPrtcl: SDKApiJSONTypePrtcl {
    var name: String? {get set}
    var optional_inner: SDKApiJSON.Module.ModuleType.OptionalInner? {get set}
}


