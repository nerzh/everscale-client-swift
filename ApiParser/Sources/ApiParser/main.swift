//
//  main.swift
//  
//
//  Created by Oleh Hudeichuk on 04.05.2021.
//

import ArgumentParser
import FileUtils
import Foundation
import SwiftRegularExpression

struct ApiParser: ParsableCommand {

    @Argument(help: "Path to api json file.")
    var pathToApiFile: String

    mutating func run() throws {
        let api = try SDKApi.init(pathToApiFile)
        let sdkSwiftModel = api.convertToSwift()
        let generator = CodeGenerator(swiftApi: sdkSwiftModel)
        generator.generate()
        try changeReadMeSDKVersion(sdkSwiftModel)
    }

    private func changeReadMeSDKVersion(_ sdkSwiftModel: SDKSwiftApi) throws {
        let readMePath: String = "./../README.md"
        let readMeURL: URL = URL(fileURLWithPath: readMePath)
        var fileText: String = try FileUtils.readFile(readMeURL)
        fileText.replaceSelf(#"VERSION-.+?-orange"#, "VERSION-\(sdkSwiftModel.version)-orange")
        try FileUtils.writeFile(to: readMeURL, fileText.data(using: .utf8))
    }
}

ApiParser.main()
