//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

public final class TSDKClient {

    private let binding: TSDKBinding
    public var abi: TSDKAbi
    public var boc: TSDKBoc
    public var crypto: TSDKCrypto
    public var net: TSDKNet
    public var processing: TSDKProcessing
    public var tvm: TSDKTvm
    public var utils: TSDKUtils

    public init(config: TSDKClientConfig) {
        self.binding = TSDKBinding(config: config)
        self.abi = TSDKAbi(binding: binding)
        self.boc = TSDKBoc(binding: binding)
        self.crypto = TSDKCrypto(binding: binding)
        self.net = TSDKNet(binding: binding)
        self.processing = TSDKProcessing(binding: binding)
        self.tvm = TSDKTvm(binding: binding)
        self.utils = TSDKUtils(binding: binding)
    }

    public func destroy() {
        binding.destroyContext()
    }
}
