//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

public extension Encodable {

    func toJson() -> String? {
        let encoder = JSONEncoder()
        let jsonData = try? encoder.encode(self)
        guard let data = jsonData else { return nil }
        return String(data: data, encoding: String.Encoding.utf8)
    }
}
