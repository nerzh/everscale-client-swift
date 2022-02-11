//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import XCTest
import class Foundation.Bundle
@testable import EverscaleClientSwift
@testable import CTonSDK

final class BindingTests: XCTestCase {

    func testConvertToTSDKString() throws {
        var string: TSDKString = .init()
        TSDKBindingModule.convertToTSDKString("Hello😀") { tsdkString in
            string = tsdkString
        }
        XCTAssertEqual(string.len, 9)
    }

    func testConvertFromTSDKString() throws {
        var swiftString: String = .init()
        TSDKBindingModule.convertToTSDKString("Hello😀") { tsdkString in
            swiftString = TSDKBindingModule.convertFromTSDKString(tsdkString)
        }
        XCTAssertEqual(swiftString, "Hello😀")
    }

    struct Test: Codable {
        var version: String
    }

    struct TestError: Codable {
        var code: UInt32
        var message: String
        var data: AnyValue
    }

    func testRequestLibraryAsync() throws {
        let binding: TSDKBindingModule = try .init()
        for _ in 1...500 {
            try binding.requestLibraryAsync("client.version", "{}") { (requestId, params, responseType, finished) in
                var response: TSDKBindingResponse<Test, TestError> = .init()
                response.update(requestId, params, responseType, finished)
                XCTAssertTrue(response.result?.version != nil)
                XCTAssertEqual(response.error?.message, nil)
            }
        }
        usleep(500000)
    }
}

