//
//  File.swift
//
//
//  Created by Oleh Hudeichuk on 20.10.2020.
//

import XCTest
import class Foundation.Bundle
@testable import EverscaleClientSwift
@testable import CTonSDK

final class CryptoTests: XCTestCase {

    func testFactorize() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            try client.crypto.factorize(TSDKParamsOfFactorize(composite: "17ED48941A08F981")) { [group] (response) in
                XCTAssertEqual(response.result?.factors, ["494C553B", "53911073"])
                group.leave()
            }
            group.wait()
        }
    }

    func testModular_power() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfModularPower = .init(base: "0123456789ABCDEF", exponent: "0123", modulus: "01234567")
            try client.crypto.modular_power(payload) { [group] (response) in
                XCTAssertEqual(response.result?.modular_power, "63bfdf")
                group.leave()
            }
            group.wait()
        }
    }

    func testTon_crc16() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfTonCrc16 = .init(data: "MHgzMSAweDMyIDB4MzMgMHgzNCAweDM1IDB4MzYgMHgzNyAweDM4IDB4Mzk=")
            try client.crypto.ton_crc16(payload) { [group] (response) in
                XCTAssertEqual(response.result?.crc, 63574)
                group.leave()
            }
            group.wait()
        }
    }

    func testGenerate_random_bytes() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfGenerateRandomBytes = .init(length: 32)
            try client.crypto.generate_random_bytes(payload) { [group] (response) in
                XCTAssertEqual(response.result?.bytes.count, 44)
                group.leave()
            }
            group.wait()
        }
    }

    func testConvert_public_key_to_ton_safe_format() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfConvertPublicKeyToTonSafeFormat = .init(public_key: "d007e112febb206f0871e6b135fb2047ad58e77329035457c0e8b7dfc110294a")
            try client.crypto.convert_public_key_to_ton_safe_format(payload) { [group] (response) in
                XCTAssertEqual(response.result?.ton_public_key, "PubQB-ES_rsgbwhx5rE1-yBHrVjncykDVFfA6LffwRApSsiQ")
                group.leave()
            }
            group.wait()
        }
    }

    func testGenerate_random_sign_keys() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            try client.crypto.generate_random_sign_keys() { [group] (response) in
                XCTAssertTrue(response.result?.public != nil)
                XCTAssertTrue(response.result?.secret != nil)
                XCTAssertEqual(response.result?.public.count, 64)
                XCTAssertEqual(response.result?.secret.count, 64)
                group.leave()
            }
            group.wait()
        }
    }

    func testSign() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfSign = .init(unsigned: "Hello".base64Encoded() ?? "", keys: TSDKKeyPair.init(public: "a5c367411a00ab0b542d118649de388b43ce4b7fa6dae2bb9243c6ad9aca7661", secret: "254c097277e9dd09d16152ee85abde4be54030db9930e38bf7069e4684ac10bb"))
            try client.crypto.sign(payload) { [group] (response) in
                XCTAssertEqual(response.result?.signed, "JvgdakMHpOdw7PKJX/IMQDygYJxt/kzEge0ebJHXx7H8eUOYMcL7sN0YBfwP/QZ0Z8XpffpyDJdwLpTErtnCDEhlbGxv")
                XCTAssertEqual(response.result?.signature, "26f81d6a4307a4e770ecf2895ff20c403ca0609c6dfe4cc481ed1e6c91d7c7b1fc79439831c2fbb0dd1805fc0ffd067467c5e97dfa720c97702e94c4aed9c20c")
                group.leave()
            }
            group.wait()
        }
    }

    func testVerify_signature() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfVerifySignature = .init(signed: "JvgdakMHpOdw7PKJX/IMQDygYJxt/kzEge0ebJHXx7H8eUOYMcL7sN0YBfwP/QZ0Z8XpffpyDJdwLpTErtnCDEhlbGxv", public: "a5c367411a00ab0b542d118649de388b43ce4b7fa6dae2bb9243c6ad9aca7661")
            try client.crypto.verify_signature(payload) { [group] (response) in
                XCTAssertEqual(response.result?.unsigned, "SGVsbG8=")
                group.leave()
            }
            group.wait()
        }
    }

    func testSha256() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfHash = .init(data: "Hello".base64Encoded() ?? "")
            try client.crypto.sha256(payload) { [group] (response) in
                XCTAssertEqual(response.result?.hash, "185f8db32271fe25f561a6fc938b2e264306ec304eda518007d1764826381969")
                group.leave()
            }
            group.wait()
        }
    }

    func testSha512() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfHash = .init(data: "Hello".base64Encoded() ?? "")
            try client.crypto.sha512(payload) { [group] (response) in
                XCTAssertEqual(response.result?.hash, "3615f80c9d293ed7402687f94b22d58e529b8cc7916f8fac7fddf7fbd5af4cf777d3d795a7a00a16bf7e7f3fb9561ee9baae480da9fe7a18769e71886b03f315")
                group.leave()
            }
            group.wait()
        }
    }

    func testScrypt() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfScrypt = .init(password: "Test Password".base64Encoded() ?? "", salt: "Test Salt".base64Encoded() ?? "", log_n: 5, r: 4, p: 8, dk_len: 32)
            try client.crypto.scrypt(payload) { [group] (response) in
                XCTAssertEqual(response.result?.key, "7cc741fa9cb4eb1edd36629e224e9cc8c316810ac540e4eb9ba578ff1643a3b9")
                group.leave()
            }
            group.wait()
        }
    }

    func testNacl_sign_keypair_from_secret_key() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfNaclSignKeyPairFromSecret = .init(secret: "254c097277e9dd09d16152ee85abde4be54030db9930e38bf7069e4684ac10bb")
            try client.crypto.nacl_sign_keypair_from_secret_key(payload) { [group] (response) in
                XCTAssertEqual(response.result?.public, "a5c367411a00ab0b542d118649de388b43ce4b7fa6dae2bb9243c6ad9aca7661")
                XCTAssertEqual(response.result?.secret, "254c097277e9dd09d16152ee85abde4be54030db9930e38bf7069e4684ac10bba5c367411a00ab0b542d118649de388b43ce4b7fa6dae2bb9243c6ad9aca7661")
                group.leave()
            }
            group.wait()
        }
    }

    func testNacl_sign() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfNaclSign = .init(unsigned: "Hello".base64Encoded() ?? "",
                                                      secret: "254c097277e9dd09d16152ee85abde4be54030db9930e38bf7069e4684ac10bba5c367411a00ab0b542d118649de388b43ce4b7fa6dae2bb9243c6ad9aca7661")
            try client.crypto.nacl_sign(payload) { [group] (response) in
                XCTAssertEqual(response.result?.signed, "JvgdakMHpOdw7PKJX/IMQDygYJxt/kzEge0ebJHXx7H8eUOYMcL7sN0YBfwP/QZ0Z8XpffpyDJdwLpTErtnCDEhlbGxv")
                group.leave()
            }
            group.wait()
        }
    }

    func testNacl_sign_open() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfNaclSignOpen = .init(signed: "JvgdakMHpOdw7PKJX/IMQDygYJxt/kzEge0ebJHXx7H8eUOYMcL7sN0YBfwP/QZ0Z8XpffpyDJdwLpTErtnCDEhlbGxv",
                                                          public: "a5c367411a00ab0b542d118649de388b43ce4b7fa6dae2bb9243c6ad9aca7661")
            try client.crypto.nacl_sign_open(payload) { [group] (response) in
                XCTAssertEqual(response.result?.unsigned, "SGVsbG8=")
                group.leave()
            }
            group.wait()
        }
    }

    func testNacl_sign_detached() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfNaclSign = .init(unsigned: "Hello".base64Encoded() ?? "", secret: "254c097277e9dd09d16152ee85abde4be54030db9930e38bf7069e4684ac10bba5c367411a00ab0b542d118649de388b43ce4b7fa6dae2bb9243c6ad9aca7661")
            try client.crypto.nacl_sign_detached(payload) { [group] (response) in
                XCTAssertEqual(response.result?.signature, "26f81d6a4307a4e770ecf2895ff20c403ca0609c6dfe4cc481ed1e6c91d7c7b1fc79439831c2fbb0dd1805fc0ffd067467c5e97dfa720c97702e94c4aed9c20c")
                group.leave()
            }
            group.wait()
        }
    }

    func testNacl_box_keypair() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            try client.crypto.nacl_box_keypair() { [group] (response) in
                XCTAssertTrue(response.result?.public != nil)
                XCTAssertTrue(response.result?.secret != nil)
                XCTAssertEqual(response.result?.public.count, 64)
                XCTAssertEqual(response.result?.secret.count, 64)
                group.leave()
            }
            group.wait()
        }
    }

    func testNacl_box_keypair_from_secret_key() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfNaclBoxKeyPairFromSecret = .init(secret: "254c097277e9dd09d16152ee85abde4be54030db9930e38bf7069e4684ac10bb")
            try client.crypto.nacl_box_keypair_from_secret_key(payload) { [group] (response) in
                XCTAssertEqual(response.result?.public, "57172b0bd70f4bc65bb8a82bd0926a1a3f8f471e16fd9d8f329bec976afe3454")
                XCTAssertEqual(response.result?.secret, "254c097277e9dd09d16152ee85abde4be54030db9930e38bf7069e4684ac10bb")
                group.leave()
            }
            group.wait()
        }
    }

    func testNacl_box() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfNaclBox = .init(decrypted: "Test Message".base64Encoded() ?? "",
                                                     nonce: "cd7f99924bf422544046e83595dd5803f17536f5c9a11746",
                                                     their_public: "c4e2d9fe6a6baf8d1812b799856ef2a306291be7a7024837ad33a8530db79c6b",
                                                     secret: "d9b9dc5033fb416134e5d2107fdbacab5aadb297cb82dbdcd137d663bac59f7f")
            try client.crypto.nacl_box(payload) { [group] (response) in
                XCTAssertEqual(response.result?.encrypted, "li4XED4kx/pjQ2qdP0eR2d/K30uN94voNADxwA==")
                group.leave()
            }
            group.wait()
        }
    }

    func testNacl_box_open() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfNaclBoxOpen = .init(encrypted: "li4XED4kx/pjQ2qdP0eR2d/K30uN94voNADxwA==",
                                                         nonce: "cd7f99924bf422544046e83595dd5803f17536f5c9a11746",
                                                         their_public: "c4e2d9fe6a6baf8d1812b799856ef2a306291be7a7024837ad33a8530db79c6b",
                                                         secret: "d9b9dc5033fb416134e5d2107fdbacab5aadb297cb82dbdcd137d663bac59f7f")
            try client.crypto.nacl_box_open(payload) { [group] (response) in
                XCTAssertEqual(response.result?.decrypted.base64Decoded(), "Test Message")
                group.leave()
            }
            group.wait()
        }
    }

    func testNacl_secret_box() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfNaclSecretBox = .init(decrypted: "Test Message".base64Encoded() ?? "",
                                                           nonce: "2a33564717595ebe53d91a785b9e068aba625c8453a76e45",
                                                           key: "8f68445b4e78c000fe4d6b7fc826879c1e63e3118379219a754ae66327764bd8")
            try client.crypto.nacl_secret_box(payload) { [group] (response) in
                XCTAssertEqual(response.result?.encrypted, "JL7ejKWe2KXmrsns41yfXoQF0t/C1Q8RGyzQ2A==")
                group.leave()
            }
            group.wait()
        }
    }

    func testNacl_secret_box_open() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfNaclSecretBoxOpen = .init(encrypted: "JL7ejKWe2KXmrsns41yfXoQF0t/C1Q8RGyzQ2A==",
                                                               nonce: "2a33564717595ebe53d91a785b9e068aba625c8453a76e45",
                                                               key: "8f68445b4e78c000fe4d6b7fc826879c1e63e3118379219a754ae66327764bd8")
            try client.crypto.nacl_secret_box_open(payload) { [group] (response) in
                XCTAssertEqual(response.result?.decrypted.base64Decoded(), "Test Message")
                group.leave()
            }
            group.wait()
        }
    }

    func testMnemonic_words() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfMnemonicWords = .init(dictionary: .ENGLISH)
            try client.crypto.mnemonic_words(payload) { [group] (response) in
                XCTAssertEqual(response.result?.words.split(separator: " ").count, 2048)
                group.leave()
            }
            group.wait()
        }
    }

    func testMnemonic_from_random() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfMnemonicFromRandom = .init(dictionary: .ENGLISH, word_count: 12)
            try client.crypto.mnemonic_from_random(payload) { [group] (response) in
                XCTAssertEqual(response.result?.phrase.split(separator: " ").count, 12)
                group.leave()
            }
            group.wait()
        }
    }

    func testMnemonic_from_entropy() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfMnemonicFromEntropy = .init(entropy: "00112233445566778899AABBCCDDEEFF",
                                                                 dictionary: .ENGLISH,
                                                                 word_count: 12)
            try client.crypto.mnemonic_from_entropy(payload) { [group] (response) in
                XCTAssertEqual(response.result?.phrase.split(separator: " ").count, 12)
                group.leave()
            }
            group.wait()
        }
    }

    func testMnemonic_verify() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfMnemonicVerify = .init(phrase: "abandon math mimic master filter design carbon crystal rookie group knife young",
                                                            dictionary: .ENGLISH,
                                                            word_count: 12)
            try client.crypto.mnemonic_verify(payload) { [group] (response) in
                XCTAssertEqual(response.result?.valid, true)
                group.leave()
            }
            group.wait()
        }
    }

    func testMnemonic_derive_sign_keys() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfMnemonicDeriveSignKeys = .init(phrase: "abandon math mimic master filter design carbon crystal rookie group knife young",
                                                                    path: nil,
                                                                    dictionary: .ENGLISH,
                                                                    word_count: 12)
            try client.crypto.mnemonic_derive_sign_keys(payload) { [group] (response) in
                XCTAssertEqual(response.result?.public, "61c3c5b97a33c9c0a03af112fbb27e3f44d99e1f804853f9842bb7a6e5de3ff9")
                XCTAssertEqual(response.result?.secret, "832410564fbe7b1301cf48dc83cbb8a3008d3cf29e05b7457086d4de041030ea")
                group.leave()
            }
            group.wait()
        }
    }

    func testHdkey_xprv_from_mnemonic() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfHDKeyXPrvFromMnemonic = .init(phrase: "abandon math mimic master filter design carbon crystal rookie group knife young")
            try client.crypto.hdkey_xprv_from_mnemonic(payload) { [group] (response) in
                XCTAssertEqual(response.result?.xprv, "xprv9s21ZrQH143K3M3Auzg5wmEcKzsVbpE9PdPam5QVjW76rZ59Cw8oTg2kEqFJkNx917D8opVbuuz2jTCUtfrB7oEHU99zmnGDtPggrXNSQHB")
                group.leave()
            }
            group.wait()
        }
    }

    func testHdkey_derive_from_xprv() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfHDKeyDeriveFromXPrv = .init(xprv: "xprv9s21ZrQH143K3M3Auzg5wmEcKzsVbpE9PdPam5QVjW76rZ59Cw8oTg2kEqFJkNx917D8opVbuuz2jTCUtfrB7oEHU99zmnGDtPggrXNSQHB",
                                                                 child_index: 1,
                                                                 hardened: true)
            try client.crypto.hdkey_derive_from_xprv(payload) { [group] (response) in
                XCTAssertEqual(response.result?.xprv, "xprv9uZgCV6cDftQRfDMWEx2r5nkK9fyfKwH6cokt8WQtFatHZ5b4FQbFrCsP9d8mP6FfWiyrKqZTe5sPM52mXuXvmKp1BKLHqaqdSzgc4Ae2ZT")
                group.leave()
            }
            group.wait()
        }
    }

    func testHdkey_derive_from_xprv_path() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfHDKeyDeriveFromXPrvPath = .init(xprv: "xprv9s21ZrQH143K3M3Auzg5wmEcKzsVbpE9PdPam5QVjW76rZ59Cw8oTg2kEqFJkNx917D8opVbuuz2jTCUtfrB7oEHU99zmnGDtPggrXNSQHB",
                                                                     path: "m/44'/396'/0'/0/0")
            try client.crypto.hdkey_derive_from_xprv_path(payload) { [group] (response) in
                XCTAssertEqual(response.result?.xprv, "xprvA3SdNsXH8HLYpps7fxXtHBSeNfGUH59ReuhXbtCx9VJUFAWaqjpuwV91xu5LFQoHgAt3KNQ8wotGq6W4P2eXaS2VVaN1xPwWzAxYnRcDBPr")
                group.leave()
            }
            group.wait()
        }
    }

    func testHdkey_secret_from_xprv() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfHDKeySecretFromXPrv = .init(xprv: "xprv9s21ZrQH143K3M3Auzg5wmEcKzsVbpE9PdPam5QVjW76rZ59Cw8oTg2kEqFJkNx917D8opVbuuz2jTCUtfrB7oEHU99zmnGDtPggrXNSQHB")
            try client.crypto.hdkey_secret_from_xprv(payload) { [group] (response) in
                XCTAssertEqual(response.result?.secret, "1d2037d1adbd40ccf99d44e7073a9d8e32e5675ee053a2fd1c078ef9e05a807d")
                group.leave()
            }
            group.wait()
        }
    }

    func testHdkey_public_from_xprv() throws {
        try testAsyncMethods { (client, group) in
            group.enter()
            let payload: TSDKParamsOfHDKeyPublicFromXPrv = .init(xprv: "xprv9s21ZrQH143K3M3Auzg5wmEcKzsVbpE9PdPam5QVjW76rZ59Cw8oTg2kEqFJkNx917D8opVbuuz2jTCUtfrB7oEHU99zmnGDtPggrXNSQHB")
            try client.crypto.hdkey_public_from_xprv(payload) { [group] (response) in
                XCTAssertEqual(response.result?.public, "01709823c5ada7fdede9b6a0f7f388eda0c29a54ead5ae90ede3b5baaeb242e3")
                group.leave()
            }
            group.wait()
        }
    }

    func testChacha20() throws {
        try testAsyncMethods { (client, group) in
            let key: String = .init(repeating: "01", count: 32)
            let nonce: String = .init(repeating: "ff", count: 12)
            var payload: TSDKParamsOfChaCha20 = .init(data: "Message".base64Encoded() ?? "", key: key, nonce: nonce)

            group.enter()
            try client.crypto.chacha20(payload) { [group] (response) in
                XCTAssertEqual(response.result?.data, "w5QOGsJodQ==")
                group.leave()
            }
            group.wait()

            var encryptedData: String = .init()
            group.enter()
            try client.crypto.chacha20(payload) { [group] (response) in
                XCTAssertEqual(response.result?.data, "w5QOGsJodQ==")
                encryptedData = response.result?.data ?? ""
                group.leave()
            }
            group.wait()

            payload.data = encryptedData
            group.enter()
            try client.crypto.chacha20(payload) { [group] (response) in
                XCTAssertEqual(response.result?.data, "TWVzc2FnZQ==")
                group.leave()
            }
            group.wait()
        }
    }
}

