//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 20.10.2020.
//

import Foundation
import TonSDK

func testAsyncMethod<TSDKResult: Decodable,
                     TSDKError: Decodable,
                     TSDKCustom: Decodable
>(methodName: String,
  payload: String = "",
  _ handler: ((TSDKBindingResponse<TSDKResult, TSDKError, TSDKCustom>) -> Void)? = nil
) {
    var config: TSDKClientConfig = .init()
    config.network = TSDKNetworkConfig(server_address: "https://net.ton.dev")
    let binding: TSDKBinding = .init(config: config)
    let group: DispatchGroup = .init()
    group.enter()
    binding.requestLibraryAsync(methodName, payload) { (resonse: TSDKBindingResponse<TSDKResult, TSDKError, TSDKCustom>) in
        handler?(resonse)
        group.leave()
    }
    group.wait()
}

func testAsyncMethods(_ handler: @escaping (_ client: TSDKClient, _ group: DispatchGroup) -> Void) {
    var config: TSDKClientConfig = .init()
    config.network = TSDKNetworkConfig(server_address: "https://net.ton.dev")
    let client: TSDKClient = .init(config: config)
    let group: DispatchGroup = .init()
    group.enter()
    handler(client, group)
}

