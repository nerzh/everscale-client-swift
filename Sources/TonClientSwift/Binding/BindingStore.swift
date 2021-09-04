//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 19.10.2020.
//

import Foundation

public final class BindingStore {

    private static var requsetId: UInt32 = .init()
    private static let requestLock: NSLock = .init()
    public static var asyncResponseGroups: [UInt32: DispatchGroup] = .init()
    private static let asyncResponseLock: NSLock = .init()
    public static var responses: [UInt32: (_ requestId: UInt32,
                                           _ stringResponse: String,
                                           _ responseType: TSDKBindingResponseType,
                                           _ finished: Bool) -> Void] = .init()


    public class func addResponseHandler(_ requestId: UInt32,
                                         _ response: @escaping (_ requestId: UInt32,
                                                                _ stringResponse: String,
                                                                _ responseType: TSDKBindingResponseType,
                                                                _ finished: Bool) -> Void
    ) {
        asyncResponseLock.lock()
        responses[requestId] = response
        asyncResponseLock.unlock()
    }

    public class func getResponseHandler(_ requestId: UInt32) -> ((_ requestId: UInt32,
                                                                   _ stringResponse: String,
                                                                   _ responseType: TSDKBindingResponseType,
                                                                   _ finished: Bool) -> Void)? {
        asyncResponseLock.lock()
        defer { asyncResponseLock.unlock() }
        return responses[requestId]
    }

    public class func deleteResponseHandler(_ requestId: UInt32) {
        asyncResponseLock.lock()
        defer { asyncResponseLock.unlock() }
        responses[requestId] = nil
    }

    public class func generate_request_id() -> UInt32 {
        requestLock.lock()
        defer { requestLock.unlock() }
        if requsetId == UInt32.max {
            requsetId = 0
        }
        requsetId += 1
        return requsetId
    }
}
