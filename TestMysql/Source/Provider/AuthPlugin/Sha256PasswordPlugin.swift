//
//  Sha256PasswordPlugin.swift
//  TestMysql
//
//  Created by Di on 2019/3/13.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

class Sha256PasswordPlugin: AuthPlugin {
    class var pluginName: String {
        return "sha256_password"
    }

    var password: String?
    var user: String?

    var publicKey: String?

    var socket: Socket

    required init(socket: Socket) {
        self.socket = socket
    }

    func requiresConfidentiality() -> Bool {
        return false
    }

    func isReusable() -> Bool {
        return true
    }

    func reset() {
        self.user = nil
        self.password = nil
    }

    func setAuthenticationParameters(user: String, password: String) {
        self.user = user
        self.password = password
    }

    func nextAuthenticationStep(fromServer: DataReader?) throws -> [Data] {
        guard let password = password, let fromServer = fromServer, (password.count > 0) else {
            var data = Data()

            data.append(0)

            return [data]
        }

        if socket.isSSLEstablish {
            /// allow plain text over SSL



        }

        return []
    }
}
