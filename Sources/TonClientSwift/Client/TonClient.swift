//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

public final class TSDKClientModule {

    private let binding: TSDKBindingModule
    public let config: TSDKClientConfig
    public var abi: TSDKAbiModule
    public var boc: TSDKBocModule
    public var crypto: TSDKCryptoModule
    public var net: TSDKNetModule
    public var processing: TSDKProcessingModule
    public var tvm: TSDKTvmModule
    public var utils: TSDKUtilsModule

    public init(config: TSDKClientConfig) {
        self.config = config
        self.binding = TSDKBindingModule(config: config)
        self.abi = TSDKAbiModule(binding: binding)
        self.boc = TSDKBocModule(binding: binding)
        self.crypto = TSDKCryptoModule(binding: binding)
        self.net = TSDKNetModule(binding: binding)
        self.processing = TSDKProcessingModule(binding: binding)
        self.tvm = TSDKTvmModule(binding: binding)
        self.utils = TSDKUtilsModule(binding: binding)
    }

    public func destroy() {
        binding.destroyContext()
    }
}
