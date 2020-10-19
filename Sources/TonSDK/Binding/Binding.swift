//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation
import CTonSDK

public typealias TSDKString = tc_string_data_t
public typealias TSDKStringPointer = tc_string_handle_t
public var TSDKReadString = tc_read_string
public var TSDKDestroyString = tc_destroy_string

public typealias TSDKContext = UInt32
public var TSDKCreateContext = tc_create_context
public var TSDKDestroyContext = tc_destroy_context

public var TSDKRequestSync = tc_request_sync
public var TSDKRequestAsync = tc_request

public protocol TSDKBindingPrtcl {

    var context: TSDKContext { get }
//    static func convertToTSDKString(_ string: String) -> TSDKString
    static func convertToTSDKString(_ string: String, _ handler: (_ tsdkString: TSDKString) -> Void)
    static func convertFromTSDKString(_ tsdkString: TSDKString) -> String
    static func convertTSDKStringPointerToString(_ tsdkStringPointer: UnsafePointer<TSDKStringPointer>) -> String
    static func convertTSDKStringToDictionary(_ tsdkString: TSDKString) -> [String: Any]?
    static func convertTSDKStringPointerToDictionary(_ tsdkStringPointer: UnsafePointer<TSDKStringPointer>) -> [String: Any]?
}


// MARK: Binding Helpers

final class TSDKBinding: TSDKBindingPrtcl {

    var context: TSDKContext = .init()
    private var requsetId: UInt32 = .init()
//    private var requsets: [UInt32: TSDKBindingRequest<STEST, STEST, STEST>] = .init()
//    private var requsets: [UInt32: STEST] = .init()
    private let requestLock: NSLock = .init()
    var convertToTSDKString = TSDKBinding.convertToTSDKString
    var convertFromTSDKString = TSDKBinding.convertFromTSDKString
    var convertTSDKStringPointerToString = TSDKBinding.convertTSDKStringPointerToString
    var convertTSDKStringToDictionary = TSDKBinding.convertTSDKStringToDictionary
    var convertTSDKStringPointerToDictionary = TSDKBinding.convertTSDKStringPointerToDictionary


    init(config: ClientConfig = ClientConfig()) {
        self.context = createContext(config: config)
    }

    public static func convertToTSDKString(_ string: String, _ handler: (_ tsdkString: TSDKString) -> Void) {
        string.getPointer { (ptr: UnsafePointer<Int8>, len: Int) in
            handler(TSDKString.init(content: ptr, len: UInt32(len)))
        }
    }

    public static func convertFromTSDKString(_ tsdkString: TSDKString) -> String {
        return String(cString: UnsafeRawPointer(tsdkString.content).bindMemory(to: CChar.self, capacity: Int(tsdkString.len)))
    }

    public static func convertTSDKStringPointerToString(_ tsdkStringPointer: UnsafePointer<TSDKStringPointer>) -> String {
        let tsdkString: TSDKString = TSDKReadString(tsdkStringPointer)
        defer { TSDKDestroyString(tsdkStringPointer) }
        return String(cString: UnsafeRawPointer(tsdkString.content).bindMemory(to: CChar.self, capacity: Int(tsdkString.len)))
    }

    public static func convertTSDKStringPointerToDictionary(_ tsdkStringPointer: UnsafePointer<TSDKStringPointer>) -> [String: Any]? {
        let string: String = convertTSDKStringPointerToString(tsdkStringPointer)
        return string.toDictionary()
    }

    public static func convertTSDKStringToDictionary(_ tsdkString: TSDKString) -> [String: Any]? {
        let string: String = convertFromTSDKString(tsdkString)
        return string.toDictionary()
    }

    private func createContext(config: ClientConfig) -> UInt32 {
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

    private func generate_request_id() -> UInt32 {
        requestLock.lock()
        defer { requestLock.unlock() }
        if requsetId == UInt32.max {
            requsetId = 0
        }
        requsetId += 1
        return requsetId
    }

//    private func get_request(_ id: UInt32) -> TSDKBindingRequest? {
//        requsets[id]
//    }
//
//    private func delete_request(_ id: UInt32) {
//        requsets[id] = nil
//    }
//
//    private func set_request(_ id: UInt32, _ request: TSDKBindingRequest) {
//        requsets[id] = request
//    }

    public func requestLibraryAsync<TSDKPayload: Encodable,
                                    TSDKResult: Decodable,
                                    TSDKError: Decodable,
                                    TSDKCustom: Decodable
    >(_ methodName: String,
      _ payload: TSDKPayload,
      _ requestHandler: @escaping (TSDKBindingResponse<TSDKResult, TSDKError, TSDKCustom>) -> Void
    ) {
        let requestId: UInt32 = generate_request_id()
        convertToTSDKString(methodName) { tsdkMethodName in
            let payload = payload.toJson() ?? "{}"
            convertToTSDKString(payload) { tsdkPayload in
                BindingStore.asyncRequestGroups[requestId] = DispatchGroup()
                guard let group = BindingStore.asyncRequestGroups[requestId] else { return }
                group.enter()
                Thread { [requestId, tsdkMethodName, tsdkPayload, group] in
                    TSDKRequestAsync(self.context,
                                     tsdkMethodName,
                                     tsdkPayload,
                                     requestId
                    ) { (requestId: UInt32, params: TSDKString, responseType: UInt32, finished: Bool) in
                        print(TSDKBinding.convertFromTSDKString(params))
                        BindingStore.addResponse(requestId, (requestId: requestId, params: params, responseType: responseType, finished: finished))
                        guard let group = BindingStore.asyncRequestGroups[requestId] else { return }
                        group.leave()
                    }
                    group.wait()
                    guard let tsdkResponse = BindingStore.getResponse(requestId) else { return }
                    guard let responseType = TSDKBindingResponseType.init(rawValue: tsdkResponse.responseType) else { return }
                    var response: TSDKBindingResponse<TSDKResult, TSDKError, TSDKCustom> = .init()
                    response.update(tsdkResponse.requestId, tsdkResponse.params, responseType, tsdkResponse.finished)
                    requestHandler(response)
                    BindingStore.deleteResponse(requestId)
                }.start()
            }
        }
//        BindingStore.asyncRequestGroups[requestId] = DispatchGroup()
//        guard let group = BindingStore.asyncRequestGroups[requestId] else { return }
//        print("resp - 1")
//        group.enter()
//        Thread { [requestId, tsdkMethodName, tsdkPayload, group] in
//        let aaa = TSDKRequestSync(context, tsdkMethodName, tsdkPayload)
//        TSDKRequestAsync(context,
//                         tsdkMethodName,
//                         tsdkPayload,
//                         requestId,
//                         sss
//        )
//            TSDKRequestAsync(context,
//                             tsdkMethodName,
//                             tsdkPayload,
//                             requestId
//            ) { (requestId: UInt32, params: TSDKString, responseType: UInt32, finished: Bool) in
//                print("resp - 3")
//                BindingStore.addResponse(requestId, (requestId: requestId, params: params, responseType: responseType, finished: finished))
//                guard let group = BindingStore.asyncRequestGroups[requestId] else { return }
//                group.leave()
//            }
//            group.wait()
//            guard let tsdkResponse = BindingStore.getResponse(requestId) else { return }
//            guard let responseType = TSDKBindingResponseType.init(rawValue: tsdkResponse.responseType) else { return }
//            var response: TSDKBindingResponse<TSDKResult, TSDKError, TSDKCustom> = .init()
//            response.update(tsdkResponse.requestId, tsdkResponse.params, responseType, tsdkResponse.finished)
//            requestHandler(response)
//            BindingStore.deleteResponse(requestId)
//        }.start()
    }





    //                var response: TSDKBindingResponse<TSDKResult, TSDKError, TSDKCustom> = .init()
    //                #warning("UNWRAP")
    //                response.update(requestId, params, TSDKBindingResponseType.init(rawValue: responseType)!, finished)





///    def self.requestLibrary(context: 1, method_name: '', payload: {}, &block)
///          request_id = generate_request_id
///          set_request(request_id, &block)
///          send_request(context: context, method_name: method_name, payload: payload, request_id: request_id) do |request_id, string_data, response_type, finished|
///            if get_request(request_id)
///              response = Response.new
///              response.update(request_id, string_data, response_type, finished)
///              get_request(request_id).call(response)
///              delete_request(request_id) if finished
///            end
///          end
///        end
}



//public func subscribe(newMessageHandler: @escaping NewMessageHandler) -> Result<Subscription> {
//
//    func cHandler(buffer: UnsafePointer<lcm_recv_buf_t>?, channel: UnsafePointer<Int8>?, userData: UnsafeMutableRawPointer?) {
//        guard let userData = userData else { return }
//        let subscribeUserData = Unmanaged<SubscribeUserData>.fromOpaque(userData).takeUnretainedValue()
//        subscribeUserData.handler()
//    }
//
//    self.subscribeUserData = SubscribeUserData(handler: newMessageHandler)
//    let subscribeUserDataPointer = UnsafeMutableRawPointer(Unmanaged.passUnretained(subscribeUserData).toOpaque())
//
//    if let subscription = lcm_subscribe(context, "ExampleMessage", cHandler, subscribeUserDataPointer) {
//        return .success(subscription)
//    } else {
//        return .failure(nil)
//    }
//}
