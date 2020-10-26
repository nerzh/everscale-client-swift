//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

public struct TSDKContextResponse: Decodable {
    var result: UInt32?
    var error: AnyJSONType?
}

public struct TSDKBindingRequest<TSDKResult: Decodable, TSDKError: Decodable, TSDKCustom: Decodable> {
    var result: (_ result: TSDKResult?) -> Void
    var error: (_ error: TSDKError?) -> Void
    var customHandler: (_ params: TSDKCustom?) -> Void
}


public enum TSDKBindingResponseType: UInt32 {
    case responseSuccess = 0
    case responseError = 1
    case responseNop = 2
    case responseCustom = 100
    case unknown
}

public struct TSDKBindingResponse<TSDKResult: Decodable, TSDKError: Decodable, TSDKCustom: Decodable> {
    var result: TSDKResult?
    var error: TSDKError?
    var customResponse: TSDKCustom?
    var finished: Bool = false
    var requestId: UInt32 = 0
    var currentResponse: String?

    mutating func update(_ requestId: UInt32,
                _ stringResponse: String,
                _ responseType: TSDKBindingResponseType,
                _ finished: Bool
    ) {
        let response: String = stringResponse
        self.finished = finished
        self.requestId = requestId
        self.currentResponse = stringResponse

        switch responseType {
        case .responseSuccess:
            result = response.toModel(model: TSDKResult.self)
        case .responseError:
            error = response.toModel(model: TSDKError.self)
            Log.warn(error ?? "RESPONSE TYPE ERROR, BUT ERROR IS NIL")
        default:
            customResponse = response.toModel(model: TSDKCustom.self)
        }
    }
}
