//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 18.11.2020.
//

import XCTest
import class Foundation.Bundle
@testable import TonClientSwift

final class UtilsTests: XCTestCase {

    func testAccountIdToHex() throws {
        testAsyncMethods { [self] (client, group) in
            group.enter()
            let format: TSDKAddressStringFormat = .init(type: .Hex, url: nil, test: nil, bounce: nil)
            let payload: TSDKParamsOfConvertAddress = .init(address: self.accountId, output_format: format)
            var maybeResultOfConvertAddress: TSDKResultOfConvertAddress?
            client.utils.convert_address(payload) { (response) in
                if let result = response.result {
                    maybeResultOfConvertAddress = result
                }
                if response.finished {
                    group.leave()
                }
            }
            group.wait()
            guard let resultOfConvertAddress = maybeResultOfConvertAddress else {
                XCTAssertTrue(false, "resultOfConvertAddress must not be nil")
                return
            }
            XCTAssertEqual(resultOfConvertAddress.address, self.hexWorkchain0)
        }
    }

    func testAccountIdToAccountId() throws {
        testAsyncMethods { [self] (client, group) in
            group.enter()
            let format: TSDKAddressStringFormat = .init(type: .AccountId, url: nil, test: nil, bounce: nil)
            let payload: TSDKParamsOfConvertAddress = .init(address: self.accountId, output_format: format)
            var maybeResultOfConvertAddress: TSDKResultOfConvertAddress?
            client.utils.convert_address(payload) { (response) in
                if let result = response.result {
                    maybeResultOfConvertAddress = result
                }
                if response.finished {
                    group.leave()
                }
            }
            group.wait()
            guard let resultOfConvertAddress = maybeResultOfConvertAddress else {
                XCTAssertTrue(false, "resultOfConvertAddress must not be nil")
                return
            }
            XCTAssertEqual(resultOfConvertAddress.address, self.accountId)
        }
    }

    func testHexToBase64() throws {
        testAsyncMethods { [self] (client, group) in
            group.enter()
            let format: TSDKAddressStringFormat = .init(type: .Base64, url: false, test: false, bounce: false)
            let payload: TSDKParamsOfConvertAddress = .init(address: self.hex, output_format: format)
            var maybeResultOfConvertAddress: TSDKResultOfConvertAddress?
            client.utils.convert_address(payload) { (response) in
                if let result = response.result {
                    maybeResultOfConvertAddress = result
                }
                if response.finished {
                    group.leave()
                }
            }
            group.wait()
            guard let resultOfConvertAddress = maybeResultOfConvertAddress else {
                XCTAssertTrue(false, "resultOfConvertAddress must not be nil")
                return
            }
            XCTAssertEqual(resultOfConvertAddress.address, self.base64)
        }
    }

    func testBase64ToBase64URL() throws {
        testAsyncMethods { [self] (client, group) in
            group.enter()
            let format: TSDKAddressStringFormat = .init(type: .Base64, url: true, test: true, bounce: true)
            let payload: TSDKParamsOfConvertAddress = .init(address: self.base64, output_format: format)
            var maybeResultOfConvertAddress: TSDKResultOfConvertAddress?
            client.utils.convert_address(payload) { (response) in
                if let result = response.result {
                    maybeResultOfConvertAddress = result
                }
                if response.finished {
                    group.leave()
                }
            }
            group.wait()
            guard let resultOfConvertAddress = maybeResultOfConvertAddress else {
                XCTAssertTrue(false, "resultOfConvertAddress must not be nil")
                return
            }
            XCTAssertEqual(resultOfConvertAddress.address, self.base64url)
        }
    }

    func testBase64URLToHex() throws {
        testAsyncMethods { [self] (client, group) in
            group.enter()
            let format: TSDKAddressStringFormat = .init(type: .Hex, url: nil, test: nil, bounce: nil)
            let payload: TSDKParamsOfConvertAddress = .init(address: self.base64url, output_format: format)
            var maybeResultOfConvertAddress: TSDKResultOfConvertAddress?
            client.utils.convert_address(payload) { (response) in
                if let result = response.result {
                    maybeResultOfConvertAddress = result
                }
                if response.finished {
                    group.leave()
                }
            }
            group.wait()
            guard let resultOfConvertAddress = maybeResultOfConvertAddress else {
                XCTAssertTrue(false, "resultOfConvertAddress must not be nil")
                return
            }
            XCTAssertEqual(resultOfConvertAddress.address, self.hex)
        }
    }


    let accountId: String = "fcb91a3a3816d0f7b8c2c76108b8a9bc5a6b7a55bd79f8ab101c52db29232260";
    let hex: String = "-1:fcb91a3a3816d0f7b8c2c76108b8a9bc5a6b7a55bd79f8ab101c52db29232260";
    let hexWorkchain0: String = "0:fcb91a3a3816d0f7b8c2c76108b8a9bc5a6b7a55bd79f8ab101c52db29232260";
    let base64: String = "Uf/8uRo6OBbQ97jCx2EIuKm8Wmt6Vb15+KsQHFLbKSMiYG+9";
    let base64url: String = "kf_8uRo6OBbQ97jCx2EIuKm8Wmt6Vb15-KsQHFLbKSMiYIny";
}

