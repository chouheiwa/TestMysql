//
//  RSAProvider.swift
//  TestMysql
//
//  Created by Di on 2019/3/14.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation
import SwiftyRSA

class RSAProvider {
    private var publicKey: PublicKey?
    private var privateKey: PrivateKey?

    func changeKey(_ publicKeyBase64: String)  {
        let regExp = try! NSRegularExpression(pattern: "(-----BEGIN.*?-----)|(-----END.*?-----)|\\s+", options: [])

        let myPubkeyBase64 = regExp.stringByReplacingMatches(in: publicKeyBase64, options: [], range: NSRange(location: 0, length: publicKeyBase64.count), withTemplate: "")

        publicKey = try! PublicKey(base64Encoded: myPubkeyBase64)
    }

    func changePrivateKey(_ privateKeyBase64: String) {
        let regExp = try! NSRegularExpression(pattern: "(-----BEGIN.*?-----)|(-----END.*?-----)|\\s+", options: [])

        let myPrivateKeyBase64 = regExp.stringByReplacingMatches(in: privateKeyBase64, options: [], range: NSRange(location: 0, length: privateKeyBase64.count), withTemplate: "")

        privateKey = try! PrivateKey(base64Encoded: myPrivateKeyBase64)
    }

    func encrypy(_ text: String, encoding: String.Encoding) -> Data? {
        guard let publicKey = publicKey else { return nil }

        let message = try! ClearMessage(string: text, using: encoding)

        let encrypted = try! message.encrypted(with: publicKey, padding: .PKCS1)

        return encrypted.data
    }

    func decrypt(_ data: Data) {
        guard let privateKey = privateKey else { return }

        let encrypted = EncryptedMessage(data: data)

        let clear = try! encrypted.decrypted(with: privateKey, padding: .PKCS1)

        print(try! clear.string(encoding: .utf8))
    }
}
