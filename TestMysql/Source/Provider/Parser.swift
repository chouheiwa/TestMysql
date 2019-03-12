//
//  Parser.swift
//  TestMysql
//
//  Created by Di on 2019/3/5.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

class Parser {
    func parser(data: Data) throws -> DataList? {
        let reader = DataReader(data)

        guard reader.canReadCount() >= 4 else {
            return nil
        }

        let length = reader.readInt(.INT3)

        let sequnence: Int = reader.readInt(.INT1)

        guard reader.canReadCount() >= length else {
            return nil
        }

        let list = DataList()

        list.data = try reader.readNext(length)

        list.sequence = sequnence

        if !reader.isEmpty() {
            list.next = try parser(data: reader.surplusData())
        }

        return list
    }
}
