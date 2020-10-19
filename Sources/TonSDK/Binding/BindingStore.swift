//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 19.10.2020.
//

import Foundation

final class BindingStore {

    static var asyncRequestGroups: [UInt32: DispatchGroup] = .init()
    private static let asyncResponseLock: NSLock = .init()
    private static var responses: [UInt32: (requestId: UInt32, params: TSDKString, responseType: UInt32, finished: Bool)] = .init()

    class func addResponse(_ requestId: UInt32,
                           _ response: (requestId: UInt32, params: TSDKString, responseType: UInt32, finished: Bool)
    ) {
        asyncResponseLock.lock()
        responses[requestId] = response
        asyncResponseLock.unlock()
    }

    class func getResponse(_ requestId: UInt32) -> (requestId: UInt32, params: TSDKString, responseType: UInt32, finished: Bool)? {
        asyncResponseLock.lock()
        defer { asyncResponseLock.unlock() }
        return responses[requestId]
    }

    class func deleteResponse(_ requestId: UInt32) {
        asyncResponseLock.lock()
        defer { asyncResponseLock.unlock() }
        responses[requestId] = nil
    }
}
