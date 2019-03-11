//
//  AuthModel.swift
//  TestMysql
//
//  Created by Di on 2019/3/5.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation
/// |                    1                   2                   3    |
/// |0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2|
/// |-----------------------------------------------------------------|
/// | 1 Byte version |    n Bytes (Null-Terminated String)            |
/// |-----------------------------------------------------------------|
/// |                          4 Bytes ServerPID                      |
/// |-----------------------------------------------------------------|
/// |                          8 Bytes challengeData                  |
/// |-----------------------------------------------------------------|
/// |                   8 Bytes challengeData (continued)             |
/// |-----------------------------------------------------------------|
/// | 1 Byte 0x00    |          2 Bytes symbol       |1 Byte encoding |
/// |-----------------------------------------------------------------|
/// |        2 Bytes State            |  2 Bytes symbol High          |
/// |-----------------------------------------------------------------|
/// | 1 Byte 0x00    |
/// |-----------------------------------------------------------------|
class AuthModel: ModelProtocol {
    var reader: DataReader

    var version: Int

    var serverVersion: ServerVersion

    var serverPID: Int

    var seed: String

    var serverDefaultCollationIndex: Int

    var statusFlags: Int

    var capabilityFlags: Int

    var authPluginDataLength: Int = 0

    var serverHasFracSecsSupport: Bool = true

    required init(_ data: Data) throws {
        reader = DataReader(data)

        version = reader.readInt(.INT1)

        serverVersion = ServerVersion(versionString:
            try reader.readString(DataType.String.STRING_TERM, encoding: .ascii) ?? "")

        serverPID = reader.readInt(.INT4)

        seed = try reader.readString(.STRING_FIXED, encoding: .ascii, length: 8)

        _ = try reader.readNext(1)

        var flags = 0
        // read capability flags (lower 2 bytes)
        flags = reader.readInt(.INT2)
        // read character set (1 byte)
        serverDefaultCollationIndex = reader.readInt(.INT1)
        // read status flags (2 bytes)
        statusFlags = reader.readInt(.INT2)
        // read capability flags (upper 2 bytes)
        flags |= reader.readInt(.INT2) << 16

        capabilityFlags = flags

        if flags & SessionState.CLIENT_PLUGIN_AUTH != 0 {
            // read length of auth-plugin-data (1 byte)
            authPluginDataLength = reader.readInt(.INT1)
        } else {
            reader.skip(1)
        }
        // next 10 bytes are reserved (all [00])
        reader.skip(10)

        serverHasFracSecsSupport = serverVersion >= ServerVersion(major: 5, minor: 6, subminor: 4)

        if authPluginDataLength > 0 {
            seed += try reader.readString(.STRING_FIXED, encoding: .ascii, length: authPluginDataLength - 8)
        } else {
            seed += try reader.readString(.STRING_TERM, encoding: .ascii) ?? ""
        }

        print(seed)
    }
}
