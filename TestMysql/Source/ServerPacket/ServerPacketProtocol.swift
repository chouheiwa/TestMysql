//
//  ModelProtocol.swift
//  TestMysql
//
//  Created by Di on 2019/3/5.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

protocol ServerPacketProtocol {
    init(_ data: Data) throws
}
