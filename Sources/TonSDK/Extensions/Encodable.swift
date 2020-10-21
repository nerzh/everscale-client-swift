//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

extension Encodable {

    func toJson() -> String? {
        let encoder = JSONEncoder()
        let jsonData = try? encoder.encode(self)
        guard let data = jsonData else { return nil }
        return String(data: data, encoding: String.Encoding.utf8)
    }
}

struct AnyEncodable<T: Encodable>: Encodable {
    var value: T

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
}
