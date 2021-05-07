//
//  CodeGenerator.swift
//  
//
//  Created by Oleh Hudeichuk on 07.05.2021.
//

import Foundation
import SwiftRegularExpression

class CodeGenerator {
    var swiftTypes: SDKSwiftTypes
    var tab: String = "    "

    init(swiftTypes: SDKSwiftTypes) {
        self.swiftTypes = swiftTypes
    }

    func generate() {
//        for m in swiftTypes.modules.first!.enums {
//            print(generateEnum(m))
//        }

        for m in swiftTypes.modules.first!.types {
            print(generateStruct(m))
        }
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
}
