//
//  Socket.swift
//  TestMysql
//
//  Created by Di on 2019/3/13.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

protocol Socket {
    var authProvider: AuthProvider { get set }

    var isSSLEstablish: Bool { get }

    func startSSL()
}
