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



//struct


final class AbiTests: XCTestCase {

    func testEncode_message_body() throws {
        let abiJSON: String = "/Users/nerzh/mydata/trash/swift/ton-sdk/Tests/TonSDKTests/Fixtures/abi/Events.abi.json"
        var abiEventsText: String = .init()
        DOFileReader.readFile(abiJSON) { (line) in
            abiEventsText.append(line)
        }
        abiEventsText.replaceSelf(#"\n"#, "")
        testAsyncMethods { (client, group) in
            guard let any = abiEventsText.toAnyValue() else {
                XCTAssertFalse(true, "AbiJSON Not Parsed From File")
                return
            }
            let abi: TSDKAbiData = .init(type: .Serialized, value: any)
            let singer: TSDKSigner = .init(type: .Keys,
                                           public_key: nil,
                                           keys: TSDKKeyPair(public: "4c7c408ff1ddebb8d6405ee979c716a14fdd6cc08124107a61d3c25597099499", secret: "cc8929d635719612a9478b9cd17675a39cfad52d8959e8a177389b8c0b9122a7"),
                                           handle: nil)
            let callSet: TSDKCallSet = .init(function_name: "constructor",
                                             header: TSDKFunctionHeader(expire: 1599458404, time: 1599458364291, pubkey: "4c7c408ff1ddebb8d6405ee979c716a14fdd6cc08124107a61d3c25597099499"),
                                             input: nil)
            let payload: TSDKParamsOfEncodeMessageBody = .init(abi: abi, call_set: callSet, is_internal: false, signer: singer, processing_try_index: nil)
            client.abi.encode_message_body(payload) { [group] (response) in
                XCTAssertEqual(response.result?.body, "te6ccgEBAQEAcwAA4bE5Gr3mWwDtlcEOWHr6slWoyQlpIWeYyw/00eKFGFkbAJMMFLWnu0mq4HSrPmktmzeeAboa4kxkFymCsRVt44dTHxAj/Hd67jWQF7peccWoU/dbMCBJBB6YdPCVZcJlJkAAAF0ZyXLg19VzGRotV8/g")
                group.leave()
            }
            group.wait()
        }
    }
}
