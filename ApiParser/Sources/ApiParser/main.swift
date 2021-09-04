//
//  main.swift
//  
//
//  Created by Oleh Hudeichuk on 04.05.2021.
//

import ArgumentParser

struct ApiParser: ParsableCommand {

    @Argument(help: "Path to api json file.")
    var pathToApiFile: String

    mutating func run() throws {
        let api = try SDKApi.init(pathToApiFile)
        let r = api.convertToSwift()
        let generator = CodeGenerator(swiftApi: r)
        generator.generate()
    }
}

ApiParser.main()
