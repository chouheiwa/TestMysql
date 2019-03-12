//
//  ServerCapabilities.swift
//  TestMysql
//
//  Created by Di on 2019/3/8.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

protocol ServerCapabilities {
    var capabilityFlags: CapabilityFlags { get set }
    var serverVersion: ServerVersion {get set}
}
