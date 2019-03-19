//
//  ProviderFactory.swift
//  TestMysql
//
//  Created by Di on 2019/3/16.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

final class ProviderFactory {

    static func makeAuthProvider(_ socket: Socket) -> AuthProvider {
        return NativeAuthProvider(socket)
    }
}
