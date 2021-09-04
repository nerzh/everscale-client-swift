//
//  CodeGenerator.swift
//  
//
//  Created by Oleh Hudeichuk on 07.05.2021.
//

import Foundation
import SwiftRegularExpression
import FileUtils

class CodeGenerator {
    var swiftApi: SDKSwiftApi
    var tab: String = "    "

    init(swiftApi: SDKSwiftApi) {
        self.swiftApi = swiftApi
    }

    func generate() {
        for module in swiftApi.modules {
            let moduleClassFolder: String = "./../Sources/TonClientSwift/\(module.name.capitalized)"
            let moduleClassFilePath: String = "\(moduleClassFolder)/\(module.name.capitalized).swift"
            var newModuleClass: String = ""
            if module.name == "client" {
                newModuleClass = generateClientModule(module, swiftApi.modules)
            } else {
                newModuleClass = generateModule(module)
            }
            if FileManager.default.fileExists(atPath: moduleClassFolder) {
                FileUtils.deleteFileOrFolder(URL(string: moduleClassFolder))
            }
            FileUtils.createFolder(URL(fileURLWithPath: moduleClassFolder, isDirectory: true))
            FileUtils.writeFile(to: moduleClassFilePath, newModuleClass)

            var newTypes: String = ""

            for newAlias in module.alias {
                newTypes.append(generateAlias(newAlias))
            }

            for newEnum in module.enums {
                newTypes.append(generateEnum(newEnum))
            }

            for newStruct in module.types {
                newTypes.append(generateStruct(newStruct))
            }

            let moduleTypesFilePath: String = "\(moduleClassFolder)/\(module.name.capitalized)Types.swift"
            FileUtils.writeFile(to: moduleTypesFilePath, newTypes)
        }
    }

    private func generateAlias(_ swiftAlias: SDKSwiftTypeAlias) -> String {
        "\(swiftAlias.accessType) typealias \(swiftAlias.name) = \(swiftAlias.type)\n\n"
    }

    private func generateEnum(_ swiftEnum: SDKSwiftEnum) -> String {
        var result: String = "\(swiftEnum.accessType) enum \(swiftEnum.name): \(swiftEnum.parents.joined(separator: ", ")) {\n"
        for enumCase in swiftEnum.cases {
            let isNumber: Bool = Int(enumCase.value) != nil
            if isNumber {
                result.append("\(tab)case \(enumCase.name) = \(enumCase.value)\n")
            } else {
                result.append("\(tab)case \(enumCase.name) = \"\(enumCase.value)\"\n")
            }
        }
        result.append("}\n\n")
        if let summary: String = swiftEnum.summary { result.append("/// \(checkComment(summary))\n\n") }
        if let descr: String = swiftEnum.description { result.append("/// \(checkComment(descr))\n\n") }

        return result
    }

    private func generateStruct(_ swiftStruct: SDKSwiftStruct) -> String {
        var swiftStruct = swiftStruct
        if swiftStruct.name == "\(libPrefix)ClientError" {
            swiftStruct.parents.append("Error")
        }
        var result: String = "\(swiftStruct.accessType) struct \(swiftStruct.name): \(swiftStruct.parents.joined(separator: ", ")) {\n"
        for property in swiftStruct.properties {
            if let summary: String = property.summary { result.append("\(tab)/// \(checkComment(summary))\n") }
            if let descr: String = property.description { result.append("\(tab)/// \(checkComment(descr))\n") }
            result.append("\(tab)\(property.accessType) var \(property.name): \(property.type)\n")
        }
        result.append("\n\(tab)public init(")
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
        result.append("}\n\n")
        if let summary: String = swiftStruct.summary { result.append("/// \(checkComment(summary))\n") }
        if let descr: String = swiftStruct.description { result.append("/// \(checkComment(descr))\n") }

        return result
    }

//    public func decode_message_body(_ payload: TSDKParamsOfDecodeMessageBody,
//                                    _ handler: @escaping (TSDKBindingResponse<TSDKDecodedMessageBody, TSDKClientError, TSDKDefault>) throws -> Void
//    ) throws {
//        let method: String = "decode_message_body"
//        try binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in
//            var response: TSDKBindingResponse<TSDKDecodedMessageBody, TSDKClientError, TSDKDefault> = .init()
//            response.update(requestId, params, responseType, finished)
//            try handler(response)
//        })
//    }
    private func generateFunction(_ swiftFunction: SDKSwiftFunction) -> String {
        var result: String = .init()
        if let summary = swiftFunction.summary { result.append("\(tab)/// \(checkComment(summary))\n") }
        if let description = swiftFunction.description { result.append("\(tab)/// \(checkComment(description))\n") }
        result.append("\(tab)\(swiftFunction.accessType) func \(swiftFunction.name)(")
        for parameter in swiftFunction.params {
            result.append("_ \(parameter.name): \(parameter.type), ")
        }
        let resultType: String = swiftFunction.willReturn.type == "Void" ? "\(libPrefix)NoneResult" : swiftFunction.willReturn.type
        result.append("_ handler: @escaping (TSDKBindingResponse<\(resultType), \(libPrefix)ClientError, \(libPrefix)Default>) throws -> Void\n\(tab)) throws {\n")
        let methodName: String = swiftFunction.name == "initialize" ? "init" : swiftFunction.name
        result.append("\(tab)\(tab)let method: String = \"\(methodName)\"\n")
        if swiftFunction.params.isEmpty {
            result.append("\(tab)\(tab)try binding.requestLibraryAsync(methodName(module, method), \"\", { (requestId, params, responseType, finished) in\n")
        } else {
            result.append("\(tab)\(tab)try binding.requestLibraryAsync(methodName(module, method), payload, { (requestId, params, responseType, finished) in\n")
        }
        result.append("\(tab)\(tab)\(tab)var response: TSDKBindingResponse<\(resultType), \(libPrefix)ClientError, \(libPrefix)Default> = .init()\n")
        result.append("\(tab)\(tab)\(tab)response.update(requestId, params, responseType, finished)\n")
        result.append("\(tab)\(tab)\(tab)try handler(response)\n")
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
        result.append("}\n")

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
        result.append("\(tab)public init(config: \(libPrefix)ClientConfig) {\n")
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

        /// PRINT DEBUG DEINIT CLIENT
        result.append("\(tab)deinit {\n")
        result.append("\(tab)\(tab)print(\"Client DEINIT !\")\n")
        result.append("\(tab)}\n")
        ///

        result.append("}\n")

        return result
    }

    private func checkComment(_ string: String, tabs: Int = 1) -> String {
        var replacedString: String = "\n"
        for _ in (1...tabs) {
            replacedString.append(tab)
        }
        replacedString.append("/// ")
        let symbolsWithSpace: String = #"\.|\:|\!|\?|\;"#
        let regxp: String = "([^\(symbolsWithSpace)])\n"
        return string
            .replace(#"\n+"#, "\n")
            .replace(#" \n"#, "\n/// ")
            .replace("(\(symbolsWithSpace))\\s*\\n", []) { match in
                return "\(match)\(replacedString)"
            }
            .replace(regxp, []) { match in
            let matches = match.regexp(regxp)
            return "\(matches[1]!)"
        }
    }
}
