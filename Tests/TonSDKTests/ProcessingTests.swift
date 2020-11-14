//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 27.10.2020.
//

import XCTest
import class Foundation.Bundle
@testable import TonSDK
@testable import CTonSDK

final class ProcessingTests: XCTestCase {

    func testWait_for_transaction() throws {
        testAsyncMethods { (client, group) in
            group.enter()
            let tvcData: Data = self.generateAbiAndTvc("Events").tvc
            let abiJSONValue: AnyValue = self.generateAbiAndTvc("Events").abiJSON
            let keys: TSDKKeyPair = self.generateKeys()
            let abi: TSDKAbi = .init(type: .Serialized, value: abiJSONValue)
            let signer: TSDKSigner = .init(type: .Keys,
                                           public_key: nil,
                                           keys: keys,
                                           handle: nil)
            let callSet: TSDKCallSet = .init(function_name: "constructor",
                                             header: TSDKFunctionHeader(expire: nil,
                                                                        time: nil,
                                                                        pubkey: keys.public),
                                             input: nil)
            let deploySet: TSDKDeploySet = .init(tvc: tvcData, workchain_id: nil, initial_data: nil)
            let payloadEncodeMessage: TSDKParamsOfEncodeMessage = .init(abi: abi,
                                                                        address: nil,
                                                                        deploy_set: deploySet,
                                                                        call_set: callSet,
                                                                        signer: signer,
                                                                        processing_try_index: nil)
            var result: TSDKResultOfEncodeMessage!
            client.abi.encode_message(payloadEncodeMessage) { [group] (response) in
                guard let responseResult = response.result else {
                    XCTAssertTrue(response.result?.address != nil, "Must be not nil")
                    return
                }
                result = responseResult
                group.leave()
            }
            group.wait()
            XCTAssertTrue(false)
        }
    }

    func testProcess_mesage() throws {
        testAsyncMethods { (client, group) in
            let tvcData: Data = self.generateAbiAndTvc("Events").tvc
            let abiJSONValue: AnyValue = self.generateAbiAndTvc("Events").abiJSON
            let abi: TSDKAbi = .init(type: .Serialized, value: abiJSONValue)
            let keys: TSDKKeyPair = self.generateKeys()
            let signer: TSDKSigner = .init(type: .Keys,
                                           public_key: nil,
                                           keys: keys,
                                           handle: nil)
            let callSet: TSDKCallSet = .init(function_name: "constructor",
                                             header: TSDKFunctionHeader(expire: nil,
                                                                        time: nil,
                                                                        pubkey: keys.public),
                                             input: nil)
            let deploySet: TSDKDeploySet = .init(tvc: tvcData, workchain_id: nil, initial_data: nil)
            let payloadEncodeMessage: TSDKParamsOfEncodeMessage = .init(abi: abi,
                                                                        address: nil,
                                                                        deploy_set: deploySet,
                                                                        call_set: callSet,
                                                                        signer: signer,
                                                                        processing_try_index: nil)
            var result: TSDKResultOfEncodeMessage!
            group.enter()
            client.abi.encode_message(payloadEncodeMessage) { [group] (response) in
                guard let responseResult = response.result else {
                    XCTAssertTrue(response.result?.address != nil, "Must be not nil")
                    return
                }
                result = responseResult
                BindingStore.deleteResponseHandler(response.requestId)
                group.leave()
            }
            group.wait()
            Log.warn("address - ", result.address)

//            group.enter()
            self.getGramsFromGiverSync(client, result.address) { (response) in
                if let response = response, !response.finished {
                    XCTAssertTrue(response.result != nil)
                    BindingStore.deleteResponseHandler(response.requestId)
//                    group.leave()
                }
            }
            group.wait()
        }
    }
}
