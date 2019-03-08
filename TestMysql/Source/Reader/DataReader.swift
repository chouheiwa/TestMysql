//
//  DataReader.swift
//  TestMysql
//
//  Created by Di on 2019/3/6.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

class DataReader {
    var currentIndex: Int = 0
    private let data: Data

    init(_ data: Data) {
        self.data = data
    }

    @discardableResult func readNext(_ count: Int) throws -> Data {
        guard data.count >= count + currentIndex && count > 0 else {
            throw SQLError.dataLengthError
        }

        let index = currentIndex
        currentIndex += count

        return data.subdata(in: index..<currentIndex)
    }

    func skip(_ count: Int) -> Void {
        currentIndex += count
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
            let sw = data[currentIndex] & 0xff
            currentIndex += 1
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
            result += Int(data[currentIndex + index] & 0xff) << (index * 8)
        }

        currentIndex += length

        return result
    }

    func readString(_ type: DataType.String, encoding: String.Encoding) throws -> String? {
        switch type {
        case .STRING_TERM:
            var length = 0
            while currentIndex + length < data.count &&
                data[currentIndex + length] != 0{
                    length += 1
            }
            let string = try readString(.STRING_FIXED, encoding: encoding, length: length)

            currentIndex += 1

            return string
        case .STRING_LENENC:
            let length = readInt(.INT_LENENC)
            return length == -1 ? nil :
                (length == 0 ? "" : try readString(.STRING_FIXED, encoding: encoding, length: length))
        case .STRING_EOF:
            return try readString(.STRING_FIXED, encoding: encoding, length: data.count - currentIndex)
        }
    }

    func readString(_ lengthType: DataType.StringLength,
                            encoding: String.Encoding, length: Int) throws -> String {
        switch lengthType {
        case .STRING_FIXED,.STRING_VAR:
            return String(data: try readNext(length), encoding: encoding) ?? ""
        }
    }

    func surplusData() -> Data {
        return data.suffix(from: currentIndex)
    }

    func isEmpty() -> Bool {
        return currentIndex == data.count
    }

    func canReadCount() -> Int {
        return data.count - currentIndex
    }
}
