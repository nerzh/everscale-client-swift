//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 20.10.2020.
//

import Foundation
import TonClientSwift
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
        /// Please, set custom working directory to project folder for your xcode scheme. This is necessary for the relative path "./" to the project folders to work.
        /// You may change it with the xcode edit scheme menu.
        /// Or inside file path_to_ton_sdk/.swiftpm/xcode/xcshareddata/xcschemes/TonSDK.xcscheme
        /// set to tag "LaunchAction" absolute path to this library with options:
        /// useCustomWorkingDirectory = "YES"
        /// customWorkingDirectory = "/path_to_ton_sdk"
        let workingDirectory: String = "./"
        if !FileManager.default.fileExists(atPath: workingDirectory) {
            fatalError("\(workingDirectory) directory is not exist")
        }
        return workingDirectory
    }

    func testAsyncMethods<V>(_ handler: @escaping (_ client: TSDKClientModule, _ group: DispatchGroup) -> V) -> V {
        var config: TSDKClientConfig = .init()
        config.network = TSDKNetworkConfig(server_address: SimpleEnv["server_address"] ?? "")
        let client: TSDKClientModule = .init(config: config)
        let group: DispatchGroup = .init()
        return handler(client, group)
    }

    @discardableResult
    func getGramsFromGiverSync(_ client: TSDKClientModule,
                               _ accountAddress: String? = nil,
                               _ value: Int = 10_000_000_000
    ) -> Bool {
        guard let server_address = client.config.network?.server_address else {
            Log.warn("Please, set client network for Giver work!")
            return false
        }

        if server_address[#"localhost"#] || server_address[#"127\.0\.0\.1"#] {
            return self.getGramsFromGiverSyncNodeSE(client, accountAddress ?? testAddr, value)
        } else if server_address[#"net\.ton\.dev"#] {
            return self.getGramsFromGiverSyncNetDev(client, accountAddress ?? testAddr, value)
        } else {
            Log.warn("No Giver for this network: \(server_address)")
        }

        return false
    }

    func checkPositiveBallance(_ client: TSDKClientModule, _ accountAddress: String) -> Bool {
        var tokensReceived: Bool = false
        var fuseCounter: Int = 0
        let group: DispatchGroup = .init()
        var isPositiveBalance: Bool = false
        while !tokensReceived {
            group.enter()
            let paramsOfWaitForCollection: TSDKParamsOfWaitForCollection = .init(collection: "accounts",
                                                                                 filter: .object(["id": .object(
                                                                                                    [
                                                                                                        "eq": .string(accountAddress)
                                                                                                    ])
                                                                                 ]),
                                                                                 result: "id balance(format: DEC)",
                                                                                 timeout: nil)
            client.net.wait_for_collection(paramsOfWaitForCollection) { (response) in
                if let result = response.result?.result.toDictionary(), let balance: Int = Int(result["balance"] as? String ?? "") {
                    if balance > 0 {
                        tokensReceived = true
                        isPositiveBalance = true
                    }
                }
                if response.finished {
                    group.leave()
                }
            }
            group.wait()
            fuseCounter += 1
            if fuseCounter > 20 && !tokensReceived {
                tokensReceived = true
                isPositiveBalance = false
                XCTAssertTrue(false, "Tokens does not received form giver")
            }
        }
        return isPositiveBalance
    }

    func getGramsFromGiverSyncNetDev(_ client: TSDKClientModule,
                                     _ accountAddress: String,
                                     _ value: Int? = nil
    ) -> Bool {
        let walletAddress: String = SimpleEnv["giver_address"] ?? ""
        let abiJSONValue: AnyValue = self.readAbi(SimpleEnv["giver_abi_name"] ?? "")
        let abi: TSDKAbi = .init(type: .Serialized, value: abiJSONValue)
        let callSetInput: AnyValue = .object(["addr" : .string(accountAddress)])
        let callSet: TSDKCallSet = .init(function_name: SimpleEnv["giver_function"] ?? "", header: nil, input: callSetInput)
        let paramsOfEncodedMessage: TSDKParamsOfEncodeMessage = .init(abi: abi,
                                                                      address: walletAddress,
                                                                      deploy_set: nil,
                                                                      call_set: callSet,
                                                                      signer: TSDKSigner(type: .None),
                                                                      processing_try_index: nil)
        let sendPaylod: TSDKParamsOfProcessMessage = .init(message_encode_params: paramsOfEncodedMessage, send_events: false)
        let group: DispatchGroup = .init()
        group.enter()
        client.processing.process_message(sendPaylod) { (response) in
            if response.finished {
                group.leave()
            }
        }
        group.wait()
        return checkPositiveBallance(client, accountAddress)
    }

    func getGramsFromGiverSyncNodeSE(_ client: TSDKClientModule,
                                     _ accountAddress: String,
                                     _ value: Int = 10_000_000_000
    ) -> Bool {
        let walletAddress: String = SimpleEnv["giver_address"] ?? ""
        let abiJSONValue: AnyValue = self.readAbi(SimpleEnv["giver_abi_name"] ?? "")
        let abi: TSDKAbi = .init(type: .Serialized, value: abiJSONValue)
        let callSetInput: AnyValue = .object(["dest" : .string(accountAddress), "amount": .int(Int(SimpleEnv["giver_amount"] ?? "") ?? value)])
        let callSet: TSDKCallSet = .init(function_name: SimpleEnv["giver_function"] ?? "", header: nil, input: callSetInput)
        let paramsOfEncodedMessage: TSDKParamsOfEncodeMessage = .init(abi: abi,
                                                                      address: walletAddress,
                                                                      deploy_set: nil,
                                                                      call_set: callSet,
                                                                      signer: TSDKSigner(type: .None),
                                                                      processing_try_index: nil)
        let sendPaylod: TSDKParamsOfProcessMessage = .init(message_encode_params: paramsOfEncodedMessage, send_events: false)
        let group: DispatchGroup = .init()
        group.enter()
        client.processing.process_message(sendPaylod) { (response) in
            if response.finished {
                group.leave()
            }
        }
        group.wait()
        return checkPositiveBallance(client, accountAddress)
    }


    func abiEncodeMessage(nameAbi: String,
                          nameTvc: String?,
                          address: String?,
                          public: String?,
                          secret: String?,
                          signerType: TSDKSignerEnumTypes,
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
                deploySet = .init(tvc: tvcData.base64EncodedString(), workchain_id: nil, initial_data: nil)
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
                signer = .init(type: .None)
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
        let abiJSON: String = pathToRootDirectory + "/Tests/TonClientSwiftTests/Fixtures/abi/\(name).abi.json"
        var abiText: String = .init()
        DOFileReader.readFile(abiJSON) { (line) in
            abiText.append(line)
        }
        guard let any = abiText.toAnyValue() else { fatalError("AbiJSON Not Parsed From File") }

        return any
    }

    func readTvc(_ name: String) -> Data {
        let tvc: String = pathToRootDirectory + "/Tests/TonClientSwiftTests/Fixtures/abi/\(name).tvc"
        guard let data = FileManager.default.contents(atPath: tvc) else { fatalError("tvc not read") }

        return data
    }

    func generateAbiAndTvc(_ name: String) -> (abiJSON: AnyValue, tvc: Data) {
        let any: AnyValue = readAbi(name)
        let data: Data = readTvc(name)

        return (abiJSON: any, tvc: data)
    }

}
