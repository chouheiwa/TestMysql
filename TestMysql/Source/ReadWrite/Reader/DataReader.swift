//
//  DataReader.swift
//  TestMysql
//
//  Created by Di on 2019/3/6.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

final class DataReader {
    enum PacketType: UInt8 {
        case Error = 0xFF
        case EOF_AuthSwitch = 0xFE
        case LocalInFile = 0xFB
        case OK = 0
    }

    private var position: Int = 0
    private let data: Data

    init(_ data: Data) {
        self.data = data
    }

    @discardableResult func readNext(_ count: Int) throws -> Data {
        guard data.count >= count + position && count > 0 else {
            throw SQLError.dataLengthError
        }

        let index = position
        position += count

        return data.subdata(in: index..<position)
    }

    func skip(_ count: Int) {
        guard data.count >= count + position && count > 0 else {
            position = data.count
            return
        }

        position += count
    }

    func changePosition(_ position: Int) {
        guard position <= data.count else {
            self.position = data.count
            return
        }

        self.position = position
    }

    func readInt(_ type: DataType.Integer) -> Int {
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
            let sw = data[position] & 0xff
            position += 1
            switch sw {
            case 251:
                return -1
            case 252:
                return readInt(.INT2)
            case 253:
                return readInt(.INT3)
            case 254:
                return readInt(.INT8)
            default:
                return Int(sw)
            }
        }

        var result = 0
        for index in 0..<length {
            result += Int(data[position + index] & 0xff) << (index * 8)
        }

        position += length

        return result
    }

    func readString(_ type: DataType.String, encoding: String.Encoding) throws -> String? {
        guard let data = try readStringData(type) else { return nil }

        return String(data: data, encoding: encoding) ?? ""
    }

    func readString(_ lengthType: DataType.StringLength,
                    encoding: String.Encoding, length: Int) throws -> String {
        return String(data: try readStringData(lengthType, length: length), encoding: encoding) ?? ""
    }

    func readStringData(_ type: DataType.String) throws -> Data? {
        switch type {
        case .STRING_TERM:
            var length = 0
            while position + length < data.count &&
                data[position + length] != 0{
                    length += 1
            }
            let dataResult = try readStringData(.STRING_FIXED, length: length)

            position += 1

            return dataResult
        case .STRING_LENENC:
            let length = readInt(.INT_LENENC)
            return length == -1 ? nil :
                (length == 0 ? Data() : try readStringData(.STRING_FIXED, length: length))
        case .STRING_EOF:
            return try readStringData(.STRING_FIXED, length: data.count - position)
        }
    }

    func readStringData(_ lengthType: DataType.StringLength,
                        length: Int) throws -> Data {
        switch lengthType {
        case .STRING_FIXED,.STRING_VAR:
            return try readNext(length)
        }
    }

    func surplusData() -> Data {
        return data.suffix(from: position)
    }

    func isEmpty() -> Bool {
        return position == data.count
    }

    func canReadCount() -> Int {
        return data.count - position
    }
}

extension DataReader {
    var isOKPacket: Bool {
        guard data.count > 0 else {
            return false
        }
        return PacketType(rawValue: data[0]) == PacketType.OK
    }
}
