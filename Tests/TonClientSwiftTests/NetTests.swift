//
//  File.swift
//
//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import XCTest
import class Foundation.Bundle
@testable import TonClientSwift
@testable import CTonSDK

final class NetTests: XCTestCase {

    func testQuery_collection() throws {
        testAsyncMethods { (client, group) in
            group.enter()
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
            group.enter()
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
            Thread {
                usleep(1_000_000)
                for _ in 1...5 {
                    self.getGramsFromGiverSync(client)
                }
            }.start()
            group.wait()
        }
    }

    func testSubscribe_collection() throws {
        testAsyncMethods { (client, group) in
            group.enter()
            //            let finalizedStatus: Int = 3
            //            let anyFilter = AnyValue.object(
            //                [
            //                    "account_addr" : AnyValue.object(["eq" : AnyValue.string(address)]),
            //                    "status" : AnyValue.object(["eq" : AnyValue.int(finalizedStatus)])
            //                ])
            let payload: TSDKParamsOfSubscribeCollection = .init(collection: "transactions",
                                                                 filter: nil,
                                                                 result: "id account_addr")
            client.net.subscribe_collection(payload) { [group] (response) in
                if response.result != nil {
                    XCTAssertTrue(response.result?.handle != nil)
                    BindingStore.deleteResponseHandler(response.requestId)
                    group.leave()
                    return
                } else if let result = response.customResponse?.result?.jsonValue as? [String: AnyJSONType],
                          let account_addr = result["account_addr"]
                {
                    XCTAssertTrue((account_addr.jsonValue as? String) != nil)
                }
                if response.finished || response.customResponse != nil {
                    BindingStore.deleteResponseHandler(response.requestId)
                    group.leave()
                }
            }
            group.wait()
        }
    }


    func testUnsubscribe() throws {
        testAsyncMethods { (client, group) in
            /// groupCounter - for safe exit from response if execute "UNSUBSCRIBE THREAD"
            var groupCounter: Int = .init()
            let groupCounterLock: NSLock = .init()

            group.enter()
            groupCounter += 1
            let payload: TSDKParamsOfSubscribeCollection = .init(collection: "transactions",
                                                                 filter: nil,
                                                                 result: "id account_addr")
            var handle: Int = .init()
            var requestId: UInt32 = .init()
            let handleGroup: DispatchGroup = .init()
            handleGroup.enter()
            client.net.subscribe_collection(payload) { [group, handleGroup, groupCounterLock] (response) in
                if response.result != nil {
                    XCTAssertTrue(response.result?.handle != nil)
                    handle = response.result?.handle ?? 0
                    requestId = response.requestId
                    handleGroup.leave()
                }
                groupCounterLock.lock()
                if response.finished {
                    BindingStore.deleteResponseHandler(response.requestId)
                    if groupCounter > 0 {
                        groupCounter -= 1
                        group.leave()
                    }
                }
                groupCounterLock.unlock()
            }

            Thread { [group, requestId, groupCounterLock] in
                sleep(5)
                groupCounterLock.lock()
                if groupCounter > 0 {
                    groupCounter -= 1
                    BindingStore.deleteResponseHandler(requestId)
                    XCTAssertTrue(false, "NOT UNSUBSCRIBED")
                    group.leave()
                }
                groupCounterLock.unlock()
            }.start()
            handleGroup.wait()

            group.enter()
            groupCounter += 1
            let payloadUnsubscribe: TSDKResultOfSubscribeCollection = .init(handle: handle)
            client.net.unsubscribe(payloadUnsubscribe) { [group, groupCounterLock] (response) in
                groupCounterLock.lock()
                if groupCounter > 0 {
                    groupCounter -= 1
                    group.leave()
                }
                groupCounterLock.unlock()
            }
            group.wait()
        }
    }
}
