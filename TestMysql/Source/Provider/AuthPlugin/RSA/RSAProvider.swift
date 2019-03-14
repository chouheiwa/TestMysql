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

    func changeKey(_ publicKeyBase64: String)  {
        let regExp = try! NSRegularExpression(pattern: "(-----BEGIN.*?-----)|(-----END.*?-----)|\\s+", options: [])

        let myPubkeyBase64 = regExp.stringByReplacingMatches(in: publicKeyBase64, options: [], range: NSRange(location: 0, length: publicKeyBase64.count), withTemplate: "")

        publicKey = try! PublicKey(base64Encoded: myPubkeyBase64)

    }
}
