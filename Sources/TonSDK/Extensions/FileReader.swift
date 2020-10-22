//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 22.10.2020.
//

import Foundation

final class DOFileReader {

    let fileURL: URL
    private var file: UnsafeMutablePointer<FILE>? = nil

    init(fileURL: URL) {
        self.fileURL = fileURL
    }

    deinit {
        if self.file != nil { fatalError("Please, close file descriptor.") }
    }

    func open() throws {
        guard let descriptor = fopen(fileURL.path, "r") else {
            throw NSError(domain: NSPOSIXErrorDomain, code: Int(errno), userInfo: nil)
        }
        self.file = descriptor
    }

    func close() {
        if let descriptor = self.file {
            self.file = nil
            let success: Bool = fclose(descriptor) == 0
            assert(success)
        }
    }

    func readLine(maxLength: Int = 4096) throws -> String? {
        guard let descriptor = self.file else {
            throw NSError(domain: NSPOSIXErrorDomain, code: Int(EBADF), userInfo: nil)
        }
        var buffer = [CChar](repeating: 0, count: maxLength)
        guard fgets(&buffer, Int32(maxLength), descriptor) != nil else {
            if feof(descriptor) != 0 {
                return nil
            } else {
                throw NSError(domain: NSPOSIXErrorDomain, code: Int(errno), userInfo: nil)
            }
        }

        return String(cString: buffer)
    }

    static func readFile(_ fileURL: URL, _ handler: (_ line: String) -> Void) {
        let file: DOFileReader = .init(fileURL: fileURL)
        do {
            try file.open()
            defer { file.close() }
            while let line: String = try file.readLine() {
                handler(line)
            }
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }

    static func readFile(_ filePath: String, _ handler: (_ line: String) -> Void) {
        guard let fileURL: URL = URL(string: filePath) else { fatalError("Can not convert \(filePath) to URL") }
        readFile(fileURL, handler)
    }
}
