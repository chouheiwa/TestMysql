//
//  NativeServerSession+State.swift
//  TestMysql
//
//  Created by Di on 2019/3/11.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

extension NativeServerSession {
    static let SERVER_STATUS_IN_TRANS = 1;
    static let SERVER_STATUS_AUTOCOMMIT = 2; // Server in auto_commit mode
    static let SERVER_MORE_RESULTS_EXISTS = 8; // Multi query - next query exists
    static let SERVER_QUERY_NO_GOOD_INDEX_USED = 16;
    static let SERVER_QUERY_NO_INDEX_USED = 32;
    static let SERVER_STATUS_CURSOR_EXISTS = 64;
    static let SERVER_STATUS_LAST_ROW_SENT = 128; // The server status for 'last-row-sent'
    static let SERVER_QUERY_WAS_SLOW = 2048;

    static let CLIENT_LONG_PASSWORD = 0x00000001; /* new more secure passwords */
    static let CLIENT_FOUND_ROWS = 0x00000002;
    static let CLIENT_LONG_FLAG = 0x00000004; /* Get all column flags */
    static let CLIENT_CONNECT_WITH_DB = 0x00000008;
    static let CLIENT_COMPRESS = 0x00000020; /* Can use compression protcol */
    static let CLIENT_LOCAL_FILES = 0x00000080; /* Can use LOAD DATA LOCAL */
    static let CLIENT_PROTOCOL_41 = 0x00000200; // for > 4.1.1
    static let CLIENT_INTERACTIVE = 0x00000400;
    static let CLIENT_SSL = 0x00000800;
    static let CLIENT_TRANSACTIONS = 0x00002000; // Client knows about transactions
    static let CLIENT_RESERVED = 0x00004000; // for 4.1.0 only
    static let CLIENT_SECURE_CONNECTION = 0x00008000;
    static let CLIENT_MULTI_STATEMENTS = 0x00010000; // Enable/disable multiquery support
    static let CLIENT_MULTI_RESULTS = 0x00020000; // Enable/disable multi-results
    static let CLIENT_PS_MULTI_RESULTS = 0x00040000; // Enable/disable multi-results for server prepared statements
    static let CLIENT_PLUGIN_AUTH = 0x00080000;
    static let CLIENT_CONNECT_ATTRS = 0x00100000;
    static let CLIENT_PLUGIN_AUTH_LENENC_CLIENT_DATA = 0x00200000;
    static let CLIENT_CAN_HANDLE_EXPIRED_PASSWORD = 0x00400000;
    static let CLIENT_SESSION_TRACK = 0x00800000;
    static let CLIENT_DEPRECATE_EOF = 0x01000000;
}
