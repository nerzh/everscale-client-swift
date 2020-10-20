//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

public extension String {

    func bytes(_ using: Encoding = .utf8) -> Int {
        self.data(using: using)?.count ?? 0
    }

    func toDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    // TO DECODABLE STRUCT
    func toModel<T>(model: T.Type) -> T? where T : Decodable {
        guard let data = self.data(using: String.Encoding.utf8) else { return nil }
        return try? JSONDecoder().decode(model, from: data)
    }

    func getPointer<T>(_ handler: (_ pointer: UnsafePointer<T>, _ len: Int) -> Void) {
        var string = self
        string.withUTF8 { (p: UnsafeBufferPointer<UInt8>) in
            p.baseAddress?.withMemoryRebound(to: T.self, capacity: p.count) { (p2: UnsafePointer<T>) in
                handler(p2, p.count)
            }
        }
    }
    
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }

    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }

    func isBase64() -> Bool {
        if let encoded = self.base64Decoded()?.base64Encoded() {
            return encoded.trimmingCharacters(in: .whitespacesAndNewlines) == self
        }
        return false
    }
}
