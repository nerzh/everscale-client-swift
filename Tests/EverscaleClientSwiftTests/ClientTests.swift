//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 19.11.2020.
//

import XCTest
import class Foundation.Bundle
@testable import EverscaleClientSwift
@testable import CTonSDK

final class ClientTests: XCTestCase {

    func testGet_api_reference() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            try client.get_api_reference { (response) in
                XCTAssertTrue(response.result?.api != nil)
                group.leave()
            }
            group.wait()
        }
    }

    func testVersion() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            try client.version { (response) in
                XCTAssertTrue(response.result?.version != nil)
                if response.finished {
                    group.leave()
                }
            }
            group.wait()
        }
    }

    func testBuild_info() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            try client.build_info { (response) in
                XCTAssertTrue(response.result?.build_number != nil)
                if response.finished {
                    group.leave()
                }
            }
            group.wait()
        }
    }
}
