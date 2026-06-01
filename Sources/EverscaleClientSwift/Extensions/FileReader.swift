//
//  File.swift
//
//
//  Created by Oleh Hudeichuk on 22.10.2020.
//

import Foundation

public final class DOFileReader {

    public let fileURL: URL
    private var lines: [String]?
    private var currentLineIndex: Int = 0

    public init(fileURL: URL) {
        self.fileURL = fileURL
    }

    deinit {
        if self.lines != nil { fatalError("Please, close file descriptor.") }
    }

    public func open(options: String = "r") throws {
        do {
            let content = try String(contentsOf: fileURL, encoding: .utf8)
            self.lines = content.components(separatedBy: .newlines)
            self.currentLineIndex = 0
        } catch {
            throw TSDKClientError(error)
        }
    }

    public func close() {
        self.lines = nil
        self.currentLineIndex = 0
    }

    public func readLine(maxLength: Int = 4096) throws -> String? {
        do {
            guard let lines else {
                throw NSError(domain: NSPOSIXErrorDomain, code: Int(EBADF), userInfo: nil)
            }
            guard currentLineIndex < lines.count else { return nil }
            defer { currentLineIndex += 1 }
            return lines[currentLineIndex]
        } catch {
            throw TSDKClientError(error)
        }
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
            let message: String = "Please, check working directory in schema for this project. Current workingDirectory is \(String(describing: ProcessInfo.processInfo.environment["PWD"]))"
            fatalError("\(String(describing: error))   \(message)   ErrorFilePath: \(fileURL.path)")
        }
    }

    public static func readFile(_ filePath: String, _ options: String = "r", _ handler: (_ line: String) -> Void) {
        let fileURL: URL = URL(fileURLWithPath: filePath)
        readFile(fileURL, options, handler)
    }
}
