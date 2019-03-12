//
//  StatusFlag.swift
//  TestMysql
//
//  Created by Di on 2019/3/12.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation
/// Doc Page:
/// https://dev.mysql.com/doc/internals/en/status-flags.html#packet-Protocol::StatusFlags
struct StatusFlag: RawValueProtocol, OptionSet {
    var rawValue: Int
    /// a transaction is active
    static let SERVER_STATUS_IN_TRANS             = StatusFlag(rawValue: 1 << 1)
    /// auto-commit is enabled
    static let SERVER_STATUS_AUTOCOMMIT           = StatusFlag(rawValue: 1 << 2)
    static let SERVER_MORE_RESULTS_EXISTS         = StatusFlag(rawValue: 1 << 3)
    static let SERVER_STATUS_NO_GOOD_INDEX_USED   = StatusFlag(rawValue: 1 << 4)
    static let SERVER_STATUS_NO_INDEX_USED        = StatusFlag(rawValue: 1 << 5)
    /// Used by Binary Protocol Resultset to signal that COM_STMT_FETCH must be used to fetch the row-data.
    /// Binary Protocol Resultset: https://dev.mysql.com/doc/internals/en/binary-protocol-resultset.html
    /// COM_STMT_FETCH: https://dev.mysql.com/doc/internals/en/com-stmt-fetch.html#packet-COM_STMT_FETCH
    static let SERVER_STATUS_CURSOR_EXISTS        = StatusFlag(rawValue: 1 << 6)
    static let SERVER_STATUS_LAST_ROW_SENT        = StatusFlag(rawValue: 1 << 7)
    static let SERVER_STATUS_DB_DROPPED           = StatusFlag(rawValue: 1 << 8)
    static let SERVER_STATUS_NO_BACKSLASH_ESCAPES = StatusFlag(rawValue: 1 << 9)
    static let SERVER_STATUS_METADATA_CHANGED     = StatusFlag(rawValue: 1 << 10)
    static let SERVER_QUERY_WAS_SLOW              = StatusFlag(rawValue: 1 << 11)
    static let SERVER_PS_OUT_PARAMS               = StatusFlag(rawValue: 1 << 12)
    /// in a read-only transaction
    static let SERVER_STATUS_IN_TRANS_READONLY    = StatusFlag(rawValue: 1 << 13)
    /// connection state information has changed
    static let SERVER_SESSION_STATE_CHANGED       = StatusFlag(rawValue: 1 << 14)
}
