//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

public struct TSDKContextResponse: Codable {
    public var result: UInt32?
    public var error: AnyValue?
}

public struct TSDKBindingRequest<TSDKResult: Codable, TSDKError: Codable, TSDKCustom: Codable> {
    public var result: (_ result: TSDKResult?) -> Void
    public var error: (_ error: TSDKError?) -> Void
    public var customHandler: (_ params: TSDKCustom?) -> Void
}

public enum TSDKBindingResponseType: UInt32 {
    case responseSuccess = 0
    case responseError = 1
    case responseNop = 2
    case responseCustom = 100
    case unknown
}

public struct TSDKNoneResult: Codable {}

public struct TSDKDefault: Codable {
    public var result: AnyValue?
    public var error: AnyValue?
    public var data: AnyValue?
    public var message: AnyValue?
    public var code: AnyValue?

    public init(result: AnyValue? = nil, error: AnyValue? = nil, data: AnyValue? = nil, message: AnyValue? = nil, code: AnyValue? = nil) {
        self.result = result
        self.error = error
        self.data = data
        self.message = message
        self.code = code
    }
}

public struct TSDKBindingResponse<TSDKResult: Codable, TSDKError: Codable> {
    public var result: TSDKResult?
    public var error: TSDKError?
    public var dappError: TSDKError?
    public var finished: Bool = false
    public var requestId: UInt32 = 0
    public var rawResponse: String = .init()

    public mutating func update(_ requestId: UInt32,
                                _ rawResponse: String,
                                _ responseType: TSDKBindingResponseType,
                                _ finished: Bool
    ) {
        self.finished = finished
        self.requestId = requestId
        self.rawResponse = rawResponse

        switch responseType {
        case .responseSuccess:
            result = rawResponse.toModel(TSDKResult.self)
        case .responseError:
            error = rawResponse.toModel(TSDKError.self)
            Log.warn(error ?? "RESPONSE TYPE ERROR, BUT ERROR IS NIL")
        case .responseCustom:
            result = rawResponse.toModel(TSDKResult.self)
        case .responseNop:
            result = rawResponse.toModel(TSDKResult.self)
        default:
            dappError = rawResponse.toModel(TSDKError.self)
            Log.warn(error ?? "responseType NOT FOUND and dappError not parsed")
        }
    }
}
