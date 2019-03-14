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
            "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC1iy6zKJfJAaMiQyn61e7aEI/x\n" +
            "onN72uUuYlM/zoRlQJv72glFA2rO2M0D/WQEJHGAIBCuX6IzvNdQUqhzhQT9wueV\n" +
            "M7xzR9TvVqoWDAxzs5ZPjKWeJeaIgSM0XaVhPth9oBB6FYX/yXXCHPY3sNeUhVK1\n" +
            "fTHAMdlZOaG1kazZJQIDAQAB\n" +
        "-----END PUBLIC KEY-----"

        let privateKey: String = "-----BEGIN RSA PRIVATE KEY-----\n" +
            "MIICWwIBAAKBgQC1iy6zKJfJAaMiQyn61e7aEI/xonN72uUuYlM/zoRlQJv72glF\n" +
            "A2rO2M0D/WQEJHGAIBCuX6IzvNdQUqhzhQT9wueVM7xzR9TvVqoWDAxzs5ZPjKWe\n" +
            "JeaIgSM0XaVhPth9oBB6FYX/yXXCHPY3sNeUhVK1fTHAMdlZOaG1kazZJQIDAQAB\n" +
            "AoGALwZuglnxd0/FQgrDxQXFaRcBMkYyQ9LfqrQtfEmyYcfqn8JKxGWuNQZTlMT+\n" +
            "M1R9UgL8Ty7WhTBVVakTmVjLgb7+pBr4f5rCSdgXIsw4z9pAqXQh1bBbAJ36e1Sc\n" +
            "zN/usPnNVCBftv9FWUM2docywbeE1D4oGTFiLvc8RwlXdgECQQC4b0vxvJHHNSP4\n" +
            "GsBgDDFOFbj1pWAtdiQRWMsOPSbMWBfxxPV/6NjQ3iPx7a3PSmhdEi9swx9Nyr4/\n" +
            "hx3yhs6JAkEA+/y0AC5J7aev8rEw8ke86+N1OH1RuPizrtbRUPk3XCETwhsNL0Ch\n" +
            "UPTdfwDpdsPPG9kT5JLzgezSFqWYvkvuvQJAYCoPxARZUjAACC4SnkHdN2SWIubO\n" +
            "hgWyeqT8gvkZkLRiD7ptcvr6ibU5srwFwy59ygFgXupCGTKcDc2qrLjjWQJAI/ov\n" +
            "hPsW6QyRDXiJAX6GlbNTEC6sVVmE5gibuBDs+4VpecQ8/KsgnRto6HIr4x4P2u0C\n" +
            "bxcgF0PFtyALj9ftjQJAZoqBtPZDVLsc298YLKwChiMIeXTYXBNZGo3D13VRId02\n" +
            "HEHUcRSZRqAetjGcJB2gnpjfwoPU1LS7/XtBngq0Bw==\n" +
        "-----END RSA PRIVATE KEY-----"

        var array:[Int8] = [73, 47, -16, 26, -13, -27, 99, 40, 49, 33, 33, 36, 8, -12, -43, -32, -100, 125, -23, 108, 114, 100, 68, -75, 77, -24, -27, -43, -113, -101, -30, -105, -115, 27, 14, 40, 31, -111, -115, -105, -73, 95, 40, 111, 94, -32, -61, 94, -121, -40, -55, -120, 79, -121, -122, -57, -123, -37, -127, 66, -28, -63, -62, -42, 26, -22, -105, 80, 41, -127, 32, 57, 66, 112, 53, 69, 45, -68, 116, 14, 13, 74, -9, -15, 29, 102, -99, 12, -18, -99, -61, -105, -122, -68, -38, 59, -28, 80, 82, -103, -55, 59, -1, -74, 45, -111, 15, -13, 111, -93, -85, -25, -75, 7, -74, 14, 102, -46, -26, -53, -124, -115, 24, -33, 30, -80, -70, 36]


        let pointer: UnsafePointer<UInt8> = withUnsafeBytes(of: array) { (pointer) -> UnsafePointer<UInt8> in
            return pointer.baseAddress!.assumingMemoryBound(to: UInt8.self)
        }

        let data = Data(bytes: pointer, count: array.count)

        let provider = RSAProvider()

        provider.changeKey(key)

        let encryData = provider.encrypy("111", encoding: .utf8)!

        provider.changePrivateKey(privateKey)

        provider.decrypt(data)
//        print(1 << 2)
    }


}

