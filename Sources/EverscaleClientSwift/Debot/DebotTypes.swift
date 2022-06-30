import SwiftExtensionsPack


public typealias TSDKDebotHandle = UInt32

public enum TSDKDebotErrorCode: Int, Codable {
    case DebotStartFailed = 801
    case DebotFetchFailed = 802
    case DebotExecutionFailed = 803
    case DebotInvalidHandle = 804
    case DebotInvalidJsonParams = 805
    case DebotInvalidFunctionId = 806
    case DebotInvalidAbi = 807
    case DebotGetMethodFailed = 808
    case DebotInvalidMsg = 809
    case DebotExternalCallFailed = 810
    case DebotBrowserCallbackFailed = 811
    case DebotOperationRejected = 812
    case DebotNoCode = 813
}

public enum TSDKDebotActivityEnumTypes: String, Codable {
    case Transaction = "Transaction"
}

public enum TSDKParamsOfAppDebotBrowserEnumTypes: String, Codable {
    case Log = "Log"
    case Switch = "Switch"
    case SwitchCompleted = "SwitchCompleted"
    case ShowAction = "ShowAction"
    case Input = "Input"
    case GetSigningBox = "GetSigningBox"
    case InvokeDebot = "InvokeDebot"
    case Send = "Send"
    case Approve = "Approve"
}

public enum TSDKResultOfAppDebotBrowserEnumTypes: String, Codable {
    case Input = "Input"
    case GetSigningBox = "GetSigningBox"
    case InvokeDebot = "InvokeDebot"
    case Approve = "Approve"
}

public struct TSDKDebotAction: Codable {
    /// A short action description.
    /// Should be used by Debot Browser as name of menu item.
    public var description: String
    /// Depends on action type.
    /// Can be a debot function name or a print string (for Print Action).
    public var name: String
    /// Action type.
    public var action_type: UInt8
    /// ID of debot context to switch after action execution.
    public var to: UInt8
    /// Action attributes.
    /// In the form of "param=value,flag". attribute example: instant, args, fargs, sign.
    public var attributes: String
    /// Some internal action data.
    /// Used by debot only.
    public var misc: String

    public init(description: String, name: String, action_type: UInt8, to: UInt8, attributes: String, misc: String) {
        self.description = description
        self.name = name
        self.action_type = action_type
        self.to = to
        self.attributes = attributes
        self.misc = misc
    }
}

public struct TSDKDebotInfo: Codable {
    /// DeBot short name.
    public var name: String?
    /// DeBot semantic version.
    public var version: String?
    /// The name of DeBot deployer.
    public var publisher: String?
    /// Short info about DeBot.
    public var caption: String?
    /// The name of DeBot developer.
    public var author: String?
    /// TON address of author for questions and donations.
    public var support: String?
    /// String with the first messsage from DeBot.
    public var hello: String?
    /// String with DeBot interface language (ISO-639).
    public var language: String?
    /// String with DeBot ABI.
    public var dabi: String?
    /// DeBot icon.
    public var icon: String?
    /// Vector with IDs of DInterfaces used by DeBot.
    public var interfaces: [String]
    /// ABI version ("x.y") supported by DeBot
    public var dabiVersion: String

    public init(name: String? = nil, version: String? = nil, publisher: String? = nil, caption: String? = nil, author: String? = nil, support: String? = nil, hello: String? = nil, language: String? = nil, dabi: String? = nil, icon: String? = nil, interfaces: [String], dabiVersion: String) {
        self.name = name
        self.version = version
        self.publisher = publisher
        self.caption = caption
        self.author = author
        self.support = support
        self.hello = hello
        self.language = language
        self.dabi = dabi
        self.icon = icon
        self.interfaces = interfaces
        self.dabiVersion = dabiVersion
    }
}

public struct TSDKDebotActivity: Codable {
    public var type: TSDKDebotActivityEnumTypes
    /// External inbound message BOC.
    public var msg: String?
    /// Target smart contract address.
    public var dst: String?
    /// List of spendings as a result of transaction.
    public var out: [TSDKSpending]?
    /// Transaction total fee.
    public var fee: Int?
    /// Indicates if target smart contract updates its code.
    public var setcode: Bool?
    /// Public key from keypair that was used to sign external message.
    public var signkey: String?
    /// Signing box handle used to sign external message.
    public var signing_box_handle: UInt32?

    public init(type: TSDKDebotActivityEnumTypes, msg: String? = nil, dst: String? = nil, out: [TSDKSpending]? = nil, fee: Int? = nil, setcode: Bool? = nil, signkey: String? = nil, signing_box_handle: UInt32? = nil) {
        self.type = type
        self.msg = msg
        self.dst = dst
        self.out = out
        self.fee = fee
        self.setcode = setcode
        self.signkey = signkey
        self.signing_box_handle = signing_box_handle
    }
}

/// [UNSTABLE](UNSTABLE.md) Describes the operation that the DeBot wants to perform.
public struct TSDKSpending: Codable {
    /// Amount of nanotokens that will be sent to `dst` address.
    public var amount: Int
    /// Destination address of recipient of funds.
    public var dst: String

    public init(amount: Int, dst: String) {
        self.amount = amount
        self.dst = dst
    }
}

public struct TSDKParamsOfInit: Codable {
    /// Debot smart contract address
    public var address: String

    public init(address: String) {
        self.address = address
    }
}

public struct TSDKRegisteredDebot: Codable {
    /// Debot handle which references an instance of debot engine.
    public var debot_handle: TSDKDebotHandle
    /// Debot abi as json string.
    public var debot_abi: String
    /// Debot metadata.
    public var info: TSDKDebotInfo

    public init(debot_handle: TSDKDebotHandle, debot_abi: String, info: TSDKDebotInfo) {
        self.debot_handle = debot_handle
        self.debot_abi = debot_abi
        self.info = info
    }
}

public struct TSDKParamsOfAppDebotBrowser: Codable {
    public var type: TSDKParamsOfAppDebotBrowserEnumTypes
    /// A string that must be printed to user.
    public var msg: String?
    /// Debot context ID to which debot is switched.
    public var context_id: UInt8?
    /// Debot action that must be shown to user as menu item. At least `description` property must be shown from [DebotAction] structure.
    public var action: TSDKDebotAction?
    /// A prompt string that must be printed to user before input request.
    public var prompt: String?
    /// Address of debot in blockchain.
    public var debot_addr: String?
    /// Internal message to DInterface address.
    /// Message body contains interface function and parameters.
    public var message: String?
    /// DeBot activity details.
    public var activity: TSDKDebotActivity?

    public init(type: TSDKParamsOfAppDebotBrowserEnumTypes, msg: String? = nil, context_id: UInt8? = nil, action: TSDKDebotAction? = nil, prompt: String? = nil, debot_addr: String? = nil, message: String? = nil, activity: TSDKDebotActivity? = nil) {
        self.type = type
        self.msg = msg
        self.context_id = context_id
        self.action = action
        self.prompt = prompt
        self.debot_addr = debot_addr
        self.message = message
        self.activity = activity
    }
}

/// [UNSTABLE](UNSTABLE.md) Debot Browser callbacks
/// Called by debot engine to communicate with debot browser.
public struct TSDKResultOfAppDebotBrowser: Codable {
    public var type: TSDKResultOfAppDebotBrowserEnumTypes
    /// String entered by user.
    public var value: String?
    /// Signing box for signing data requested by debot engine.
    /// Signing box is owned and disposed by debot engine
    public var signing_box: TSDKSigningBoxHandle?
    /// Indicates whether the DeBot is allowed to perform the specified operation.
    public var approved: Bool?

    public init(type: TSDKResultOfAppDebotBrowserEnumTypes, value: String? = nil, signing_box: TSDKSigningBoxHandle? = nil, approved: Bool? = nil) {
        self.type = type
        self.value = value
        self.signing_box = signing_box
        self.approved = approved
    }
}

/// [UNSTABLE](UNSTABLE.md) Returning values from Debot Browser callbacks.
public struct TSDKParamsOfStart: Codable {
    /// Debot handle which references an instance of debot engine.
    public var debot_handle: TSDKDebotHandle

    public init(debot_handle: TSDKDebotHandle) {
        self.debot_handle = debot_handle
    }
}

public struct TSDKParamsOfFetch: Codable {
    /// Debot smart contract address.
    public var address: String

    public init(address: String) {
        self.address = address
    }
}

public struct TSDKResultOfFetch: Codable {
    /// Debot metadata.
    public var info: TSDKDebotInfo

    public init(info: TSDKDebotInfo) {
        self.info = info
    }
}

public struct TSDKParamsOfExecute: Codable {
    /// Debot handle which references an instance of debot engine.
    public var debot_handle: TSDKDebotHandle
    /// Debot Action that must be executed.
    public var action: TSDKDebotAction

    public init(debot_handle: TSDKDebotHandle, action: TSDKDebotAction) {
        self.debot_handle = debot_handle
        self.action = action
    }
}

public struct TSDKParamsOfSend: Codable {
    /// Debot handle which references an instance of debot engine.
    public var debot_handle: TSDKDebotHandle
    /// BOC of internal message to debot encoded in base64 format.
    public var message: String

    public init(debot_handle: TSDKDebotHandle, message: String) {
        self.debot_handle = debot_handle
        self.message = message
    }
}

public struct TSDKParamsOfRemove: Codable {
    /// Debot handle which references an instance of debot engine.
    public var debot_handle: TSDKDebotHandle

    public init(debot_handle: TSDKDebotHandle) {
        self.debot_handle = debot_handle
    }
}

