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
            let any = AnyValue.object(
                [
                    "created_at" : AnyValue.object(
                        [
                            "gt" : AnyValue.int(1562342740)
                        ])
                ])
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

    func testWait_for_collection() throws {
        testAsyncMethods { (client, group) in
            let now: Int = Int(Date().timeIntervalSince1970)
            let any = AnyValue.object(
                [
                    "now" : AnyValue.object(
                        [
                            "gt" : AnyValue.int(now)
                        ])
                ])
            let payload: TSDKParamsOfWaitForCollection = .init(collection: "transactions",
                                                                    filter: any,
                                                                    result: "id now",
                                                                    timeout: nil)
            client.net.wait_for_collection(payload) { [group] (response) in
                if let json = response.result?.result.jsonValue as? [String: Any],
                   let thisNow = (json["now"] as? AnyJSONType)?.jsonValue as? Int
                {
                    XCTAssertTrue(thisNow > now)
                } else {
                    XCTAssertTrue(false, "No Data")
                }
                group.leave()
            }
            group.wait()
        }
    }

    func testSubscribe_collection() throws {
        testAsyncMethods { (client, group) in
            let any = AnyValue.object(
                [
                    "account_addr" : AnyValue.object(
                        [
                            "eq" : AnyValue.string("")
                        ]),
                    "status" : AnyValue.object(
                        [
                            "eq" : AnyValue.string("")
                        ])
                ])
            let payload: TSDKParamsOfSubscribeCollection = .init(collection: "transactions",
                                                                      filter: any,
                                                                      result: "id account_addr")
            return
            client.net.subscribe_collection(payload) { [group] (response) in
                Log(response)
//                XCTAssertTrue(false, "No Data")
//                if let json = response.result?.result.jsonValue as? [String: Any],
//                   let thisNow = (json["now"] as? AnyJSONType)?.jsonValue as? Int
//                {
//                    XCTAssertTrue(thisNow > now)
//                } else {
//                    XCTAssertTrue(false, "No Data")
//                }
                if response.finished {
                    group.leave()
                }
            }
            group.wait()
        }
    }
}
