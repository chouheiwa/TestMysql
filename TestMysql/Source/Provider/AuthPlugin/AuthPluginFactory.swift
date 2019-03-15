//
//  AuthPluginFactory.swift
//  TestMysql
//
//  Created by Di on 2019/3/13.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation


class AuthPluginFactory {
    private var pluginItems: [String: AuthPlugin.Type] = [:]

    private var pluginInstanceItems: [String: AuthPlugin] = [:]

    static var shared: AuthPluginFactory = AuthPluginFactory()

    private init() {}

    private func loadDefault() {
        pluginItems[MysqlNativePasswordPlugin.pluginName] = MysqlNativePasswordPlugin.self
        pluginItems[Sha256PasswordPlugin.pluginName] = Sha256PasswordPlugin.self
        pluginItems[CachingSha2PasswordPlugin.pluginName] = CachingSha2PasswordPlugin.self
    }

    func add(_ pluginClass: AuthPlugin.Type)  {
        pluginItems[pluginClass.pluginName] = pluginClass
    }

    func find(_ pluginName: String) -> AuthPlugin? {
        if pluginItems.count == 0 {
            loadDefault()
        }

        guard let pluginClass = pluginItems[pluginName] else {
            return nil
        }

        let pluginInstance = pluginInstanceItems[pluginName] ?? pluginClass.init()

        pluginInstanceItems[pluginName] = pluginInstance

        return pluginInstance
    }

    func destory(_ pluginInstance: AuthPlugin) {
        guard !pluginInstance.isReusable() else {
            return
        }

        pluginInstanceItems[pluginInstance.pluginName] = nil
    }
}
