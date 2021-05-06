//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

//AddressStringFormat
public enum TSDKAddressStringFormatType: String, Codable {
    case AccountId = "AccountId"
    case Hex = "Hex"
    case Base64 = "Base64"
}

public struct TSDKAddressStringFormat: Codable {
    public var type: TSDKAddressStringFormatType
    public var url: Bool?
    public var test: Bool?
    public var bounce: Bool?

    public init(type: TSDKAddressStringFormatType, url: Bool? = nil, test: Bool? = nil, bounce: Bool? = nil) {
        self.type = type
        self.url = url
        self.test = test
        self.bounce = bounce
    }
}
///Depends on value of the public struct TSDKfield.
///When public struct TSDKis 'AccountId'

///When public struct TSDKis 'Hex'

///When public struct TSDKis 'Base64'
///url: boolean
///test: boolean
///bounce: boolean

//ParamsOfConvertAddress
public struct TSDKParamsOfConvertAddress: Codable {
    public var address: String
    public var output_format: TSDKAddressStringFormat

    public init(address: String, output_format: TSDKAddressStringFormat) {
        self.address = address
        self.output_format = output_format
    }
}
///address: string – Account address in any format.
///output_format: AddressStringFormat – Specify the format to convert to.

//ResultOfConvertAddress
public struct TSDKResultOfConvertAddress: Codable {
    public var address: String
}
///address: string – address in the specified format
