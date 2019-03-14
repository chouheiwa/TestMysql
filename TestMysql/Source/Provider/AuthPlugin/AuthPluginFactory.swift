//
//  AuthPluginFactory.swift
//  TestMysql
//
//  Created by Di on 2019/3/13.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation


class AuthPluginFactory {
    static var plugin: [String: AuthPlugin.Type] = [:]

    func add()  {
        AuthPluginFactory.plugin[MysqlNativePasswordPlugin.pluginName] = MysqlNativePasswordPlugin.self
    }
}
