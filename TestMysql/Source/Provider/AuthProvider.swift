//
//  AuthParser.swift
//  TestMysql
//
//  Created by Di on 2019/3/5.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

class AuthProvider {
    var seed: String?

    var useConnectWithDb = false

    func connect(_ sessionState: ServerSession, user: String, password: String, dataBase: String) {
        guard let capabilities = sessionState.capabilities as? ServerHandShake else { return }

        var clientParam: CapabilityFlags = []

        seed = capabilities.seed

        let flags = capabilities.capabilityFlags

        if flags.contains(.CLIENT_SECURE_CONNECTION) {
            clientParam.insert(.CLIENT_SECURE_CONNECTION)
        }

        /// CLIENT_COMPRESS need to be implement

        /// Connect With DB need to be implement

        if useConnectWithDb {
            clientParam.insert(.CLIENT_CONNECT_WITH_DB)
        }

        /// Check SSL

        if flags.contains(.CLIENT_LONG_FLAG) {
            clientParam.insert(.CLIENT_LONG_FLAG)
            sessionState.hasLongColumnInfo = true
        }

        clientParam.insert(.CLIENT_FOUND_ROWS)

        /// CLIENT_LOCAL_FILES need to be implement

        if flags.contains(.CLIENT_DEPRECATE_EOF) {
            clientParam.insert(.CLIENT_DEPRECATE_EOF)
        }

        if flags.contains(.CLIENT_PLUGIN_AUTH) {
            sessionState.clientParam = clientParam
        }
    }

    
}
