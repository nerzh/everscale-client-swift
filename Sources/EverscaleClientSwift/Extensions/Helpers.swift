//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

func methodName(_ module: String, _ method: String) -> String {
    "\(module).\(method)"
}

class Log {

    class func log(_ str: Any...) {
        print("❇️ logi:", str)
    }

    class func warn(_ str: Any...) {
        print("⚠️ logi:", str)
    }
}

