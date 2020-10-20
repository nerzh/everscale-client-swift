//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

public final class TSDKClient {

    public let binding: TSDKBinding

    public init(config: ClientConfig) {
        self.binding = TSDKBinding(config: config)
    }
}
