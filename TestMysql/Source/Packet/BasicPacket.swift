//
//  BasicPacket.swift
//  TestMysql
//
//  Created by Di on 2019/3/12.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

class BasicPacket: Packet {
    var packet: Packet?

    let writer: DataWriter = DataWriter()

    var sequence: Int = 0

    func prepareToSendData() -> Data {
        let data = packet?.prepareToSendData() ?? Data()

        writer.writeInteger(type: .INT3, target: data.count)

        writer.writeInteger(type: .INT1, target: sequence)

        writer.writeData(data)

        return writer.toData()
    }
}
