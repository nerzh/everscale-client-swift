//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import XCTest
import class Foundation.Bundle
@testable import TonSDK
@testable import CTonSDK

final class BindingTests: XCTestCase {

    func testConvertToTSDKString() throws {
        var string: TSDKString = .init()
        TSDKBinding.convertToTSDKString("Hello😀") { tsdkString in
            string = tsdkString
        }
        XCTAssertEqual(string.len, 9)
    }

    func testConvertFromTSDKString() throws {
        var swiftString: String = .init()
        TSDKBinding.convertToTSDKString("Hello😀") { tsdkString in
            swiftString = TSDKBinding.convertFromTSDKString(tsdkString)
        }
        XCTAssertEqual(swiftString, "Hello😀")
    }

    struct Test: Decodable {
        var result: String
    }

//    struct TestError: Decodable {
//        var code: UInt32
//        var message: String
//        var data: AnyJSONType
//    }



    func testRequestLibraryAsync() throws {

        let binding: TSDKBinding = .init()
        print("resp Start")
        binding.requestLibraryAsync("client.version", "{}") { (r: TSDKBindingResponse<Test, Test, Test>) in
            print("RESPONSE")
            print(r.result)
            print(r)
        }
        sleep(2)



//        let string = "{}"
//        let p = tc_create_context(tc_string_data_t(content: string, len: UInt32(string.bytes())))
//        let ctx = tc_read_string(p)
//        let str = String(cString: UnsafeRawPointer(ctx.content).bindMemory(to: CChar.self, capacity: Int(ctx.len)))
//        let h = str.toDictionary()
//        let id = h!["result"]! as! UInt32
//        print("resp id", id)
//        var mn = "client.version"
//
//        mn.getPointer { (p: UnsafePointer<Int8>, len: Int) in
//            let mns = tc_string_data_t(content: p, len: UInt32(len))
//            let con = "{}"
//            let cons = tc_string_data_t(content: con, len: UInt32(con.bytes()))
//            let f = tc_request_sync(1, mns, cons)
//            let ctx2 = tc_read_string(f)
//            let str2 = String(cString: UnsafeRawPointer(ctx2.content).bindMemory(to: CChar.self, capacity: Int(ctx2.len)))
//            print("resp", str2)
//        }




//        mn.withUTF8 { (p: UnsafeBufferPointer<UInt8>) in
//            p.baseAddress?.withMemoryRebound(to: Int8.self, capacity: p.count, { (p2: UnsafePointer<Int8>) in
//                let mns = tc_string_data_t(content: p2, len: UInt32(p.count))
//                let con = "{}"
//                let cons = tc_string_data_t(content: con, len: UInt32(con.bytes()))
//                let f = tc_request_sync(1, mns, cons)
//                let ctx2 = tc_read_string(f)
//                let str2 = String(cString: UnsafeRawPointer(ctx2.content).bindMemory(to: CChar.self, capacity: Int(ctx2.len)))
//                print("resp", str2)
//            })
//        }
//        mn.cString(using: .utf8)
//        mn = String(UTF8String: mn.cStringUsingEncoding())
//        mn = String(cString: mn.cString(using: .utf8)!)
//        mn = String(describing: mn.cString(using: String.Encoding.utf16))
//        let mns = tc_string_data_t(content: mn, len: UInt32(mn.data(using: .utf8)!.count))

//        let mns = tc_string_data_t(content: mn, len: UInt32(mn.bytes()))
//        let con = "{}"
//        let cons = tc_string_data_t(content: con, len: UInt32(con.bytes()))
//        let f = tc_request_sync(1, mns, cons)
//        let ctx2 = tc_read_string(f)
//        let str2 = String(cString: UnsafeRawPointer(ctx2.content).bindMemory(to: CChar.self, capacity: Int(ctx2.len)))
//        print("resp", str2)
        

//        XCTAssertEqual(swiftString, "Hello😀")
    }
}

