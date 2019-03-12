//
//  ViewController.swift
//  TestMysql
//
//  Created by Di on 2019/3/5.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var mySocket: MysqlSocket!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        mySocket = MysqlSocket(host: "127.0.0.1")

        try? mySocket.connect()

//        print(1 << 2)
    }


}

