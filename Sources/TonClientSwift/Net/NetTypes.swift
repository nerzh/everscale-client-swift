//
//  File.swift
//  
//
//  Created by Oleh Hudeichuk on 21.10.2020.
//

import Foundation

//OrderBy
public struct TSDKOrderBy: Codable {
    public var path: String
    public var direction: TSDKSortDirection

    public init(path: String, direction: TSDKSortDirection) {
        self.path = path
        self.direction = direction
    }
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
    public var collection: String
    public var filter: AnyValue?
    public var result: String
    public var order: [TSDKOrderBy]?
    public var limit: Int?

    public init(collection: String, filter: AnyValue? = nil, result: String, order: [TSDKOrderBy]? = nil, limit: Int? = nil) {
        self.collection = collection
        self.filter = filter
        self.result = result
        self.order = order
        self.limit = limit
    }
}
///collection: string – collection name (accounts blocks transactions messages block_signatures)
///filter?: any – collection filter
///result: string – projection (result) string
///order?: OrderBy[] – sorting order
///limit?: number – number of documents to return

//ResultOfQueryCollection
public struct TSDKResultOfQueryCollection: Codable {
    public var result: [AnyJSONType]
}
///result: any[] – objects that match provided criteria

//ParamsOfWaitForCollection
public struct TSDKParamsOfWaitForCollection: Codable {
    public var collection: String
    public var filter: AnyValue?
    public var result: String
    public var timeout: Int?

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
public struct TSDKResultOfWaitForCollection: Codable {
    public var result: AnyJSONType
}
///result: any – first found object that match provided criteria

//ResultOfSubscribeCollection
public struct TSDKResultOfSubscribeCollection: Codable {
    public var handle: Int
}
///handle: number – handle to subscription. It then can be used in get_next_subscription_data function
///unit
///public struct TSDKunit = void

//ParamsOfSubscribeCollection
public struct TSDKParamsOfSubscribeCollection: Codable {
    public var collection: String
    public var filter: AnyValue?
    public var result: String

    public init(collection: String, filter: AnyValue? = nil, result: String) {
        self.collection = collection
        self.filter = filter
        self.result = result
    }
}
///collection: string – collection name (accounts blocks transactions messages block_signatures)
///filter?: any – collection filter
///result: string – projection (result) string
