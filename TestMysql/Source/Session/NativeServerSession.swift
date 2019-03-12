//
//  NativeServerSession.swift
//  TestMysql
//
//  Created by Di on 2019/3/11.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

final class NativeServerSession: ServerSession {
    private var realCapabilities: ServerHandShake?

    var capabilities: ServerCapabilities? {
        get {
            return realCapabilities
        }
        set {
            guard let capabilities = newValue as? ServerHandShake else {
                realCapabilities = nil
                return
            }

            realCapabilities = capabilities
        }
    }

    var statusFlag: StatusFlag = []

    var transcationState: TransactionState = .notStarted

    var clientParam: CapabilityFlags = []

    var hasLongColumnInfo: Bool = false

    var serverVariables: [String : String] = [:]

    var serverVersion: ServerVersion = ServerVersion()

    var serverDefaultCharset: CharacterSet = .utf8

    var errorMessageEncoding: CharacterSet = .utf8
}
