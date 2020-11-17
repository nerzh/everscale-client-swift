//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 22.10.2020.
//

import Foundation

public final class DOFileReader {

    public let fileURL: URL
    private var file: UnsafeMutablePointer<FILE>? = nil

    public init(fileURL: URL) {
        self.fileURL = fileURL
    }

    deinit {
        if self.file != nil { fatalError("Please, close file descriptor.") }
    }

    public func open(options: String = "r") throws {
        guard let descriptor = fopen(fileURL.path, options) else {
            throw NSError(domain: NSPOSIXErrorDomain, code: Int(errno), userInfo: nil)
        }
        self.file = descriptor
    }

    public func close() {
        if let descriptor = self.file {
            self.file = nil
            let success: Bool = fclose(descriptor) == 0
            assert(success)
        }
    }

    public func readLine(maxLength: Int = 4096) throws -> String? {
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

    public static func readFile(_ fileURL: URL, _ options: String = "r", _ handler: (_ line: String) -> Void) {
        let file: DOFileReader = .init(fileURL: fileURL)
        do {
            try file.open(options: options)
            defer { file.close() }
            while let line: String = try file.readLine() {
                handler(line)
            }
        } catch let error {
            let message: String = "Please, check working directory in schema for this project. Current workingDirectory is \(ProcessInfo().environment["PWD"])"
            fatalError("\(error.localizedDescription)   \(message)   ErrorFilePath: \(fileURL.path)")
        }
    }

    public static func readFile(_ filePath: String, _ options: String = "r", _ handler: (_ line: String) -> Void) {
        guard let fileURL: URL = URL(string: filePath) else { fatalError("Can not convert \(filePath) to URL") }
        readFile(fileURL, options, handler)
    }
}
