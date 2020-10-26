//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 19.10.2020.
//

import Foundation

final class BindingStore {

    static let responseQueue: DispatchQueue = .init(label: "com.responseQueue", qos: .background, attributes: .concurrent)
    static var asyncResponseGroups: [UInt32: DispatchGroup] = .init()
    private static let asyncResponseLock: NSLock = .init()
    static var responses: [UInt32: (_ requestId: UInt32,
                                    _ stringResponse: String,
                                    _ responseType: TSDKBindingResponseType,
                                    _ finished: Bool) -> Void] = .init()


    class func addResponseHandler(_ requestId: UInt32,
                                  _ response: @escaping (_ requestId: UInt32,
                                                         _ stringResponse: String,
                                                         _ responseType: TSDKBindingResponseType,
                                                         _ finished: Bool) -> Void
    ) {
        asyncResponseLock.lock()
        responses[requestId] = response
        asyncResponseLock.unlock()
    }

    class func getResponseHandler(_ requestId: UInt32) -> ((_ requestId: UInt32,
                                                            _ stringResponse: String,
                                                            _ responseType: TSDKBindingResponseType,
                                                            _ finished: Bool) -> Void)? {
        asyncResponseLock.lock()
        defer { asyncResponseLock.unlock() }
        return responses[requestId]
    }

    class func deleteResponseHandler(_ requestId: UInt32) {
        asyncResponseLock.lock()
        defer { asyncResponseLock.unlock() }
        responses[requestId] = nil
    }
}
