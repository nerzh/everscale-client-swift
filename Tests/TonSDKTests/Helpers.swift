//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 20.10.2020.
//

import Foundation
import TonSDK

func testAsyncMethods(_ handler: @escaping (_ client: TSDKClient, _ group: DispatchGroup) -> Void) {
    var config: TSDKClientConfig = .init()
    config.network = TSDKNetworkConfig(server_address: "https://net.ton.dev")
    let client: TSDKClient = .init(config: config)
    let group: DispatchGroup = .init()
    handler(client, group)
}

