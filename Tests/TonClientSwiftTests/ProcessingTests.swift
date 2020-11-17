//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 27.10.2020.
//

import XCTest
import class Foundation.Bundle
@testable import TonClientSwift
@testable import CTonSDK

final class ProcessingTests: XCTestCase {

    func testWait_for_transaction() throws {
        testAsyncMethods { (client, group) in
            let tvcData: Data = self.readTvc("Events")
            let abiJSONValue: AnyValue = self.readAbi("Events")
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
            var encodedMessage: TSDKResultOfEncodeMessage!
            group.enter()
            client.abi.encode_message(payloadEncodeMessage) { [group] (response) in
                guard let responseResult = response.result else {
                    XCTAssertTrue(response.result?.address != nil, "Must be not nil")
                    return
                }
                encodedMessage = responseResult
                BindingStore.deleteResponseHandler(response.requestId)
                group.leave()
            }
            group.wait()
            Log.warn("address - ", encodedMessage.address)

            self.getGramsFromGiverSync(client, encodedMessage.address)

            let paramsOfSendMessage: TSDKParamsOfSendMessage = .init(message: encodedMessage.message, abi: abi, send_events: true)
            var maybeResultOfSendMessage: TSDKResultOfSendMessage?
            group.enter()
            client.processing.send_message(paramsOfSendMessage) { (response) in
                if response.result != nil {
                    maybeResultOfSendMessage = response.result
                }
                if response.finished {
                    group.leave()
                }
            }
            group.wait()
            guard let resultOfSendMessage = maybeResultOfSendMessage else {
                XCTAssertTrue(false, "resultOfSendMessage is nil")
                return
            }

            let paramsOfWaitForTransaction: TSDKParamsOfWaitForTransaction = .init(abi: abi,
                                                                                   messageEncodedBase64: encodedMessage.message,
                                                                                   shard_block_id: resultOfSendMessage.shard_block_id,
                                                                                   send_events: true)
            var resultOfProcessMessage: TSDKResultOfProcessMessage?
            group.enter()
            client.processing.wait_for_transaction(paramsOfWaitForTransaction) { (response) in

                if response.result != nil {
                    resultOfProcessMessage = response.result
                }
                if response.finished {
                    group.leave()
                }
            }
            group.wait()
            XCTAssertEqual(resultOfProcessMessage?.out_messages.count, 0)
            XCTAssertEqual(resultOfProcessMessage?.decoded, TSDKDecodedOutput(out_messages: [], output: nil))
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
                group.leave()
            }
            group.wait()
            Log.warn("address - ", result.address)

            self.getGramsFromGiverSync(client, result.address)

            let payloadProcessMessage: TSDKParamsOfProcessMessage = .init(message_encode_params: payloadEncodeMessage, send_events: true)
            group.enter()

            var resultOfProcessMessage: TSDKResultOfProcessMessage?
            client.processing.process_message(payloadProcessMessage) { [group] (response) in
                if let result = response.result {
                    resultOfProcessMessage = result
                }
                if response.finished {
                    group.leave()
                }
            }
            group.wait()
            if let resultOfProcessMessage = resultOfProcessMessage {
                XCTAssertTrue(resultOfProcessMessage.fees.total_account_fees > 0)
                XCTAssertEqual(resultOfProcessMessage.out_messages.count, 0)
                XCTAssertEqual(resultOfProcessMessage.decoded, TSDKDecodedOutput(out_messages: [], output: nil))
            } else {
                XCTAssertTrue(false, "resultOfProcessMessage is nil")
            }
        }
    }
}
