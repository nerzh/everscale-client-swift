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

final class AbiTests: XCTestCase {

    func testEncode_message_body() throws {
        testAsyncMethods { (client, group) in
            let any = AnyEncodable(value: 0)
            let abi: TSDKAbiData = .init(type: .Handle, value: any)
            let singer: TSDKSigner = .init(type: .Keys,
                                           public_key: nil,
                                           keys: TSDKKeyPair(public: "4c7c408ff1ddebb8d6405ee979c716a14fdd6cc08124107a61d3c25597099499", secret: "cc8929d635719612a9478b9cd17675a39cfad52d8959e8a177389b8c0b9122a7"),
                                           handle: nil)
            let callSet: TSDKCallSet = .init(function_name: "constructor",
                                             header: TSDKFunctionHeader(expire: 1599458404, time: 1599458364291, pubkey: "4c7c408ff1ddebb8d6405ee979c716a14fdd6cc08124107a61d3c25597099499"),
                                             input: nil)
            let payload: TSDKParamsOfEncodeMessageBody = .init(abi: abi, call_set: callSet, is_internal: true, signer: singer, processing_try_index: nil)
            client.abi.encode_message_body(payload) { [group] (response) in
                Log(response)
//                response.result.
//                XCTAssertEqual(response.result?.factors, ["494C553B", "53911073"])
                group.leave()
            }
            group.wait()
        }
    }
}
