//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 20.10.2020.
//

import Foundation

public struct TSDKParamsOfFactorize: Encodable {
    public var composite: String
}

public struct TSDKResultOfFactorize: Decodable {
    public var factors: [String]
}
