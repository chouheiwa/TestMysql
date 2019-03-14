//
//  ViewController.swift
//  TestMysql
//
//  Created by Di on 2019/3/5.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import UIKit
import SwiftyRSA


class ViewController: UIViewController {
    var mySocket: MysqlSocket!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//        mySocket = MysqlSocket(host: "127.0.0.1")
//
//        try? mySocket.connect()

        let key: String = "-----BEGIN PUBLIC KEY-----\n" +
            "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCmng1UZgZGCekyV6Cv7948efxk\n" +
            "o3T+c0wvv6oDraTUnrF/SkmSHBTHTitzmG6/4da139GASukwRsmqzqXPoY3CKeDN\n" +
            "4SS+Mf1GYm/zKjXHcU8B4RhmD5dKuiqnbLE21xlNWdLaxTKjJUCtb2+ijMA1jj1G\n" +
            "lO/ggktxl2XCjggDlwIDAQAB\n" +
        "-----END PUBLIC KEY-----"

        RSAProvider().changeKey(key)
//        print(1 << 2)
    }


}

