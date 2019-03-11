//
//  CapabilityFlags.swift
//  TestMysql
//
//  Created by Di on 2019/3/11.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

struct CapabilityFlags: RawValueProtocol {
    var rawValue: Int

    /// Use the improved version of Old Password Authentication.
    /// See more in https://dev.mysql.com/doc/internals/en/old-password-authentication.html#packet-Authentication::Old
    static let CLIENT_LONG_PASSWORD     = CapabilityFlags(rawValue: 1 << 0)
    /// Send found rows instead of affected rows in EOF_Packet.
    /// https://dev.mysql.com/doc/internals/en/packet-EOF_Packet.html
    static let CLIENT_FOUND_ROWS        = CapabilityFlags(rawValue: 1 << 1)
    /// Longer flags in Protocol::ColumnDefinition320.
    /// Expects longer flags.
    /// https://dev.mysql.com/doc/internals/en/com-query-response.html#packet-Protocol::ColumnDefinition320
    static let CLIENT_LONG_FLAG         = CapabilityFlags(rawValue: 1 << 2)
    /// Database (schema) name can be specified on connect in Handshake Response Packet.
    /// https://dev.mysql.com/doc/internals/en/connection-phase-packets.html#packet-Protocol::HandshakeResponse
    static let CLIENT_CONNECT_WITH_DB   = CapabilityFlags(rawValue: 1 << 3)
    /// Do not permit database.table.column.
    static let CLIENT_NO_SCHEMA         = CapabilityFlags(rawValue: 1 << 4)
    /// Compression protocol supported.
    /// https://dev.mysql.com/doc/internals/en/compression.html
    static let CLIENT_COMPRESS          = CapabilityFlags(rawValue: 1 << 4)
    /// Special handling of ODBC behavior.
    /// No special behavior since 3.22.
    static let CLIENT_ODBC              = CapabilityFlags(rawValue: 1 << 5)
    /// Can use LOAD DATA LOCAL.
    /// Will handle LOCAL INFILE request.
    /// https://dev.mysql.com/doc/internals/en/com-query-response.html#local-infile-request
    static let CLIENT_LOCAL_FILES       = CapabilityFlags(rawValue: 1 << 6)
    /// Let the parser ignore spaces before '('.
    static let CLIENT_IGNORE_SPACE      = CapabilityFlags(rawValue: 1 << 7)
    /// Uses the 4.1 protocol.
    static let CLIENT_PROTOCOL_41       = CapabilityFlags(rawValue: 1 << 8)
    /// wait_timeout versus wait_interactive_timeout.
    /// Client is interactive.
    /// https://dev.mysql.com/doc/refman/8.0/en/mysql-real-connect.html
    static let CLIENT_INTERACTIVE       = CapabilityFlags(rawValue: 1 << 9)
    /// Switch to SSL after sending the capability-flags.
    static let CLIENT_SSL               = CapabilityFlags(rawValue: 1 << 10)
    /// Do not issue SIGPIPE if network failures occur (libmysqlclient only).
    /// https://dev.mysql.com/doc/refman/8.0/en/mysql-real-connect.html
    static let CLIENT_IGNORE_SIGPIPE    = CapabilityFlags(rawValue: 1 << 11)
    /// Expects status flags in EOF_Packet.
    /// This flag is optional in 3.23, but always set by the server since 4.0.
    static let CLIENT_TRANSACTIONS      = CapabilityFlags(rawValue: 1 << 12)
    /// Unused
    static let CLIENT_RESERVED          = CapabilityFlags(rawValue: 1 << 13)
    /// Supports Authentication::Native41.
    /// https://dev.mysql.com/doc/internals/en/secure-password-authentication.html#packet-Authentication::Native41
    static let CLIENT_SECURE_CONNECTION = CapabilityFlags(rawValue: 1 << 14)
    /// May send multiple statements per COM_QUERY and COM_STMT_PREPARE.
    /// COM_QUERY: https://dev.mysql.com/doc/internals/en/com-query.html#packet-COM_QUERY
    /// COM_STMT_PREPARE: https://dev.mysql.com/doc/internals/en/com-stmt-prepare.html#packet-COM_STMT_PREPARE
    static let CLIENT_MULTI_RESULTS     = CapabilityFlags(rawValue: 1 << 16)
    /// Can handle multiple resultsets for COM_QUERY.
    /// https://dev.mysql.com/doc/internals/en/com-query.html#packet-COM_QUERY
    static let CLIENT_PS_MULTI_RESULTS  = CapabilityFlags(rawValue: 1 << 17)
    /// Can handle multiple resultsets for COM_STMT_EXECUTE.
    /// https://dev.mysql.com/doc/internals/en/com-stmt-prepare.html#packet-COM_STMT_PREPARE
    static let CLIENT_MULTI_STATEMENTS  = CapabilityFlags(rawValue: 1 << 18)
    /// Supports authentication plugins.
    /// Requires:CLIENT_PROTOCOL_41
    static let CLIENT_PLUGIN_AUTH       = CapabilityFlags(rawValue: 1 << 19)
    /// Sends connection attributes in Protocol::HandshakeResponse41.
    /// https://dev.mysql.com/doc/internals/en/connection-phase-packets.html#packet-Protocol::HandshakeResponse41
    static let CLIENT_CONNECT_ATTRS     = CapabilityFlags(rawValue: 1 << 20)
    /// Length of auth response data in Protocol::HandshakeResponse41 is a length-encoded integer.
    /// The flag was introduced in 5.6.6, but had the wrong value.
    static let CLIENT_PLUGIN_AUTH_LENENC_CLIENT_DATA = CapabilityFlags(rawValue: 1 << 21)
    /// Can handle expired passwords.
    /// https://dev.mysql.com/doc/internals/en/cs-sect-expired-password.html
    static let CLIENT_CAN_HANDLE_EXPIRED_PASSWORDS     = CapabilityFlags(rawValue: 1 << 22)
    /// Expects the server to send sesson-state changes after a OK packet.
    /// https://dev.mysql.com/doc/internals/en/packet-OK_Packet.html
    static let CLIENT_SESSION_TRACK     = CapabilityFlags(rawValue: 1 << 23)
    /// Expects an OK (instead of EOF) after the resultset rows of a Text Resultset.
    /// Background:
    /// To support CLIENT_SESSION_TRACK, additional information must be sent after all successful commands. Although the OK packet is extensible, the EOF packet is not due to the overlap of its bytes with the content of the Text Resultset Row.
    /// Therefore, the EOF packet in the Text Resultset is replaced with an OK packet. EOF packets are deprecated as of MySQL 5.7.5.
    static let CLIENT_DEPRECATE_EOF = CapabilityFlags(rawValue: 1 << 24)
}
