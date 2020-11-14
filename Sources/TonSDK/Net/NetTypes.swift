//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

//OrderBy
public struct TSDKOrderBy: Codable {
    var path: String
    var direction: TSDKSortDirection
}
///path: string
///direction: SortDirection

//SortDirection
public enum TSDKSortDirection: String, Codable {
    case ASC = "ASC"
    case DESC = "DESC"
}
///One of the following value:
///ASC
///DESC

//ParamsOfQueryCollection
public struct TSDKParamsOfQueryCollection: Encodable {
    var collection: String
    var filter: AnyValue?
    var result: String
    var order: [TSDKOrderBy]?
    var limit: Int?
}
///collection: string – collection name (accounts blocks transactions messages block_signatures)
///filter?: any – collection filter
///result: string – projection (result) string
///order?: OrderBy[] – sorting order
///limit?: number – number of documents to return

//ResultOfQueryCollection
public struct TSDKResultOfQueryCollection: Decodable {
    var result: [AnyJSONType]
}
///result: any[] – objects that match provided criteria

//ParamsOfWaitForCollection
public struct TSDKParamsOfWaitForCollection: Encodable {

    var collection: String
    var filter: AnyValue?
    var result: String
    var timeout: Int?

    public init(collection: String, filter: AnyValue? = nil, result: String, timeout: Int? = nil) {
        self.collection = collection
        self.filter = filter
        self.result = result
        self.timeout = timeout
    }
}
///collection: string – collection name (accounts blocks transactions messages block_signatures)
///filter?: any – collection filter
///result: string – projection (result) string
///timeout?: number – query timeout

//ResultOfWaitForCollection
public struct TSDKResultOfWaitForCollection: Decodable {
    public var result: AnyJSONType
}
///result: any – first found object that match provided criteria

//ResultOfSubscribeCollection
public struct TSDKResultOfSubscribeCollection: Codable {
    var handle: Int
}
///handle: number – handle to subscription. It then can be used in get_next_subscription_data function
///unit
///public struct TSDKunit = void

//ParamsOfSubscribeCollection
public struct TSDKParamsOfSubscribeCollection: Encodable {
    var collection: String
    var filter: AnyValue?
    var result: String
}
///collection: string – collection name (accounts blocks transactions messages block_signatures)
///filter?: any – collection filter
///result: string – projection (result) string
