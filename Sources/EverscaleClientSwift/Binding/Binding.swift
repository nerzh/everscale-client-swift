//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation
import CTonSDK
import SwiftExtensionsPack

public protocol TSDKBindingPrtcl {
    
    var context: UInt32 { get }
    static func convertToTSDKString(_ string: String, _ handler: (_ tsdkString: tc_string_data_t) throws -> Void) throws
    static func convertFromTSDKString(_ tsdkString: tc_string_data_t) throws -> String
    static func convertTSDKStringPointerToString(_ tsdkStringPointer: OpaquePointer) throws -> String
    static func convertTSDKStringToDictionary(_ tsdkString: tc_string_data_t) throws -> [String: Any]?
    static func convertTSDKStringPointerToDictionary(_ tsdkStringPointer: OpaquePointer) throws -> [String: Any]?
}


// MARK: Binding Helpers

public final class TSDKBindingModule: TSDKBindingPrtcl {
    
    public var context: UInt32 = .init()
    
    public init(config: TSDKClientConfig = TSDKClientConfig()) throws {
        self.context = try createContext(config: config)
    }
    
    public static func convertToTSDKString(_ string: String, _ handler: (_ tsdkString: tc_string_data_t) throws -> Void) throws {
        try string.getPointer { (ptr: UnsafePointer<Int8>, len: Int) in
            try handler(tc_string_data_t.init(content: ptr, len: UInt32(len)))
        }
    }
    
    public static func convertFromTSDKString(_ tsdkString: tc_string_data_t) throws -> String {
        let data = Data(bytes: tsdkString.content, count: Int(tsdkString.len))
        guard let s = String(data: data, encoding: .utf8) else {
            throw TSDKClientError.init(code: 0, message: "convertFromTSDKString NOT VALID")
        }
        return s
    }
    
    public static func convertTSDKStringPointerToString(_ tsdkStringPointer: OpaquePointer) -> String {
        let tsdkString: tc_string_data_t = tc_read_string(tsdkStringPointer)
        defer { tc_destroy_string(tsdkStringPointer) }
        return String(cString: UnsafeRawPointer(tsdkString.content).bindMemory(to: CChar.self, capacity: Int(tsdkString.len)))
    }
    
    public static func convertTSDKStringPointerToDictionary(_ tsdkStringPointer: OpaquePointer) -> [String: Any]? {
        let string: String = convertTSDKStringPointerToString(tsdkStringPointer)
        return string.toDictionary()
    }
    
    public static func convertTSDKStringToDictionary(_ tsdkString: tc_string_data_t) throws -> [String: Any]? {
        let string: String = try convertFromTSDKString(tsdkString)
        return string.toDictionary()
    }
    
    private func createContext(config: TSDKClientConfig) throws -> UInt32 {
        var contextId: UInt32 = .init()
        let json: String = config.toJson() ?? "{}"
        try Self.convertToTSDKString(json) { config in
            let ctx: OpaquePointer = tc_create_context(config)
            let contextResponse = try Self.convertFromTSDKString(tc_read_string(ctx)).toModel(TSDKContextResponse.self)
            defer { tc_destroy_string(ctx) }
            if let context = contextResponse?.result {
                contextId = context
            } else {
                fatalError(contextResponse?.error.debugDescription ?? "Context not created")
            }
        }
        return contextId
    }
    
    public func destroyContext() {
        tc_destroy_context(context)
    }
    
    public func requestLibraryAsync(_ methodName: String,
                                    _ payload: Encodable = "",
                                    _ requestHandler: @escaping @Sendable (_ requestId: UInt32,
                                                                           _ stringResponse: String,
                                                                           _ responseType: TSDKBindingResponseType,
                                                                           _ finished: Bool) throws -> Void
    ) throws {
        try Self.convertToTSDKString(methodName) { [weak self] tsdkMethodName in
            guard let self = self else { return }
            let payload = payload.toJson() ?? ""
            try Self.convertToTSDKString(payload) { tsdkPayload in
                let requestId: UInt32 = BindingStore.generate_request_id()
                BindingStore.addResponseHandler(requestId, requestHandler)
                tc_request(self.context,
                           tsdkMethodName,
                           tsdkPayload,
                           requestId
                ) { (requestId: UInt32, params: tc_string_data_t, responseType: UInt32, finished: Bool) in
                    let responseHandler = BindingStore.getResponseHandler(requestId)
                    do {
                        let swiftString: String = try TSDKBindingModule.convertFromTSDKString(params)
                        let responseType: TSDKBindingResponseType = (TSDKBindingResponseType.init(rawValue: responseType) ?? .unknown)!
                        
                        try responseHandler?(requestId, swiftString, responseType, finished)
                        if finished || responseType == .responseError {
                            BindingStore.deleteResponseHandler(requestId)
                        }
                    } catch {
                        BindingStore.deleteResponseHandler(requestId)
                        try? responseHandler?(
                            requestId,
                            [
                                "code": 0,
                                "message": String(describing: error),
                                "data": ([:] as [String: Any]).toAnyValue()
                            ].toAnyValue().toJSON(),
                            .responseError,
                            true)
                    }
                }
            }
        }
    }
    
    public func requestLibraryAsyncAwait(_ methodName: String,
                                         _ payload: Encodable = "",
                                         _ requestHandler: @escaping @Sendable (_ requestId: UInt32,
                                                                                _ stringResponse: String,
                                                                                _ responseType: TSDKBindingResponseType,
                                                                                _ finished: Bool) throws -> Void
    ) throws {
        try Self.convertToTSDKString(methodName) { [weak self] tsdkMethodName in
            guard let self = self else { return }
            let payload = payload.toJson() ?? ""
            try Self.convertToTSDKString(payload) { tsdkPayload in
                let requestId: UInt32 = BindingStore.generate_request_id()
                BindingStore.addResponseHandler(requestId, requestHandler)
                tc_request(self.context,
                           tsdkMethodName,
                           tsdkPayload,
                           requestId
                ) { (requestId: UInt32, params: tc_string_data_t, responseType: UInt32, finished: Bool) in
                    let responseHandler = BindingStore.getResponseHandler(requestId)
                    do {
                        let swiftString: String = try TSDKBindingModule.convertFromTSDKString(params)
                        let responseType: TSDKBindingResponseType = (TSDKBindingResponseType.init(rawValue: responseType) ?? .unknown)!
                        
                        if !swiftString.isEmpty {
                            BindingStore.setCompleteResponse(requestId,
                                                             (requestId: requestId,
                                                              stringResponse: swiftString,
                                                              responseType: responseType,
                                                              finished: true))
                        }
                        
                        if finished || responseType == .responseError {
                            BindingStore.deleteResponseHandler(requestId)
                            let response: BindingStore.RawResponse = try BindingStore.getCompleteResponse(requestId)
                            try responseHandler?(response.requestId, response.stringResponse, response.responseType, response.finished)
                            BindingStore.deleteCompleteResponse(requestId)
                        }
                    } catch {
                        BindingStore.deleteResponseHandler(requestId)
                        BindingStore.deleteCompleteResponse(requestId)
                        try? responseHandler?(
                            requestId,
                            [
                                "code": 0,
                                "message": String(describing: error),
                                "data": ([:] as [String: Any]).toAnyValue()
                            ].toAnyValue().toJSON(),
                            .responseError,
                            true)
                    }
                }
            }
        }
    }
    
    deinit {
        #if DEBUG
        print("destroyContext()")
        #endif
        destroyContext()
    }
}
