//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

public struct TSDKContextResponse: Decodable {
    var result: UInt32?
    var error: AnyJSONType?
}

//struct TSDKBindingRequest {
//    var result: (_ result: TSDKString) -> Void
//    var error: (_ error: TSDKString) -> Void
//    var customHandler: (_ params: TSDKString) -> Void
//}

//public protocol STEST {
//    var result: (_ result: Decodable?) -> Void { get set }
//    var error: (_ error: Decodable?) -> Void { get set }
//    var customHandler: (_ params: Decodable?) -> Void { get set }
//}

//public protocol STEST {
//    associatedtype A: Decodable
//    associatedtype B: Decodable
//    associatedtype C: Decodable
//    var result: (_ result: A?) -> Void { get set }
//    var error: (_ error: B?) -> Void { get set }
//    var customHandler: (_ params: C?) -> Void { get set }
//}


struct TSDKBindingRequest<TSDKResult: Decodable, TSDKError: Decodable, TSDKCustom: Decodable> {
//struct TSDKBindingRequest: STEST {
//where TSDKResult: Decodable, TSDKError: Decodable, TSDKCustom: Decodable {
//    var result: (_ result: Decodable?) -> Void
//    var error: (_ error: Decodable?) -> Void
//    var customHandler: (_ params: Decodable?) -> Void

    var result: (_ result: TSDKResult?) -> Void
    var error: (_ error: TSDKError?) -> Void
    var customHandler: (_ params: TSDKCustom?) -> Void
}


enum TSDKBindingResponseType: UInt32 {
    case responseSuccess = 0
    case responseError = 1
    case responseNop = 2
    case responseCustom = 100
}

struct TSDKBindingResponse<TSDKResult: Decodable, TSDKError: Decodable, TSDKCustom: Decodable> {
    var result: TSDKResult?
    var error: TSDKError?
    var customResponse: TSDKCustom?
    var finished: Bool = false
    var requestId: UInt32 = 0
    var currentResponse: TSDKString?

    mutating func update(_ requestId: UInt32,
                _ stringResponse: TSDKString,
                _ responseType: TSDKBindingResponseType,
                _ finished: Bool
    ) {
//        let response: [String: Any]? = TSDKBinding.convertTSDKStringToDictionary(stringResponse)
        self.finished = finished
        self.requestId = requestId
        self.currentResponse = stringResponse

        switch responseType {
        case .responseSuccess:
            result = TSDKBinding.convertFromTSDKString(stringResponse).toModel(model: TSDKResult.self)
        case .responseError:
            error = TSDKBinding.convertFromTSDKString(stringResponse).toModel(model: TSDKError.self)
        default:
            customResponse = TSDKBinding.convertFromTSDKString(stringResponse).toModel(model: TSDKCustom.self)
        }
    }
}


//struct TSDKBindingResponse {
//    var result: TSDKString
//    var error: TSDKString
//    var customResponse: TSDKString
//    var finished: Bool
//    var requestId: UInt32
//    var currentResponse: TSDKString
//
//    func update(_ requestId: UInt32,
//                _ stringResponse: TSDKString,
//                _ responseType: TSDKBindingResponseType,
//                _ finished: Bool
//    ) {
//        let response: [String: Any]? = TSDKBinding.convertTSDKStringToDictionary(stringResponse)
//        self.finished = finished
//        self.requestId = requestId
//        self.customResponse = stringResponse
//
//        switch responseType {
//        case .responseSuccess:
//            result =
//        default:
//            <#code#>
//        }
//    }
//}
