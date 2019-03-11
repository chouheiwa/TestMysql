//
//  DataType.swift
//  TestMysql
//
//  Created by Di on 2019/3/8.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

enum DataType {

    /// IntegerDecoder Protocol::FixedLengthInteger
    ///
    /// - INT1: 1 byte
    /// - INT2: 2 byte
    /// - INT3: 3 byte
    /// - INT4: 4 byte
    /// - INT6: 6 byte
    /// - INT8: 8 byte
    /// - INT_LENENC: Length-Encoded Integer Type
    enum Integer {
        case INT1
        case INT2
        case INT3
        case INT4
        case INT6
        case INT8
        case INT_LENENC
    }

    /// String Decoder
    ///
    /// - STRING_TERM: <#STRING_TERM description#>
    /// - STRING_LENENC: <#STRING_LENENC description#>
    /// - STRING_EOF: <#STRING_EOF description#>
    enum String {
        case STRING_TERM
        case STRING_LENENC
        case STRING_EOF
    }

    enum StringLength {
        case STRING_FIXED
        case STRING_VAR
    }
}
