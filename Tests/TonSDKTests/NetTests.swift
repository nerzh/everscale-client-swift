//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import XCTest
import class Foundation.Bundle
@testable import TonSDK
@testable import CTonSDK

final class NetTests: XCTestCase {

    func testQuery_collection() throws {
        testAsyncMethods { (client, group) in
            let any = AnyEncodable(value: ["created_at": ["gt": 1562342740]])
            let payload: TSDKParamsOfQueryCollection = .init(collection: "messages",
                                                             filter: any,
                                                             result: "body created_at",
                                                             order: nil,
                                                             limit: nil)
            client.net.query_collection(payload) { [group] (response) in
                if let first = response.result?.result.first?.jsonValue as? [String: Any] {
                    let created_at: Int? = (first["created_at"] as? AnyJSONType)?.jsonValue as? Int
                    XCTAssertTrue(created_at ?? 0 > 1562342740)
                } else {
                    XCTAssertTrue(false, "No Data")
                }
                group.leave()
            }
            group.wait()
        }
    }
}
