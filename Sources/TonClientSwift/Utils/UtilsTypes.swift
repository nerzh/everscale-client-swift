//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

//AddressStringFormat
public enum TSDKAddressStringFormatType: String, Encodable {
    case AccountId = "AccountId"
    case Hex = "Hex"
    case Base64 = "Base64"
}

public struct TSDKAddressStringFormat: Encodable {
    public var type: TSDKAddressStringFormatType
    public var url: Bool?
    public var test: Bool?
    public var bounce: Bool?
}
///Depends on value of the public struct TSDKfield.
///When public struct TSDKis 'AccountId'

///When public struct TSDKis 'Hex'

///When public struct TSDKis 'Base64'
///url: boolean
///test: boolean
///bounce: boolean

//ParamsOfConvertAddress
public struct TSDKParamsOfConvertAddress: Encodable {
    public var address: String
    public var output_format: TSDKAddressStringFormat
}
///address: string – Account address in any format.
///output_format: AddressStringFormat – Specify the format to convert to.

//ResultOfConvertAddress
public struct TSDKResultOfConvertAddress: Decodable {
    public var address: String
}
///address: string – address in the specified format
