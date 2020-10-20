//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 20.10.2020.
//

import XCTest
import class Foundation.Bundle
@testable import TonSDK
@testable import CTonSDK

final class CryptoTests: XCTestCase {

    func testFactorize() throws {
        var client: TSDKClient = .init(config: ClientConfig())
        client.crypto.factorize(TSDKParamsOfFactorize(composite: "17ED48941A08F981")) { (response) in
//            print("resp", response.result?.factors)
            XCTAssertEqual(response.result?.factors, ["494C553B", "53911073"])
        }
        sleep(2)
//        XCTAssertEqual(string.len, 9)
    }
}

