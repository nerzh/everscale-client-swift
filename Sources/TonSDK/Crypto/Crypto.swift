//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

public final class TSDKCrypto {
    
    private var binding: TSDKBinding
    public let module: String = "crypto"
    
    public init(binding: TSDKBinding) {
        self.binding = binding
    }
    
    public func factorize(_ payload: TSDKParamsOfFactorize,
                          _ handler: @escaping (TSDKBindingResponse<TSDKResultOfFactorize, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "factorize"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func modular_power(_ payload: TSDKParamsOfModularPower,
                              _ handler: @escaping (TSDKBindingResponse<TSDKResultOfModularPower, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "modular_power"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func ton_crc16(_ payload: TSDKParamsOfTonCrc16,
                          _ handler: @escaping (TSDKBindingResponse<TSDKResultOfTonCrc16, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "ton_crc16"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func generate_random_bytes(_ payload: TSDKParamsOfGenerateRandomBytes,
                                      _ handler: @escaping (TSDKBindingResponse<TSDKResultOfGenerateRandomBytes, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "generate_random_bytes"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func convert_public_key_to_ton_safe_format(_ payload: TSDKParamsOfConvertPublicKeyToTonSafeFormat,
                                                      _ handler: @escaping (TSDKBindingResponse<TSDKResultOfConvertPublicKeyToTonSafeFormat, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "convert_public_key_to_ton_safe_format"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func generate_random_sign_keys(_ handler: @escaping (TSDKBindingResponse<TSDKKeyPair, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "generate_random_sign_keys"
        binding.requestLibraryAsync(methodName(module, method), "", { (response) in
            handler(response)
        })
    }
    
    public func sign(_ payload: TSDKParamsOfSign,
                     _ handler: @escaping (TSDKBindingResponse<TSDKResultOfSign, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "sign"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func verify_signature(_ payload: TSDKParamsOfVerifySignature,
                                 _ handler: @escaping (TSDKBindingResponse<TSDKResultOfVerifySignature, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "verify_signature"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func sha256(_ payload: TSDKParamsOfHash,
                       _ handler: @escaping (TSDKBindingResponse<TSDKResultOfHash, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "sha256"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func sha512(_ payload: TSDKParamsOfHash,
                       _ handler: @escaping (TSDKBindingResponse<TSDKResultOfHash, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "sha512"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func scrypt(_ payload: TSDKParamsOfScrypt,
                       _ handler: @escaping (TSDKBindingResponse<TSDKResultOfScrypt, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "scrypt"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func nacl_sign_keypair_from_secret_key(_ payload: TSDKParamsOfNaclSignKeyPairFromSecret,
                                                  _ handler: @escaping (TSDKBindingResponse<TSDKKeyPair, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_sign_keypair_from_secret_key"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func nacl_sign(_ payload: TSDKParamsOfNaclSign,
                          _ handler: @escaping (TSDKBindingResponse<TSDKResultOfNaclSign, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_sign"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func nacl_sign_open(_ payload: TSDKParamsOfNaclSignOpen,
                               _ handler: @escaping (TSDKBindingResponse<TSDKResultOfNaclSignOpen, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_sign_open"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func nacl_sign_detached(_ payload: TSDKParamsOfNaclSign,
                                   _ handler: @escaping (TSDKBindingResponse<TSDKResultOfNaclSignDetached, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_sign_detached"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func nacl_box_keypair(_ handler: @escaping (TSDKBindingResponse<TSDKKeyPair, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_box_keypair"
        binding.requestLibraryAsync(methodName(module, method), "", { (response) in
            handler(response)
        })
    }
    
    public func nacl_box_keypair_from_secret_key(_ payload: TSDKParamsOfNaclBoxKeyPairFromSecret,
                                                 _ handler: @escaping (TSDKBindingResponse<TSDKKeyPair, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_box_keypair_from_secret_key"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func nacl_box(_ payload: TSDKParamsOfNaclBox,
                         _ handler: @escaping (TSDKBindingResponse<TSDKResultOfNaclBox, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_box"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func nacl_box_open(_ payload: TSDKParamsOfNaclBoxOpen,
                              _ handler: @escaping (TSDKBindingResponse<TSDKResultOfNaclBoxOpen, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_box_open"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func nacl_secret_box(_ payload: TSDKParamsOfNaclSecretBox,
                                _ handler: @escaping (TSDKBindingResponse<TSDKResultOfNaclBox, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_secret_box"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func nacl_secret_box_open(_ payload: TSDKParamsOfNaclSecretBoxOpen,
                                     _ handler: @escaping (TSDKBindingResponse<TSDKResultOfNaclBoxOpen, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "nacl_secret_box_open"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func mnemonic_words(_ payload: TSDKParamsOfMnemonicWords,
                               _ handler: @escaping (TSDKBindingResponse<TSDKResultOfMnemonicWords, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "mnemonic_words"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func mnemonic_from_random(_ payload: TSDKParamsOfMnemonicFromRandom,
                                     _ handler: @escaping (TSDKBindingResponse<TSDKResultOfMnemonicFromRandom, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "mnemonic_from_random"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func mnemonic_from_entropy(_ payload: TSDKParamsOfMnemonicFromEntropy,
                                      _ handler: @escaping (TSDKBindingResponse<TSDKResultOfMnemonicFromEntropy, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "mnemonic_from_entropy"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func mnemonic_verify(_ payload: TSDKParamsOfMnemonicVerify,
                                _ handler: @escaping (TSDKBindingResponse<TSDKResultOfMnemonicVerify, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "mnemonic_verify"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func mnemonic_derive_sign_keys(_ payload: TSDKParamsOfMnemonicDeriveSignKeys,
                                          _ handler: @escaping (TSDKBindingResponse<TSDKKeyPair, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "mnemonic_derive_sign_keys"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func hdkey_xprv_from_mnemonic(_ payload: TSDKParamsOfHDKeyXPrvFromMnemonic,
                                         _ handler: @escaping (TSDKBindingResponse<TSDKResultOfHDKeyXPrvFromMnemonic, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "hdkey_xprv_from_mnemonic"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func hdkey_derive_from_xprv(_ payload: TSDKParamsOfHDKeyDeriveFromXPrv,
                                       _ handler: @escaping (TSDKBindingResponse<TSDKResultOfHDKeyDeriveFromXPrv, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "hdkey_derive_from_xprv"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func hdkey_derive_from_xprv_path(_ payload: TSDKParamsOfHDKeyDeriveFromXPrvPath,
                                            _ handler: @escaping (TSDKBindingResponse<TSDKResultOfHDKeyDeriveFromXPrvPath, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "hdkey_derive_from_xprv_path"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func hdkey_secret_from_xprv(_ payload: TSDKParamsOfHDKeySecretFromXPrv,
                                       _ handler: @escaping (TSDKBindingResponse<TSDKResultOfHDKeySecretFromXPrv, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "hdkey_secret_from_xprv"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
    
    public func hdkey_public_from_xprv(_ payload: TSDKParamsOfHDKeyPublicFromXPrv,
                                       _ handler: @escaping (TSDKBindingResponse<TSDKResultOfHDKeyPublicFromXPrv, TSDKClientError, TSDKDefault>) -> Void
    ) {
        let method: String = "hdkey_public_from_xprv"
        binding.requestLibraryAsync(methodName(module, method), payload, { (response) in
            handler(response)
        })
    }
}
