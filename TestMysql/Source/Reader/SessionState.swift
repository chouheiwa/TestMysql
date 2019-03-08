//
//  SessionState.swift
//  TestMysql
//
//  Created by Di on 2019/3/8.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

struct SessionState {
    static let SERVER_STATUS_IN_TRANS: Int = 1;
    static let SERVER_STATUS_AUTOCOMMIT: Int = 2; // Server in auto_commit mode
    static let SERVER_MORE_RESULTS_EXISTS: Int = 8; // Multi query - next query exists
    static let SERVER_QUERY_NO_GOOD_INDEX_USED: Int = 16;
    static let SERVER_QUERY_NO_INDEX_USED: Int = 32;
    static let SERVER_STATUS_CURSOR_EXISTS: Int = 64;
    static let SERVER_STATUS_LAST_ROW_SENT: Int = 128; // The server status for 'last-row-sent'
    static let SERVER_QUERY_WAS_SLOW: Int = 2048;
    
    static let CLIENT_LONG_PASSWORD: Int = 0x00000001; /* new more secure passwords */
    static let CLIENT_FOUND_ROWS: Int = 0x00000002;
    static let CLIENT_LONG_FLAG: Int = 0x00000004; /* Get all column flags */
    static let CLIENT_CONNECT_WITH_DB: Int = 0x00000008;
    static let CLIENT_COMPRESS: Int = 0x00000020; /* Can use compression protcol */
    static let CLIENT_LOCAL_FILES: Int = 0x00000080; /* Can use LOAD DATA LOCAL */
    static let CLIENT_PROTOCOL_41: Int = 0x00000200; // for > 4.1.1
    static let CLIENT_INTERACTIVE: Int = 0x00000400;
    static let CLIENT_SSL: Int = 0x00000800;
    static let CLIENT_TRANSACTIONS: Int = 0x00002000; // Client knows about transactions
    static let CLIENT_RESERVED: Int = 0x00004000; // for 4.1.0 only
    static let CLIENT_SECURE_CONNECTION: Int = 0x00008000;
    static let CLIENT_MULTI_STATEMENTS: Int = 0x00010000; // Enable/disable multiquery support
    static let CLIENT_MULTI_RESULTS: Int = 0x00020000; // Enable/disable multi-results
    static let CLIENT_PS_MULTI_RESULTS: Int = 0x00040000; // Enable/disable multi-results for server prepared statements
    static let CLIENT_PLUGIN_AUTH: Int = 0x00080000;
    static let CLIENT_CONNECT_ATTRS: Int = 0x00100000;
    static let CLIENT_PLUGIN_AUTH_LENENC_CLIENT_DATA: Int = 0x00200000;
    static let CLIENT_CAN_HANDLE_EXPIRED_PASSWORD: Int = 0x00400000;
    static let CLIENT_SESSION_TRACK: Int = 0x00800000;
    static let CLIENT_DEPRECATE_EOF: Int = 0x01000000;
}
