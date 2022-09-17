import Foundation
import SwiftExtensionsPack


public enum TSDKProofsErrorCode: Int, Codable {
    case InvalidData = 901
    case ProofCheckFailed = 902
    case InternalError = 903
    case DataDiffersFromProven = 904
}

public struct TSDKParamsOfProofBlockData: Codable {
    /// Single block's data, retrieved from TONOS API, that needs proof. Required fields are `id` and/or top-level `boc` (for block identification), others are optional.
    public var block: AnyValue

    public init(block: AnyValue) {
        self.block = block
    }
}

public struct TSDKParamsOfProofTransactionData: Codable {
    /// Single transaction's data as queried from DApp server, without modifications. The required fields are `id` and/or top-level `boc`, others are optional. In order to reduce network requests count, it is recommended to provide `block_id` and `boc` of transaction.
    public var transaction: AnyValue

    public init(transaction: AnyValue) {
        self.transaction = transaction
    }
}

public struct TSDKParamsOfProofMessageData: Codable {
    /// Single message's data as queried from DApp server, without modifications. The required fields are `id` and/or top-level `boc`, others are optional. In order to reduce network requests count, it is recommended to provide at least `boc` of message and non-null `src_transaction.id` or `dst_transaction.id`.
    public var message: AnyValue

    public init(message: AnyValue) {
        self.message = message
    }
}

