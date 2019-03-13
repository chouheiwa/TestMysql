//
//  CachingSha2PasswordPlugin.swift
//  TestMysql
//
//  Created by Di on 2019/3/13.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

class CachingSha2PasswordPlugin: Sha256PasswordPlugin {
    override class var pluginName: String {
        return "caching_sha2_password"
    }

    enum AuthStage {
        case FAST_AUTH_SEND_SCRAMBLE, FAST_AUTH_READ_RESULT, FAST_AUTH_COMPLETE, FULL_AUTH
    }

    private var stage: AuthStage = .FAST_AUTH_SEND_SCRAMBLE


}
