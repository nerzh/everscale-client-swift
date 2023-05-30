//
//  ErrorsTests.swift
//  
//
//  Created by Oleh Hudeichuk on 17.09.2022.
//

import XCTest
import class Foundation.Bundle
@testable import EverscaleClientSwift
@testable import CTonSDK

final class ErrorsTests: XCTestCase {
    
    func testClientError() throws {
        try testAsyncMethods { (client, group) in
            let paramsOfQueryCollection: TSDKParamsOfQueryCollection = .init(collection: "accounts",
                                                                             filter: [
                                                                                "id": [
                                                                                    "eq": "0:b5e9240fc2d2f1ff8cbb1d1dee7fb7cae155e5f6320e585fcc685698994a19a5"
                                                                                ]
                                                                             ].toAnyValue(),
                                                                             result: "boc")
            group.enter()
            do {
                try client.net.query_collection(paramsOfQueryCollection) { [group] response in
                    if response.error != nil {
                        group.leave()
                    } else {
                        throw TSDKClientError("FATAL ERROR")
                    }
                }
            } catch {
                group.leave()
            }
            group.wait()
        }
    }
}
