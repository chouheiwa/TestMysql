//
//  PacketProtocol.swift
//  TestMysql
//
//  Created by Di on 2019/3/12.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

protocol Packet {
    func prepareToSendData() -> Data
}

extension Data: Packet {
    func prepareToSendData() -> Data {
        return self
    }
}
