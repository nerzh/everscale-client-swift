//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

public extension String {
    
    func bytes(_ using: Encoding = .utf8) -> Int {
        self.data(using: using)?.count ?? 0
    }
    
    // TO DECODABLE STRUCT
    func toModel<T>(_ model: T.Type) -> T? where T : Decodable {
        guard let data = self.data(using: String.Encoding.utf8) else { return nil }
        return try? JSONDecoder().decode(model, from: data)
    }
    
    func getPointer<T>(_ handler: (_ pointer: UnsafePointer<T>, _ len: Int) throws -> Void) rethrows {
        var string = self
        try string.withUTF8 { (p: UnsafeBufferPointer<UInt8>) in
            try p.baseAddress?.withMemoryRebound(to: T.self, capacity: p.count) { (p2: UnsafePointer<T>) in
                try handler(p2, p.count)
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
