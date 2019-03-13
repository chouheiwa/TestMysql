//
//  AuthPlugin.swift
//  TestMysql
//
//  Created by Di on 2019/3/12.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

protocol AuthPlugin: class {
    class var pluginName: String { get }

    init(socket: Socket)
    /// Does this plugin require the connection itself to be confidential
    func requiresConfidentiality() -> Bool

    func isReusable() -> Bool

    func reset()

    func setAuthenticationParameters(user: String, password: String)

    func nextAuthenticationStep(fromServer: DataReader?) throws -> [Data]
}
