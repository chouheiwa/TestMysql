//
//  AuthPlugin.swift
//  TestMysql
//
//  Created by Di on 2019/3/12.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

protocol AuthPlugin: class {
    static var pluginName: String { get }

    var socket: Socket? { set get }

    init()
    /// Does this plugin require the connection itself to be confidential
    func requiresConfidentiality() -> Bool

    func isReusable() -> Bool

    func reset()

    func setAuthenticationParameters(user: String, password: String)

    func nextAuthenticationStep(fromServer: DataReader?) throws -> [Data]
}

extension AuthPlugin {
    var pluginName: String {
        return Self.pluginName
    }
}
