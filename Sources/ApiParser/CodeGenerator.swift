//
//  CodeGenerator.swift
//  
//
//  Created by Oleh Hudeichuk on 07.05.2021.
//

import Foundation
import SwiftRegularExpression

class CodeGenerator {
    var swiftApi: SDKSwiftApi
    var tab: String = "    "

    init(swiftApi: SDKSwiftApi) {
        self.swiftApi = swiftApi
    }

    func generate() {
//        for m in swiftTypes.modules.first!.enums {
//            print(generateEnum(m))
//        }

//        for m in swiftTypes.modules.first!.types {
//            print(generateStruct(m))
//        }

        print(generateClientModule(swiftApi.modules.first!, swiftApi.modules))
//        for m in swiftTypes.modules.first!.functions {
//            print(generateFunction(m))
//        }
    }

    private func generateEnum(_ swiftEnum: SDKSwiftEnum) -> String {
        var result: String = "\(swiftEnum.accessType) enum \(swiftEnum.name): \(swiftEnum.parents.joined(separator: ", ")) {\n"
        for enumCase in swiftEnum.cases {
            let isNumber: Bool = Int(enumCase.value) != nil
            if isNumber {
                result.append("\(tab)\(enumCase.name) = \(enumCase.value)\n")
            } else {
                result.append("\(tab)\(enumCase.name) = \"\(enumCase.value)\"\n")
            }
        }
        result.append("}\n")
        if let summary: String = swiftEnum.summary { result.append("\(summary.replace(#"\n"#, ""))\n") }
        if let descr: String = swiftEnum.description { result.append("\(descr.replace(#"\n"#, ""))\n") }

        return result
    }

    private func generateStruct(_ swiftStruct: SDKSwiftStruct) -> String {
        var result: String = "\(swiftStruct.accessType) struct \(swiftStruct.name): \(swiftStruct.parents.joined(separator: ", ")) {\n"
        for property in swiftStruct.properties {
            if let summary: String = property.summary { result.append("\(tab)/// \(summary.replace(#"\n"#, ""))\n") }
            if let descr: String = property.description { result.append("\(tab)/// \(descr.replace(#"\n"#, ""))\n") }
            result.append("\(tab)\(property.accessType) var \(property.name): \(property.type)\n")
        }
        result.append("\n\(tab)init(")
        for (index, property) in swiftStruct.properties.enumerated() {
            if property.type[#"\?$"#] {
                result.append("\(property.name): \(property.type) = nil")
            } else {
                result.append("\(property.name): \(property.type)")
            }
            if index != swiftStruct.properties.count - 1 {result.append(", ")}
        }
        result.append(") {\n")
        for property in swiftStruct.properties {
            result.append("\(tab)\(tab)self.\(property.name) = \(property.name)\n")
        }
        result.append("\(tab)}\n")
        result.append("}\n")
        if let summary: String = swiftStruct.summary { result.append("\(summary.replace(#"\n"#, ""))\n") }
        if let descr: String = swiftStruct.description { result.append("\(descr.replace(#"\n"#, ""))\n") }

        return result
    }

//    public func factorize(_ payload: TSDKParamsOfFactorize,
//                          _ handler: @escaping (TSDKBindingResponse<TSDKResultOfFactorize, TSDKClientError, TSDKDefault>) -> Void
//    ) {
//        let method: String = "factorize"
//        binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
//            var response: TSDKBindingResponse<TSDKResultOfFactorize, TSDKClientError, TSDKDefault> = .init()
//            response.update(requestId, params, responseType, finished)
//            handler(response)
//        })
//    }
    private func generateFunction(_ swiftFunction: SDKSwiftFunction) -> String {
        var result: String = "\(tab)\(swiftFunction.accessType) func \(swiftFunction.name)("
        for parameter in swiftFunction.params {
            result.append("_ \(parameter.name): \(parameter.type), ")
        }
        let resultType: String = swiftFunction.willReturn.type == "Void" ? "\(libPrefix)NoneResult" : swiftFunction.willReturn.type
        result.append("_ handler: @escaping (TSDKBindingResponse<\(resultType), \(libPrefix)ClientError, \(libPrefix)Default>) -> Void\n\(tab)) {\n")
        result.append("\(tab)\(tab)let method: String = \"\(swiftFunction.name)\"\n")
        if swiftFunction.params.isEmpty {
            result.append("\(tab)\(tab)binding.requestLibraryAsync(methodName(module, method), \"\", { (requestId, params, responseType, finished) in\n")
        } else {
            result.append("\(tab)\(tab)binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in\n")
        }
        result.append("\(tab)\(tab)\(tab)var response: TSDKBindingResponse<\(resultType), \(libPrefix)ClientError, \(libPrefix)Default> = .init()\n")
        result.append("\(tab)\(tab)\(tab)response.update(requestId, params, responseType, finished)\n")
        result.append("\(tab)\(tab)\(tab)handler(response)\n")
        result.append("\(tab)\(tab)})\n")
        result.append("\(tab)}\n\n")

        return result
    }

    private func generateModule(_ swiftModule: SDKSwiftApi.Module) -> String {
        var result: String = "public final class \(libPrefix)\(swiftModule.name.capitalized)Module {\n\n"
        result.append("\(tab)private var binding: \(libPrefix)BindingModule\n")
        result.append("\(tab)public let module: String = \"\(swiftModule.name)\"\n\n")
        result.append("\(tab)public init(binding: \(libPrefix)BindingModule) {\n")
        result.append("\(tab)\(tab)self.binding = binding\n")
        result.append("\(tab)}\n\n")

        for function in swiftModule.functions {
            result.append(generateFunction(function))
        }
        result.append("}")

        return result
    }

    private func generateClientModule(_ swiftModule: SDKSwiftApi.Module, _ modules: [SDKSwiftApi.Module]) -> String {
        var result: String = "public final class \(libPrefix)\(swiftModule.name.capitalized)Module {\n\n"
        result.append("\(tab)private var binding: \(libPrefix)BindingModule\n")
        result.append("\(tab)public let module: String = \"\(swiftModule.name)\"\n")
        result.append("\(tab)public let config: \(libPrefix)ClientConfig\n")
        for module in modules {
            if module.name == "client" { continue }
            result.append("\(tab)public var \(module.name): \(libPrefix)\(module.name.capitalized)Module\n")
        }
        result.append("\n")
        result.append("\(tab)public init(congig: \(libPrefix)ClientConfig) {\n")
        result.append("\(tab)\(tab)self.config = config\n")
        result.append("\(tab)\(tab)self.binding = \(libPrefix)BindingModule(config: config)\n")
        for module in modules {
            if module.name == "client" { continue }
            result.append("\(tab)\(tab)self.\(module.name) = \(libPrefix)\(module.name.capitalized)Module(binding: binding)\n")
        }
        result.append("\(tab)}\n\n")

        for function in swiftModule.functions {
            result.append(generateFunction(function))
        }
        result.append("}")

        return result
    }
}
