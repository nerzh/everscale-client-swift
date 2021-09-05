//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation
import CTonSDK

public typealias TSDKString = tc_string_data_t
public typealias TSDKStringPointer = OpaquePointer
public var TSDKReadString = tc_read_string
public var TSDKDestroyString = tc_destroy_string

public typealias TSDKContext = UInt32
public var TSDKCreateContext = tc_create_context
public var TSDKDestroyContext = tc_destroy_context

public var TSDKRequestSync = tc_request_sync
public var TSDKRequestAsync = tc_request

public protocol TSDKBindingPrtcl {

    var context: TSDKContext { get }
    static func convertToTSDKString(_ string: String, _ handler: (_ tsdkString: TSDKString) throws -> Void) rethrows
    static func convertFromTSDKString(_ tsdkString: TSDKString) -> String
    static func convertTSDKStringPointerToString(_ tsdkStringPointer: TSDKStringPointer) -> String
    static func convertTSDKStringToDictionary(_ tsdkString: TSDKString) -> [String: Any]?
    static func convertTSDKStringPointerToDictionary(_ tsdkStringPointer: TSDKStringPointer) -> [String: Any]?
}


// MARK: Binding Helpers

public final class TSDKBindingModule: TSDKBindingPrtcl {

    public var context: TSDKContext = .init()
    var convertToTSDKString = TSDKBindingModule.convertToTSDKString
    var convertFromTSDKString = TSDKBindingModule.convertFromTSDKString
    var convertTSDKStringPointerToString = TSDKBindingModule.convertTSDKStringPointerToString
    var convertTSDKStringToDictionary = TSDKBindingModule.convertTSDKStringToDictionary
    var convertTSDKStringPointerToDictionary = TSDKBindingModule.convertTSDKStringPointerToDictionary


    public init(config: TSDKClientConfig = TSDKClientConfig()) throws {
        self.context = try createContext(config: config)
    }

    public static func convertToTSDKString(_ string: String, _ handler: (_ tsdkString: TSDKString) throws -> Void) {
        do {
            try string.getPointer { (ptr: UnsafePointer<Int8>, len: Int) in
                try handler(TSDKString.init(content: ptr, len: UInt32(len)))
            }
        } catch {
            fatalError("convertToTSDKString \(error.localizedDescription)")
        }
    }

    public static func convertFromTSDKString(_ tsdkString: TSDKString) -> String {
        let data = Data(bytes: tsdkString.content, count: Int(tsdkString.len))
        if let s = String(data: data, encoding: .utf8) {
            return s
        }
        return "NOT VALID"
    }

    public static func convertTSDKStringPointerToString(_ tsdkStringPointer: TSDKStringPointer) -> String {
        let tsdkString: TSDKString = TSDKReadString(tsdkStringPointer)
        defer { TSDKDestroyString(tsdkStringPointer) }
        return String(cString: UnsafeRawPointer(tsdkString.content).bindMemory(to: CChar.self, capacity: Int(tsdkString.len)))
    }

    public static func convertTSDKStringPointerToDictionary(_ tsdkStringPointer: TSDKStringPointer) -> [String: Any]? {
        let string: String = convertTSDKStringPointerToString(tsdkStringPointer)
        return string.toDictionary()
    }

    public static func convertTSDKStringToDictionary(_ tsdkString: TSDKString) -> [String: Any]? {
        let string: String = convertFromTSDKString(tsdkString)
        return string.toDictionary()
    }

    private func createContext(config: TSDKClientConfig) throws -> UInt32 {
        var contextId: UInt32 = .init()
        let json: String = config.toJson() ?? "{}"
        convertToTSDKString(json) { config in
            let contextResponse = convertFromTSDKString(TSDKReadString(TSDKCreateContext(config))).toModel(model: TSDKContextResponse.self)
            if let context = contextResponse?.result {
                contextId = context
            } else {
                fatalError(contextResponse?.error.debugDescription ?? "Context not created")
            }
        }
        return contextId
    }

    public func destroyContext() {
        TSDKDestroyContext(context)
    }

    public func requestLibraryAsync(_ methodName: String,
                                    _ payload: Encodable = "",
                                    _ requestHandler: @escaping (_ requestId: UInt32,
                                                                 _ stringResponse: String,
                                                                 _ responseType: TSDKBindingResponseType,
                                                                 _ finished: Bool) throws -> Void
    ) {
        convertToTSDKString(methodName) { tsdkMethodName in
            let payload = payload.toJson() ?? ""
            convertToTSDKString(payload) { tsdkPayload in
                let requestId: UInt32 = BindingStore.generate_request_id()
                BindingStore.addResponseHandler(requestId, requestHandler)
                TSDKRequestAsync(self.context,
                                 tsdkMethodName,
                                 tsdkPayload,
                                 requestId
                ) { (requestId: UInt32, params: TSDKString, responseType: UInt32, finished: Bool) in
                    let swiftString: String = TSDKBindingModule.convertFromTSDKString(params)
                    let responseType: TSDKBindingResponseType = (TSDKBindingResponseType.init(rawValue: responseType) ?? .unknown)!
                    do {
                        try BindingStore.getResponseHandler(requestId)?(requestId, swiftString, responseType, finished)
                    } catch {
                        try? BindingStore.getResponseHandler(requestId)?(
                            requestId,
                            [
                                "code": 0,
                                "message": error.localizedDescription,
                                "data": [:].toAnyValue()
                            ].toAnyValue().toJSON(),
                            .responseError,
                            false)
                        BindingStore.deleteResponseHandler(requestId)
                    }

                    if finished || responseType == .responseError {
                        BindingStore.deleteResponseHandler(requestId)
                    }
                }
            }
        }
    }

    deinit {
        destroyContext()
    }
}
