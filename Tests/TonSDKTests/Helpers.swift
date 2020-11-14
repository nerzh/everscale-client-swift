//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 20.10.2020.
//

import Foundation
import TonSDK
import XCTest
import SwiftRegularExpression

extension XCTestCase {

    var testAddr: String { "0:9cb911799a34982a27cb577ce694843f60b9e09fcba4f7fd7e040730acd59baa" }

    class Log {

        class func log(_ str: Any...) {
            print("❇️ logi:", str)
        }

        class func warn(_ str: Any...) {
            print("⚠️ logi:", str)
        }
    }

    var pathToRootDirectory: String {
        let directory: String = "/Users/nerzh/mydata/trash/swift/ton-sdk"
        if !FileManager.default.fileExists(atPath: directory) {
            fatalError("\(directory) directory is not exist")
        }
        return directory
    }

    func testAsyncMethods<V>(_ handler: @escaping (_ client: TSDKClientModule, _ group: DispatchGroup) -> V) -> V {
        var config: TSDKClientConfig = .init()
        //        config.network = TSDKNetworkConfig(server_address: "https://net.ton.dev")
        config.network = TSDKNetworkConfig(server_address: "http://localhost:80")
        let client: TSDKClientModule = .init(config: config)
        let group: DispatchGroup = .init()
        return handler(client, group)
    }

    func getGramsFromGiverSync(_ client: TSDKClientModule,
                               _ accountAddress: String? = nil,
                               _ value: Int = 10_000_000_000,
                               _ handler: @escaping (TSDKBindingResponse<TSDKResultOfProcessMessage, TSDKClientError, TSDKDefault>?) -> Void
    ) {
        guard let server_address = client.config.network?.server_address else {
            Log.warn("Please, set client network for Giver work!")
            handler(nil)
            return
        }

        if server_address[#"localhost"#] || server_address[#"127\.0\.0\.1"#] {
            self.getGramsFromGiverSyncNodeSE(client, accountAddress ?? testAddr, value, handler)
        } else if server_address[#"net\.ton\.dev"#] {
            self.getGramsFromGiverSyncNetDev(client, accountAddress ?? testAddr, value, handler)
        } else {
            Log.warn("No Giver for this network: \(server_address)")
            handler(nil)
        }
    }

    func getGramsFromGiverSyncNetDev(_ client: TSDKClientModule,
                                     _ accountAddress: String,
                                     _ value: Int? = nil,
                                     _ handler: @escaping (TSDKBindingResponse<TSDKResultOfProcessMessage, TSDKClientError, TSDKDefault>?) -> Void
    ) {
        let walletAddress: String = "0:653b9a6452c7a982c6dc92b2da9eba832ade1c467699ebb3b43dca6d77b780dd"
        let abiJSONValue: AnyValue = self.readAbi("Giver")
        let abi: TSDKAbi = .init(type: .Serialized, value: abiJSONValue)
        let callSetInput: AnyValue = .object(["addr" : .string(accountAddress)])
        let callSet: TSDKCallSet = .init(function_name: "grant", header: nil, input: callSetInput)
        let paramsOfEncodedMessage: TSDKParamsOfEncodeMessage = .init(abi: abi,
                                                                      address: walletAddress,
                                                                      deploy_set: nil,
                                                                      call_set: callSet,
                                                                      signer: TSDKSigner(),
                                                                      processing_try_index: nil)
        let sendPaylod: TSDKParamsOfProcessMessage = .init(message_encode_params: paramsOfEncodedMessage, send_events: false)
        let group: DispatchGroup = .init()
        group.enter()
        var resultResponse: TSDKBindingResponse<TSDKResultOfProcessMessage, TSDKClientError, TSDKDefault>?
        client.processing.process_message(sendPaylod) { (response) in
            if !response.finished {
                resultResponse = response
            }
            if response.finished {
                BindingStore.deleteResponseHandler(response.requestId)
                group.leave()
            }
        }
        group.wait()
        handler(resultResponse)
    }

    func getGramsFromGiverSyncNodeSE(_ client: TSDKClientModule,
                                     _ accountAddress: String,
                                     _ value: Int = 10_000_000_000,
                                     _ handler: @escaping (TSDKBindingResponse<TSDKResultOfProcessMessage, TSDKClientError, TSDKDefault>?) -> Void
    ) {
        let walletAddress: String = "0:841288ed3b55d9cdafa806807f02a0ae0c169aa5edfe88a789a6482429756a94"
        let abiJSONValue: AnyValue = self.readAbi("GiverNodeSE")
        let abi: TSDKAbi = .init(type: .Serialized, value: abiJSONValue)
        let callSetInput: AnyValue = .object(["dest" : .string(accountAddress), "amount": .int(value)])
        let callSet: TSDKCallSet = .init(function_name: "sendGrams", header: nil, input: callSetInput)
        let paramsOfEncodedMessage: TSDKParamsOfEncodeMessage = .init(abi: abi,
                                                                      address: walletAddress,
                                                                      deploy_set: nil,
                                                                      call_set: callSet,
                                                                      signer: TSDKSigner(),
                                                                      processing_try_index: nil)
        let sendPaylod: TSDKParamsOfProcessMessage = .init(message_encode_params: paramsOfEncodedMessage, send_events: false)
        let group: DispatchGroup = .init()
        group.enter()
        var resultResponse: TSDKBindingResponse<TSDKResultOfProcessMessage, TSDKClientError, TSDKDefault>?
        client.processing.process_message(sendPaylod) { (response) in
            if !response.finished {
                resultResponse = response
            }
            if response.finished {
                BindingStore.deleteResponseHandler(response.requestId)
                group.leave()
            }
            group.wait()
            handler(resultResponse)
        }
    }


    func abiEncodeMessage(nameAbi: String,
                          nameTvc: String?,
                          address: String?,
                          public: String?,
                          secret: String?,
                          signerType: TSDKSignerType,
                          callSetFunction_name: String?,
                          callSetHeader: TSDKFunctionHeader?,
                          callSetInput: AnyValue?
    ) -> TSDKResultOfEncodeMessage {
        testAsyncMethods { (client, group) -> TSDKResultOfEncodeMessage in
            let abiJSONValue: AnyValue = self.readAbi(nameAbi)
            let abi: TSDKAbi = .init(type: .Serialized, value: abiJSONValue)
            var deploySet: TSDKDeploySet?

            var keys: TSDKKeyPair?
            var callSet: TSDKCallSet?
            var signer: TSDKSigner!
            if nameTvc != nil {
                let tvcData: Data = self.readTvc(nameTvc!)
                deploySet = .init(tvc: tvcData, workchain_id: nil, initial_data: nil)
            }
            if `public` != nil && secret != nil {
                keys = .init(public: `public`!, secret: secret!)
            }
            switch signerType {
            case .External:
                signer = .init(type: signerType,
                               public_key: `public`,
                               keys: nil,
                               handle: nil)
            case .Keys:
                signer = .init(type: signerType,
                               public_key: nil,
                               keys: keys,
                               handle: nil)
            default:
                signer = .init()
            }
            if callSetFunction_name != nil {
                callSet = .init(function_name: callSetFunction_name!,
                                header: callSetHeader,
                                input: callSetInput)
            }

            let payload: TSDKParamsOfEncodeMessage = .init(abi: abi,
                                                           address: address,
                                                           deploy_set: deploySet,
                                                           call_set: callSet,
                                                           signer: signer,
                                                           processing_try_index: nil)
            var result: TSDKResultOfEncodeMessage!
            group.enter()
            client.abi.encode_message(payload) { [group] (response) in
                guard let responseResult = response.result else { fatalError("Abi EncodeMessage is nil") }
                result = responseResult
                group.leave()
            }
            group.wait()

            return result
        }
    }

    func generateKeys() -> TSDKKeyPair {
        testAsyncMethods { (client, group) in
            group.enter()
            var keys: TSDKKeyPair = .init(public: "", secret: "")
            client.crypto.generate_random_sign_keys() { [group] (response) in
                guard let result = response.result else { fatalError("BAD SDK RESPONSE") }
                keys.public = result.public
                keys.secret = result.secret
                group.leave()
            }
            group.wait()
            return keys
        }
    }

    func readAbi(_ name: String) -> AnyValue {
        let abiJSON: String = pathToRootDirectory + "/Tests/TonSDKTests/Fixtures/abi/\(name).abi.json"
        var abiText: String = .init()
        DOFileReader.readFile(abiJSON) { (line) in
            abiText.append(line)
        }
        guard let any = abiText.toAnyValue() else { fatalError("AbiJSON Not Parsed From File") }

        return any
    }

    func readTvc(_ name: String) -> Data {
        let tvc: String = pathToRootDirectory + "/Tests/TonSDKTests/Fixtures/abi/\(name).tvc"
        guard let data = FileManager.default.contents(atPath: tvc) else { fatalError("tvc not read") }

        return data
    }

    func generateAbiAndTvc(_ name: String) -> (abiJSON: AnyValue, tvc: Data) {
        let any: AnyValue = readAbi(name)
        let data: Data = readTvc(name)

        return (abiJSON: any, tvc: data)
    }

}
