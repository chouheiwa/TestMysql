//
//  MysqlNativePasswordPlugin.swift
//  TestMysql
//
//  Created by Di on 2019/3/14.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation
import CryptoSwift

class MysqlNativePasswordPlugin: AuthPlugin {
    static var pluginName: String = "mysql_native_password"

    var password: String?

    required init(socket: Socket) {}

    func requiresConfidentiality() -> Bool {
        return false
    }

    func isReusable() -> Bool {
        return true
    }

    func reset() {
        password = nil
    }

    func setAuthenticationParameters(user: String, password: String) {
        self.password = password
    }

    func nextAuthenticationStep(fromServer: DataReader?) throws -> [Data] {
        guard let fromServer = fromServer, let password = password, (password.count > 0) else {
            var data = Data()
            data.append(0)
            return [data]
        }

        let seedData = try! fromServer.readStringData(.STRING_TERM) ?? Data()

        let passworData = password.data(using: .utf8)!

        let passwordHashStage1 = passworData.sha256()

        let passwordHashStage2 = passwordHashStage1.sha256()

        var beXorData = (seedData + passwordHashStage2).sha256()

        for (index, item) in passwordHashStage1.enumerated() {
            beXorData[index] = beXorData[index] ^ item
        }

        return [beXorData]
    }


}
