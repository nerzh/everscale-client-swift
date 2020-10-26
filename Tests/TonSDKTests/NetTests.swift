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
            group.enter()
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
            for i in 1...2 {
                if i > 1 { group.enter() }
                client.net.wait_for_collection(payload) { [group] (response) in
                    if let json = response.result?.result.jsonValue as? [String: Any],
                       let thisNow = (json["now"] as? AnyJSONType)?.jsonValue as? Int
                    {
                        XCTAssertTrue(thisNow > now)
                    } else {
                        Log.warn(response.requestId)
                        XCTAssertTrue(false, "No Data")
                    }
                    group.leave()
                }
            }
            group.wait()
        }
    }

    func testSubscribe_collection() throws {
        testAsyncMethods { (client, group) in
            let abiJSONEvents: String = "/Users/nerzh/mydata/trash/swift/ton-sdk/Tests/TonSDKTests/Fixtures/abi/Hello.abi.json"
            let tvcEvents: String = "/Users/nerzh/mydata/trash/swift/ton-sdk/Tests/TonSDKTests/Fixtures/abi/Hello.tvc"
            var abiEventsText: String = .init()
            DOFileReader.readFile(abiJSONEvents) { (line) in
                abiEventsText.append(line)
            }
            guard let data = FileManager.default.contents(atPath: tvcEvents) else { fatalError("tvcEvents not read") }
            guard let any = abiEventsText.toAnyValue() else {
                XCTAssertFalse(true, "AbiJSON Not Parsed From File")
                return
            }
            group.enter()
            var keys: TSDKKeyPair = .init(public: "", secret: "")
            client.crypto.generate_random_sign_keys() { [group] (response) in
                XCTAssertTrue(response.result?.public != nil)
                XCTAssertTrue(response.result?.secret != nil)
                XCTAssertEqual(response.result?.public.count, 64)
                XCTAssertEqual(response.result?.secret.count, 64)
                keys.public = response.result?.public ?? ""
                keys.secret = response.result?.secret ?? ""
                group.leave()
            }
            group.wait()

            group.enter()
            let abi: TSDKAbiData = .init(type: .Serialized, value: any)
            let signer: TSDKSigner = .init(type: .Keys,
                                           public_key: nil,
                                           keys: keys,
                                           handle: nil)
            let callSet: TSDKCallSet = .init(function_name: "constructor",
                                             header: TSDKFunctionHeader(expire: 1599458404,
                                                                        time: 1599458364291,
                                                                        pubkey: keys.public),
                                             input: nil)
            let deploySet: TSDKDeploySet = .init(tvc: data, workchain_id: nil, initial_data: nil)
            let payloadEncodeMessage: TSDKParamsOfEncodeMessage = .init(abi: abi,
                                                                        address: nil,
                                                                        deploy_set: deploySet,
                                                                        call_set: callSet,
                                                                        signer: signer,
                                                                        processing_try_index: nil)
            var address: String = .init()
            client.abi.encode_message(payloadEncodeMessage) { [group] (response) in
                XCTAssertTrue(response.result?.address != nil, "Must be not nil")
                address = response.result?.address ?? ""
                group.leave()
            }
            group.wait()
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
