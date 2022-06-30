import SwiftExtensionsPack


public typealias TSDKSigningBoxHandle = UInt32

public typealias TSDKEncryptionBoxHandle = UInt32

public typealias TSDKCryptoBoxHandle = UInt32

public enum TSDKCryptoErrorCode: Int, Codable {
    case InvalidPublicKey = 100
    case InvalidSecretKey = 101
    case InvalidKey = 102
    case InvalidFactorizeChallenge = 106
    case InvalidBigInt = 107
    case ScryptFailed = 108
    case InvalidKeySize = 109
    case NaclSecretBoxFailed = 110
    case NaclBoxFailed = 111
    case NaclSignFailed = 112
    case Bip39InvalidEntropy = 113
    case Bip39InvalidPhrase = 114
    case Bip32InvalidKey = 115
    case Bip32InvalidDerivePath = 116
    case Bip39InvalidDictionary = 117
    case Bip39InvalidWordCount = 118
    case MnemonicGenerationFailed = 119
    case MnemonicFromEntropyFailed = 120
    case SigningBoxNotRegistered = 121
    case InvalidSignature = 122
    case EncryptionBoxNotRegistered = 123
    case InvalidIvSize = 124
    case UnsupportedCipherMode = 125
    case CannotCreateCipher = 126
    case EncryptDataError = 127
    case DecryptDataError = 128
    case IvRequired = 129
    case CryptoBoxNotRegistered = 130
    case InvalidCryptoBoxType = 131
    case CryptoBoxSecretSerializationError = 132
    case CryptoBoxSecretDeserializationError = 133
    case InvalidNonceSize = 134
}

public enum TSDKEncryptionAlgorithmEnumTypes: String, Codable {
    case AES = "AES"
    case ChaCha20 = "ChaCha20"
    case NaclBox = "NaclBox"
    case NaclSecretBox = "NaclSecretBox"
}

public enum TSDKCipherMode: String, Codable {
    case CBC = "CBC"
    case CFB = "CFB"
    case CTR = "CTR"
    case ECB = "ECB"
    case OFB = "OFB"
}

public enum TSDKCryptoBoxSecretEnumTypes: String, Codable {
    case RandomSeedPhrase = "RandomSeedPhrase"
    case PredefinedSeedPhrase = "PredefinedSeedPhrase"
    case EncryptedSecret = "EncryptedSecret"
}

public enum TSDKBoxEncryptionAlgorithmEnumTypes: String, Codable {
    case ChaCha20 = "ChaCha20"
    case NaclBox = "NaclBox"
    case NaclSecretBox = "NaclSecretBox"
}

public enum TSDKParamsOfAppPasswordProviderEnumTypes: String, Codable {
    case GetPassword = "GetPassword"
}

public enum TSDKResultOfAppPasswordProviderEnumTypes: String, Codable {
    case GetPassword = "GetPassword"
}

public enum TSDKParamsOfAppSigningBoxEnumTypes: String, Codable {
    case GetPublicKey = "GetPublicKey"
    case Sign = "Sign"
}

public enum TSDKResultOfAppSigningBoxEnumTypes: String, Codable {
    case GetPublicKey = "GetPublicKey"
    case Sign = "Sign"
}

public enum TSDKParamsOfAppEncryptionBoxEnumTypes: String, Codable {
    case GetInfo = "GetInfo"
    case Encrypt = "Encrypt"
    case Decrypt = "Decrypt"
}

public enum TSDKResultOfAppEncryptionBoxEnumTypes: String, Codable {
    case GetInfo = "GetInfo"
    case Encrypt = "Encrypt"
    case Decrypt = "Decrypt"
}

public struct TSDKEncryptionBoxInfo: Codable {
    /// Derivation path, for instance "m/44'/396'/0'/0/0"
    public var hdpath: String?
    /// Cryptographic algorithm, used by this encryption box
    public var algorithm: String?
    /// Options, depends on algorithm and specific encryption box implementation
    public var options: AnyValue?
    /// Public information, depends on algorithm
    public var `public`: AnyValue?

    public init(hdpath: String? = nil, algorithm: String? = nil, options: AnyValue? = nil, `public`: AnyValue? = nil) {
        self.hdpath = hdpath
        self.algorithm = algorithm
        self.options = options
        self.`public` = `public`
    }
}

public struct TSDKEncryptionAlgorithm: Codable {
    public var type: TSDKEncryptionAlgorithmEnumTypes

    public init(type: TSDKEncryptionAlgorithmEnumTypes) {
        self.type = type
    }
}

public struct TSDKAesParamsEB: Codable {
    public var mode: TSDKCipherMode
    public var key: String
    public var iv: String?

    public init(mode: TSDKCipherMode, key: String, iv: String? = nil) {
        self.mode = mode
        self.key = key
        self.iv = iv
    }
}

public struct TSDKAesInfo: Codable {
    public var mode: TSDKCipherMode
    public var iv: String?

    public init(mode: TSDKCipherMode, iv: String? = nil) {
        self.mode = mode
        self.iv = iv
    }
}

public struct TSDKChaCha20ParamsEB: Codable {
    /// 256-bit key.
    /// Must be encoded with `hex`.
    public var key: String
    /// 96-bit nonce.
    /// Must be encoded with `hex`.
    public var nonce: String

    public init(key: String, nonce: String) {
        self.key = key
        self.nonce = nonce
    }
}

public struct TSDKNaclBoxParamsEB: Codable {
    /// 256-bit key.
    /// Must be encoded with `hex`.
    public var their_public: String
    /// 256-bit key.
    /// Must be encoded with `hex`.
    public var secret: String
    /// 96-bit nonce.
    /// Must be encoded with `hex`.
    public var nonce: String

    public init(their_public: String, secret: String, nonce: String) {
        self.their_public = their_public
        self.secret = secret
        self.nonce = nonce
    }
}

public struct TSDKNaclSecretBoxParamsEB: Codable {
    /// Secret key - unprefixed 0-padded to 64 symbols hex string
    public var key: String
    /// Nonce in `hex`
    public var nonce: String

    public init(key: String, nonce: String) {
        self.key = key
        self.nonce = nonce
    }
}

public struct TSDKCryptoBoxSecret: Codable {
    public var type: TSDKCryptoBoxSecretEnumTypes
    public var dictionary: TSDKMnemonicDictionary?
    public var wordcount: UInt8?
    public var phrase: String?
    /// It is an object, containing encrypted seed phrase or private key (now we support only seed phrase).
    public var encrypted_secret: String?

    public init(type: TSDKCryptoBoxSecretEnumTypes, dictionary: TSDKMnemonicDictionary? = nil, wordcount: UInt8? = nil, phrase: String? = nil, encrypted_secret: String? = nil) {
        self.type = type
        self.dictionary = dictionary
        self.wordcount = wordcount
        self.phrase = phrase
        self.encrypted_secret = encrypted_secret
    }
}

/// Crypto Box Secret.
public struct TSDKBoxEncryptionAlgorithm: Codable {
    public var type: TSDKBoxEncryptionAlgorithmEnumTypes

    public init(type: TSDKBoxEncryptionAlgorithmEnumTypes) {
        self.type = type
    }
}

public struct TSDKChaCha20ParamsCB: Codable {
    /// 96-bit nonce.
    /// Must be encoded with `hex`.
    public var nonce: String

    public init(nonce: String) {
        self.nonce = nonce
    }
}

public struct TSDKNaclBoxParamsCB: Codable {
    /// 256-bit key.
    /// Must be encoded with `hex`.
    public var their_public: String
    /// 96-bit nonce.
    /// Must be encoded with `hex`.
    public var nonce: String

    public init(their_public: String, nonce: String) {
        self.their_public = their_public
        self.nonce = nonce
    }
}

public struct TSDKNaclSecretBoxParamsCB: Codable {
    /// Nonce in `hex`
    public var nonce: String

    public init(nonce: String) {
        self.nonce = nonce
    }
}

public struct TSDKParamsOfFactorize: Codable {
    /// Hexadecimal representation of u64 composite number.
    public var composite: String

    public init(composite: String) {
        self.composite = composite
    }
}

public struct TSDKResultOfFactorize: Codable {
    /// Two factors of composite or empty if composite can't be factorized.
    public var factors: [String]

    public init(factors: [String]) {
        self.factors = factors
    }
}

public struct TSDKParamsOfModularPower: Codable {
    /// `base` argument of calculation.
    public var base: String
    /// `exponent` argument of calculation.
    public var exponent: String
    /// `modulus` argument of calculation.
    public var modulus: String

    public init(base: String, exponent: String, modulus: String) {
        self.base = base
        self.exponent = exponent
        self.modulus = modulus
    }
}

public struct TSDKResultOfModularPower: Codable {
    /// Result of modular exponentiation
    public var modular_power: String

    public init(modular_power: String) {
        self.modular_power = modular_power
    }
}

public struct TSDKParamsOfTonCrc16: Codable {
    /// Input data for CRC calculation.
    /// Encoded with `base64`.
    public var data: String

    public init(data: String) {
        self.data = data
    }
}

public struct TSDKResultOfTonCrc16: Codable {
    /// Calculated CRC for input data.
    public var crc: UInt16

    public init(crc: UInt16) {
        self.crc = crc
    }
}

public struct TSDKParamsOfGenerateRandomBytes: Codable {
    /// Size of random byte array.
    public var length: UInt32

    public init(length: UInt32) {
        self.length = length
    }
}

public struct TSDKResultOfGenerateRandomBytes: Codable {
    /// Generated bytes encoded in `base64`.
    public var bytes: String

    public init(bytes: String) {
        self.bytes = bytes
    }
}

public struct TSDKParamsOfConvertPublicKeyToTonSafeFormat: Codable {
    /// Public key - 64 symbols hex string
    public var public_key: String

    public init(public_key: String) {
        self.public_key = public_key
    }
}

public struct TSDKResultOfConvertPublicKeyToTonSafeFormat: Codable {
    /// Public key represented in TON safe format.
    public var ton_public_key: String

    public init(ton_public_key: String) {
        self.ton_public_key = ton_public_key
    }
}

public struct TSDKKeyPair: Codable {
    /// Public key - 64 symbols hex string
    public var `public`: String
    /// Private key - u64 symbols hex string
    public var secret: String

    public init(`public`: String, secret: String) {
        self.`public` = `public`
        self.secret = secret
    }
}

public struct TSDKParamsOfSign: Codable {
    /// Data that must be signed encoded in `base64`.
    public var unsigned: String
    /// Sign keys.
    public var keys: TSDKKeyPair

    public init(unsigned: String, keys: TSDKKeyPair) {
        self.unsigned = unsigned
        self.keys = keys
    }
}

public struct TSDKResultOfSign: Codable {
    /// Signed data combined with signature encoded in `base64`.
    public var signed: String
    /// Signature encoded in `hex`.
    public var signature: String

    public init(signed: String, signature: String) {
        self.signed = signed
        self.signature = signature
    }
}

public struct TSDKParamsOfVerifySignature: Codable {
    /// Signed data that must be verified encoded in `base64`.
    public var signed: String
    /// Signer's public key - 64 symbols hex string
    public var `public`: String

    public init(signed: String, `public`: String) {
        self.signed = signed
        self.`public` = `public`
    }
}

public struct TSDKResultOfVerifySignature: Codable {
    /// Unsigned data encoded in `base64`.
    public var unsigned: String

    public init(unsigned: String) {
        self.unsigned = unsigned
    }
}

public struct TSDKParamsOfHash: Codable {
    /// Input data for hash calculation.
    /// Encoded with `base64`.
    public var data: String

    public init(data: String) {
        self.data = data
    }
}

public struct TSDKResultOfHash: Codable {
    /// Hash of input `data`.
    /// Encoded with 'hex'.
    public var hash: String

    public init(hash: String) {
        self.hash = hash
    }
}

public struct TSDKParamsOfScrypt: Codable {
    /// The password bytes to be hashed. Must be encoded with `base64`.
    public var password: String
    /// Salt bytes that modify the hash to protect against Rainbow table attacks. Must be encoded with `base64`.
    public var salt: String
    /// CPU/memory cost parameter
    public var log_n: UInt8
    /// The block size parameter, which fine-tunes sequential memory read size and performance.
    public var r: UInt32
    /// Parallelization parameter.
    public var p: UInt32
    /// Intended output length in octets of the derived key.
    public var dk_len: UInt32

    public init(password: String, salt: String, log_n: UInt8, r: UInt32, p: UInt32, dk_len: UInt32) {
        self.password = password
        self.salt = salt
        self.log_n = log_n
        self.r = r
        self.p = p
        self.dk_len = dk_len
    }
}

public struct TSDKResultOfScrypt: Codable {
    /// Derived key.
    /// Encoded with `hex`.
    public var key: String

    public init(key: String) {
        self.key = key
    }
}

public struct TSDKParamsOfNaclSignKeyPairFromSecret: Codable {
    /// Secret key - unprefixed 0-padded to 64 symbols hex string
    public var secret: String

    public init(secret: String) {
        self.secret = secret
    }
}

public struct TSDKParamsOfNaclSign: Codable {
    /// Data that must be signed encoded in `base64`.
    public var unsigned: String
    /// Signer's secret key - unprefixed 0-padded to 128 symbols hex string (concatenation of 64 symbols secret and 64 symbols public keys). See `nacl_sign_keypair_from_secret_key`.
    public var secret: String

    public init(unsigned: String, secret: String) {
        self.unsigned = unsigned
        self.secret = secret
    }
}

public struct TSDKResultOfNaclSign: Codable {
    /// Signed data, encoded in `base64`.
    public var signed: String

    public init(signed: String) {
        self.signed = signed
    }
}

public struct TSDKParamsOfNaclSignOpen: Codable {
    /// Signed data that must be unsigned.
    /// Encoded with `base64`.
    public var signed: String
    /// Signer's public key - unprefixed 0-padded to 64 symbols hex string
    public var `public`: String

    public init(signed: String, `public`: String) {
        self.signed = signed
        self.`public` = `public`
    }
}

public struct TSDKResultOfNaclSignOpen: Codable {
    /// Unsigned data, encoded in `base64`.
    public var unsigned: String

    public init(unsigned: String) {
        self.unsigned = unsigned
    }
}

public struct TSDKResultOfNaclSignDetached: Codable {
    /// Signature encoded in `hex`.
    public var signature: String

    public init(signature: String) {
        self.signature = signature
    }
}

public struct TSDKParamsOfNaclSignDetachedVerify: Codable {
    /// Unsigned data that must be verified.
    /// Encoded with `base64`.
    public var unsigned: String
    /// Signature that must be verified.
    /// Encoded with `hex`.
    public var signature: String
    /// Signer's public key - unprefixed 0-padded to 64 symbols hex string.
    public var `public`: String

    public init(unsigned: String, signature: String, `public`: String) {
        self.unsigned = unsigned
        self.signature = signature
        self.`public` = `public`
    }
}

public struct TSDKResultOfNaclSignDetachedVerify: Codable {
    /// `true` if verification succeeded or `false` if it failed
    public var succeeded: Bool

    public init(succeeded: Bool) {
        self.succeeded = succeeded
    }
}

public struct TSDKParamsOfNaclBoxKeyPairFromSecret: Codable {
    /// Secret key - unprefixed 0-padded to 64 symbols hex string
    public var secret: String

    public init(secret: String) {
        self.secret = secret
    }
}

public struct TSDKParamsOfNaclBox: Codable {
    /// Data that must be encrypted encoded in `base64`.
    public var decrypted: String
    /// Nonce, encoded in `hex`
    public var nonce: String
    /// Receiver's public key - unprefixed 0-padded to 64 symbols hex string
    public var their_public: String
    /// Sender's private key - unprefixed 0-padded to 64 symbols hex string
    public var secret: String

    public init(decrypted: String, nonce: String, their_public: String, secret: String) {
        self.decrypted = decrypted
        self.nonce = nonce
        self.their_public = their_public
        self.secret = secret
    }
}

public struct TSDKResultOfNaclBox: Codable {
    /// Encrypted data encoded in `base64`.
    public var encrypted: String

    public init(encrypted: String) {
        self.encrypted = encrypted
    }
}

public struct TSDKParamsOfNaclBoxOpen: Codable {
    /// Data that must be decrypted.
    /// Encoded with `base64`.
    public var encrypted: String
    /// Nonce
    public var nonce: String
    /// Sender's public key - unprefixed 0-padded to 64 symbols hex string
    public var their_public: String
    /// Receiver's private key - unprefixed 0-padded to 64 symbols hex string
    public var secret: String

    public init(encrypted: String, nonce: String, their_public: String, secret: String) {
        self.encrypted = encrypted
        self.nonce = nonce
        self.their_public = their_public
        self.secret = secret
    }
}

public struct TSDKResultOfNaclBoxOpen: Codable {
    /// Decrypted data encoded in `base64`.
    public var decrypted: String

    public init(decrypted: String) {
        self.decrypted = decrypted
    }
}

public struct TSDKParamsOfNaclSecretBox: Codable {
    /// Data that must be encrypted.
    /// Encoded with `base64`.
    public var decrypted: String
    /// Nonce in `hex`
    public var nonce: String
    /// Secret key - unprefixed 0-padded to 64 symbols hex string
    public var key: String

    public init(decrypted: String, nonce: String, key: String) {
        self.decrypted = decrypted
        self.nonce = nonce
        self.key = key
    }
}

public struct TSDKParamsOfNaclSecretBoxOpen: Codable {
    /// Data that must be decrypted.
    /// Encoded with `base64`.
    public var encrypted: String
    /// Nonce in `hex`
    public var nonce: String
    /// Secret key - unprefixed 0-padded to 64 symbols hex string
    public var key: String

    public init(encrypted: String, nonce: String, key: String) {
        self.encrypted = encrypted
        self.nonce = nonce
        self.key = key
    }
}

public struct TSDKParamsOfMnemonicWords: Codable {
    /// Dictionary identifier
    public var dictionary: TSDKMnemonicDictionary?

    public init(dictionary: TSDKMnemonicDictionary? = nil) {
        self.dictionary = dictionary
    }
}

public struct TSDKResultOfMnemonicWords: Codable {
    /// The list of mnemonic words
    public var words: String

    public init(words: String) {
        self.words = words
    }
}

public struct TSDKParamsOfMnemonicFromRandom: Codable {
    /// Dictionary identifier
    public var dictionary: TSDKMnemonicDictionary?
    /// Mnemonic word count
    public var word_count: UInt8?

    public init(dictionary: TSDKMnemonicDictionary? = nil, word_count: UInt8? = nil) {
        self.dictionary = dictionary
        self.word_count = word_count
    }
}

public struct TSDKResultOfMnemonicFromRandom: Codable {
    /// String of mnemonic words
    public var phrase: String

    public init(phrase: String) {
        self.phrase = phrase
    }
}

public struct TSDKParamsOfMnemonicFromEntropy: Codable {
    /// Entropy bytes.
    /// Hex encoded.
    public var entropy: String
    /// Dictionary identifier
    public var dictionary: TSDKMnemonicDictionary?
    /// Mnemonic word count
    public var word_count: UInt8?

    public init(entropy: String, dictionary: TSDKMnemonicDictionary? = nil, word_count: UInt8? = nil) {
        self.entropy = entropy
        self.dictionary = dictionary
        self.word_count = word_count
    }
}

public struct TSDKResultOfMnemonicFromEntropy: Codable {
    /// Phrase
    public var phrase: String

    public init(phrase: String) {
        self.phrase = phrase
    }
}

public struct TSDKParamsOfMnemonicVerify: Codable {
    /// Phrase
    public var phrase: String
    /// Dictionary identifier
    public var dictionary: TSDKMnemonicDictionary?
    /// Word count
    public var word_count: UInt8?

    public init(phrase: String, dictionary: TSDKMnemonicDictionary? = nil, word_count: UInt8? = nil) {
        self.phrase = phrase
        self.dictionary = dictionary
        self.word_count = word_count
    }
}

public struct TSDKResultOfMnemonicVerify: Codable {
    /// Flag indicating if the mnemonic is valid or not
    public var valid: Bool

    public init(valid: Bool) {
        self.valid = valid
    }
}

public struct TSDKParamsOfMnemonicDeriveSignKeys: Codable {
    /// Phrase
    public var phrase: String
    /// Derivation path, for instance "m/44'/396'/0'/0/0"
    public var path: String?
    /// Dictionary identifier
    public var dictionary: TSDKMnemonicDictionary?
    /// Word count
    public var word_count: UInt8?

    public init(phrase: String, path: String? = nil, dictionary: TSDKMnemonicDictionary? = nil, word_count: UInt8? = nil) {
        self.phrase = phrase
        self.path = path
        self.dictionary = dictionary
        self.word_count = word_count
    }
}

public struct TSDKParamsOfHDKeyXPrvFromMnemonic: Codable {
    /// String with seed phrase
    public var phrase: String
    /// Dictionary identifier
    public var dictionary: TSDKMnemonicDictionary?
    /// Mnemonic word count
    public var word_count: UInt8?

    public init(phrase: String, dictionary: TSDKMnemonicDictionary? = nil, word_count: UInt8? = nil) {
        self.phrase = phrase
        self.dictionary = dictionary
        self.word_count = word_count
    }
}

public struct TSDKResultOfHDKeyXPrvFromMnemonic: Codable {
    /// Serialized extended master private key
    public var xprv: String

    public init(xprv: String) {
        self.xprv = xprv
    }
}

public struct TSDKParamsOfHDKeyDeriveFromXPrv: Codable {
    /// Serialized extended private key
    public var xprv: String
    /// Child index (see BIP-0032)
    public var child_index: UInt32
    /// Indicates the derivation of hardened/not-hardened key (see BIP-0032)
    public var hardened: Bool

    public init(xprv: String, child_index: UInt32, hardened: Bool) {
        self.xprv = xprv
        self.child_index = child_index
        self.hardened = hardened
    }
}

public struct TSDKResultOfHDKeyDeriveFromXPrv: Codable {
    /// Serialized extended private key
    public var xprv: String

    public init(xprv: String) {
        self.xprv = xprv
    }
}

public struct TSDKParamsOfHDKeyDeriveFromXPrvPath: Codable {
    /// Serialized extended private key
    public var xprv: String
    /// Derivation path, for instance "m/44'/396'/0'/0/0"
    public var path: String

    public init(xprv: String, path: String) {
        self.xprv = xprv
        self.path = path
    }
}

public struct TSDKResultOfHDKeyDeriveFromXPrvPath: Codable {
    /// Derived serialized extended private key
    public var xprv: String

    public init(xprv: String) {
        self.xprv = xprv
    }
}

public struct TSDKParamsOfHDKeySecretFromXPrv: Codable {
    /// Serialized extended private key
    public var xprv: String

    public init(xprv: String) {
        self.xprv = xprv
    }
}

public struct TSDKResultOfHDKeySecretFromXPrv: Codable {
    /// Private key - 64 symbols hex string
    public var secret: String

    public init(secret: String) {
        self.secret = secret
    }
}

public struct TSDKParamsOfHDKeyPublicFromXPrv: Codable {
    /// Serialized extended private key
    public var xprv: String

    public init(xprv: String) {
        self.xprv = xprv
    }
}

public struct TSDKResultOfHDKeyPublicFromXPrv: Codable {
    /// Public key - 64 symbols hex string
    public var `public`: String

    public init(`public`: String) {
        self.`public` = `public`
    }
}

public struct TSDKParamsOfChaCha20: Codable {
    /// Source data to be encrypted or decrypted.
    /// Must be encoded with `base64`.
    public var data: String
    /// 256-bit key.
    /// Must be encoded with `hex`.
    public var key: String
    /// 96-bit nonce.
    /// Must be encoded with `hex`.
    public var nonce: String

    public init(data: String, key: String, nonce: String) {
        self.data = data
        self.key = key
        self.nonce = nonce
    }
}

public struct TSDKResultOfChaCha20: Codable {
    /// Encrypted/decrypted data.
    /// Encoded with `base64`.
    public var data: String

    public init(data: String) {
        self.data = data
    }
}

public struct TSDKParamsOfCreateCryptoBox: Codable {
    /// Salt used for secret encryption. For example, a mobile device can use device ID as salt.
    public var secret_encryption_salt: String
    /// Cryptobox secret
    public var secret: TSDKCryptoBoxSecret

    public init(secret_encryption_salt: String, secret: TSDKCryptoBoxSecret) {
        self.secret_encryption_salt = secret_encryption_salt
        self.secret = secret
    }
}

public struct TSDKRegisteredCryptoBox: Codable {
    public var handle: TSDKCryptoBoxHandle

    public init(handle: TSDKCryptoBoxHandle) {
        self.handle = handle
    }
}

public struct TSDKParamsOfAppPasswordProvider: Codable {
    public var type: TSDKParamsOfAppPasswordProviderEnumTypes
    /// Temporary library pubkey, that is used on application side for password encryption, along with application temporary private key and nonce. Used for password decryption on library side.
    public var encryption_public_key: String?

    public init(type: TSDKParamsOfAppPasswordProviderEnumTypes, encryption_public_key: String? = nil) {
        self.type = type
        self.encryption_public_key = encryption_public_key
    }
}

/// Interface that provides a callback that returns an encrypted password, used for cryptobox secret encryption
/// To secure the password while passing it from application to the library,the library generates a temporary key pair, passes the pubkeyto the passwordProvider, decrypts the received password with private key,and deletes the key pair right away.
    /// Application should generate a temporary nacl_box_keypairand encrypt the password with naclbox function using nacl_box_keypair.secretand encryption_public_key keys + nonce = 24-byte prefix of encryption_public_key.
public struct TSDKResultOfAppPasswordProvider: Codable {
    public var type: TSDKResultOfAppPasswordProviderEnumTypes
    /// Password, encrypted and encoded to base64. Crypto box uses this password to decrypt its secret (seed phrase).
    public var encrypted_password: String?
    /// Hex encoded public key of a temporary key pair, used for password encryption on application side.
    /// Used together with `encryption_public_key` to decode `encrypted_password`.
    public var app_encryption_pubkey: String?

    public init(type: TSDKResultOfAppPasswordProviderEnumTypes, encrypted_password: String? = nil, app_encryption_pubkey: String? = nil) {
        self.type = type
        self.encrypted_password = encrypted_password
        self.app_encryption_pubkey = app_encryption_pubkey
    }
}

public struct TSDKResultOfGetCryptoBoxInfo: Codable {
    /// Secret (seed phrase) encrypted with salt and password.
    public var encrypted_secret: String

    public init(encrypted_secret: String) {
        self.encrypted_secret = encrypted_secret
    }
}

public struct TSDKResultOfGetCryptoBoxSeedPhrase: Codable {
    public var phrase: String
    public var dictionary: TSDKMnemonicDictionary
    public var wordcount: UInt8

    public init(phrase: String, dictionary: TSDKMnemonicDictionary, wordcount: UInt8) {
        self.phrase = phrase
        self.dictionary = dictionary
        self.wordcount = wordcount
    }
}

public struct TSDKParamsOfGetSigningBoxFromCryptoBox: Codable {
    /// Crypto Box Handle.
    public var handle: UInt32
    /// HD key derivation path.
    /// By default, Everscale HD path is used.
    public var hdpath: String?
    /// Store derived secret for this lifetime (in ms). The timer starts after each signing box operation. Secrets will be deleted immediately after each signing box operation, if this value is not set.
    public var secret_lifetime: UInt32?

    public init(handle: UInt32, hdpath: String? = nil, secret_lifetime: UInt32? = nil) {
        self.handle = handle
        self.hdpath = hdpath
        self.secret_lifetime = secret_lifetime
    }
}

public struct TSDKRegisteredSigningBox: Codable {
    /// Handle of the signing box.
    public var handle: TSDKSigningBoxHandle

    public init(handle: TSDKSigningBoxHandle) {
        self.handle = handle
    }
}

public struct TSDKParamsOfGetEncryptionBoxFromCryptoBox: Codable {
    /// Crypto Box Handle.
    public var handle: UInt32
    /// HD key derivation path.
    /// By default, Everscale HD path is used.
    public var hdpath: String?
    /// Encryption algorithm.
    public var algorithm: TSDKBoxEncryptionAlgorithm
    /// Store derived secret for encryption algorithm for this lifetime (in ms). The timer starts after each encryption box operation. Secrets will be deleted (overwritten with zeroes) after each encryption operation, if this value is not set.
    public var secret_lifetime: UInt32?

    public init(handle: UInt32, hdpath: String? = nil, algorithm: TSDKBoxEncryptionAlgorithm, secret_lifetime: UInt32? = nil) {
        self.handle = handle
        self.hdpath = hdpath
        self.algorithm = algorithm
        self.secret_lifetime = secret_lifetime
    }
}

public struct TSDKRegisteredEncryptionBox: Codable {
    /// Handle of the encryption box.
    public var handle: TSDKEncryptionBoxHandle

    public init(handle: TSDKEncryptionBoxHandle) {
        self.handle = handle
    }
}

public struct TSDKParamsOfAppSigningBox: Codable {
    public var type: TSDKParamsOfAppSigningBoxEnumTypes
    /// Data to sign encoded as base64
    public var unsigned: String?

    public init(type: TSDKParamsOfAppSigningBoxEnumTypes, unsigned: String? = nil) {
        self.type = type
        self.unsigned = unsigned
    }
}

/// Signing box callbacks.
public struct TSDKResultOfAppSigningBox: Codable {
    public var type: TSDKResultOfAppSigningBoxEnumTypes
    /// Signing box public key
    public var public_key: String?
    /// Data signature encoded as hex
    public var signature: String?

    public init(type: TSDKResultOfAppSigningBoxEnumTypes, public_key: String? = nil, signature: String? = nil) {
        self.type = type
        self.public_key = public_key
        self.signature = signature
    }
}

/// Returning values from signing box callbacks.
public struct TSDKResultOfSigningBoxGetPublicKey: Codable {
    /// Public key of signing box.
    /// Encoded with hex
    public var pubkey: String

    public init(pubkey: String) {
        self.pubkey = pubkey
    }
}

public struct TSDKParamsOfSigningBoxSign: Codable {
    /// Signing Box handle.
    public var signing_box: TSDKSigningBoxHandle
    /// Unsigned user data.
    /// Must be encoded with `base64`.
    public var unsigned: String

    public init(signing_box: TSDKSigningBoxHandle, unsigned: String) {
        self.signing_box = signing_box
        self.unsigned = unsigned
    }
}

public struct TSDKResultOfSigningBoxSign: Codable {
    /// Data signature.
    /// Encoded with `hex`.
    public var signature: String

    public init(signature: String) {
        self.signature = signature
    }
}

public struct TSDKParamsOfAppEncryptionBox: Codable {
    public var type: TSDKParamsOfAppEncryptionBoxEnumTypes
    /// Data, encoded in Base64
    public var data: String?

    public init(type: TSDKParamsOfAppEncryptionBoxEnumTypes, data: String? = nil) {
        self.type = type
        self.data = data
    }
}

/// Interface for data encryption/decryption
public struct TSDKResultOfAppEncryptionBox: Codable {
    public var type: TSDKResultOfAppEncryptionBoxEnumTypes
    public var info: TSDKEncryptionBoxInfo?
    /// Encrypted data, encoded in Base64
    public var data: String?

    public init(type: TSDKResultOfAppEncryptionBoxEnumTypes, info: TSDKEncryptionBoxInfo? = nil, data: String? = nil) {
        self.type = type
        self.info = info
        self.data = data
    }
}

/// Returning values from signing box callbacks.
public struct TSDKParamsOfEncryptionBoxGetInfo: Codable {
    /// Encryption box handle
    public var encryption_box: TSDKEncryptionBoxHandle

    public init(encryption_box: TSDKEncryptionBoxHandle) {
        self.encryption_box = encryption_box
    }
}

public struct TSDKResultOfEncryptionBoxGetInfo: Codable {
    /// Encryption box information
    public var info: TSDKEncryptionBoxInfo

    public init(info: TSDKEncryptionBoxInfo) {
        self.info = info
    }
}

public struct TSDKParamsOfEncryptionBoxEncrypt: Codable {
    /// Encryption box handle
    public var encryption_box: TSDKEncryptionBoxHandle
    /// Data to be encrypted, encoded in Base64
    public var data: String

    public init(encryption_box: TSDKEncryptionBoxHandle, data: String) {
        self.encryption_box = encryption_box
        self.data = data
    }
}

public struct TSDKResultOfEncryptionBoxEncrypt: Codable {
    /// Encrypted data, encoded in Base64.
    /// Padded to cipher block size
    public var data: String

    public init(data: String) {
        self.data = data
    }
}

public struct TSDKParamsOfEncryptionBoxDecrypt: Codable {
    /// Encryption box handle
    public var encryption_box: TSDKEncryptionBoxHandle
    /// Data to be decrypted, encoded in Base64
    public var data: String

    public init(encryption_box: TSDKEncryptionBoxHandle, data: String) {
        self.encryption_box = encryption_box
        self.data = data
    }
}

public struct TSDKResultOfEncryptionBoxDecrypt: Codable {
    /// Decrypted data, encoded in Base64.
    public var data: String

    public init(data: String) {
        self.data = data
    }
}

public struct TSDKParamsOfCreateEncryptionBox: Codable {
    /// Encryption algorithm specifier including cipher parameters (key, IV, etc)
    public var algorithm: TSDKEncryptionAlgorithm

    public init(algorithm: TSDKEncryptionAlgorithm) {
        self.algorithm = algorithm
    }
}

