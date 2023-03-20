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
    private static let asyncResponseLock: NSLock = .init()
    public static var responses: [UInt32: (_ requestId: UInt32,
                                           _ stringResponse: String,
                                           _ responseType: TSDKBindingResponseType,
                                           _ finished: Bool) throws -> Void] = .init()
    
    /// BECAUSE SDK METHODS LIKE PROCESS MESSAGE RETURNED TWO RESPONSE
    /// FIRST REAL RESPONSE AND LAST EMPTY STRING WITH STATUS FINISHED
    public typealias RawResponse = (requestId: UInt32,
                                    stringResponse: String,
                                    responseType: TSDKBindingResponseType,
                                    finished: Bool)
    public static var completeResponses: [UInt32: RawResponse] = [:]
    public static var completeResponsesLock: NSLock = .init()
    
    public class func setCompleteResponse(_ id: UInt32, _ response: RawResponse) {
        completeResponsesLock.lock()
        defer { completeResponsesLock.unlock() }
        completeResponses[id] = response
    }
    
    public class func getCompleteResponse(_ id: UInt32) throws -> RawResponse {
        completeResponsesLock.lock()
        defer { completeResponsesLock.unlock() }
        guard let result = completeResponses[id] else { throw TSDKClientError("\(id) not found") }
        return result
    }
    
    public class func deleteCompleteResponse(_ id: UInt32) {
        completeResponsesLock.lock()
        defer { completeResponsesLock.unlock() }
        completeResponses[id] = nil
    }
    
    public class func addResponseHandler(_ requestId: UInt32,
                                         _ response: @escaping @Sendable (_ requestId: UInt32,
                                                                          _ stringResponse: String,
                                                                          _ responseType: TSDKBindingResponseType,
                                                                          _ finished: Bool) throws -> Void
    ) {
        asyncResponseLock.lock()
        responses[requestId] = response
        asyncResponseLock.unlock()
    }
    
    public class func getResponseHandler(_ requestId: UInt32) -> ((_ requestId: UInt32,
                                                                   _ stringResponse: String,
                                                                   _ responseType: TSDKBindingResponseType,
                                                                   _ finished: Bool) throws -> Void)? {
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
