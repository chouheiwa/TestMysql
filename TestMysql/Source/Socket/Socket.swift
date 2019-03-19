//
//  Socket.swift
//  TestMysql
//
//  Created by Di on 2019/3/13.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

protocol Socket: class {
    var currentUser: String { get set }

    var currentPassword: String { get set }

    var currentDataBase : String { get set }

    var isSSLEstablish: Bool { get }

    func startSSL()

    func initialHandShakeReceive(_ block: @escaping((ServerHandShake)->Void))

    func needAuthority()
}
