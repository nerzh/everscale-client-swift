//
//  Created by Oleh Hudeichuk on 17.11.2020.
//

import Foundation
import SwiftRegularExpression

public final class SimpleEnv {

    private static var env: [String: String] = .init()
    private static let debugEnvName: String = "debug"
    private static let adhocEnvName: String = "production"
    private static let productionEnvName: String = "production"

    public class subscript(_ key: String) -> String? {
        if env.count == 0 {
            parseEnv()
        }
        return env[key]
    }

    private class func parseEnv() {
        #if DEBUG
        let environment: String = debugEnvName
        #elseif ADHOC
        let environment: String = adhocEnvName
        #else
        let environment: String = productionEnvName
        #endif

        let envFileName: String = ".env.\(environment)"
        let envFilePath: String = "./\(envFileName)"
        if !FileManager.default.fileExists(atPath: envFilePath) { return }

        DOFileReader.readFile("./\(envFileName)") { (line) in
            var line = line.trimmingCharacters(in: .whitespacesAndNewlines)
            let matchesWithQuotes: [Int: String] = line.regexp(#"\"([\s\S]+)\"\s*=\s*\"([\s\S]+)\""#)
            if line[#"^\/\/"#] { return }
            if let key: String = matchesWithQuotes[1], let value: String = matchesWithQuotes[2] {
                env[key] = value
                return
            }
            let matchesWithOutQuotes: [Int: String] = line.regexp(#"([\s\S]+)\s*=\s*([\s\S]+)"#)
            if let key: String = matchesWithOutQuotes[1], let value: String = matchesWithOutQuotes[2] {
                env[key] = value
            }
        }
    }
}
