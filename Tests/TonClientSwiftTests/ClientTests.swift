//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 19.11.2020.
//

import XCTest
import class Foundation.Bundle
@testable import TonClientSwift
@testable import CTonSDK

final class ClientTests: XCTestCase {

    func testGet_api_reference() throws {
        testAsyncMethods { (client, group) in
            group.enter()
            client.get_api_reference { (response) in
                XCTAssertTrue(response.result?.api != nil)
                group.leave()
            }
            group.wait()
        }
    }

    func testVersion() throws {
        testAsyncMethods { (client, group) in
            group.enter()
            client.version { (response) in
                XCTAssertTrue(response.result?.version != nil)
                if response.finished {
                    group.leave()
                }
            }
            group.wait()
        }
    }

    func testBuild_info() throws {
        testAsyncMethods { (client, group) in
            group.enter()
            client.build_info { (response) in
                XCTAssertTrue(response.result?.build_number != nil)
                if response.finished {
                    group.leave()
                }
            }
            group.wait()
        }
    }
}
