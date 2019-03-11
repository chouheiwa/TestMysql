//
//  DataWriter.swift
//  TestMysql
//
//  Created by Di on 2019/3/11.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

class DataWriter {
    var data: Data = Data()

    func writeInteger(type: DataType.Integer, target: Int) {
        var length = 0

        switch type {
        case .INT1:
            length = 1
        case .INT2:
            length = 2
        case .INT3:
            length = 3
        case .INT4:
            length = 4
        case .INT6:
            length = 6
        case .INT8:
            length = 8
        case .INT_LENENC:
            if target < 251 {
                writeInteger(type: .INT1, target: target)
                return
            } else if target < 65536 {
                writeInteger(type: .INT1, target: 252)
                writeInteger(type: .INT2, target: target)
                return
            } else if target < 16777216 {
                writeInteger(type: .INT1, target: 253)
                writeInteger(type: .INT3, target: target)
                return
            } else {
                writeInteger(type: .INT1, target: 254)
                writeInteger(type: .INT8, target: target)
                return
            }
        }

        let result = UInt(target)

        for index in 0..<length {

            let item = (result >> (8 * index)) & UInt(0xff)

            data.append(UInt8(item))
        }
    }

    func writeString(type: DataType.String, encoding: String.Encoding, target: String) {
        let stringData = target.data(using: encoding) ?? Data()

        switch type {
        case .STRING_EOF:
            data.append(stringData)
        case .STRING_LENENC:
            writeInteger(type: .INT_LENENC, target: stringData.count)
            data.append(stringData)
        case .STRING_TERM:
            data.append(stringData)
            data.append(0)
        }
    }
}
