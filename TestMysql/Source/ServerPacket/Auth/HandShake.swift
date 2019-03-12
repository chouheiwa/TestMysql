//
//  AuthModel.swift
//  TestMysql
//
//  Created by Di on 2019/3/5.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation
/// Doc Page:
/// https://dev.mysql.com/doc/internals/en/connection-phase-packets.html#packet-Protocol::Handshake
class HandShake: ServerPacketProtocol {
    let reader: DataReader

    var protocolVersion: ProtocolVersion

    var serverVersion: ServerVersion

    var serverPID: Int

    var seed: String

    var serverDefaultCollationIndex: Int

    var statusFlags: Int

    var capabilityFlags: CapabilityFlags

    var authPluginDataLength: Int = 0

    var serverHasFracSecsSupport: Bool = true

    var authPluginName: String?

    required init(_ data: Data) throws {
        reader = DataReader(data)
        guard let version = ProtocolVersion(rawValue: reader.readInt(.INT1)) else {
            throw PacketError.handshakeProtocolVersionNotKnown
        }
        protocolVersion = version

        serverVersion = ServerVersion(versionString:
            try reader.readString(DataType.String.STRING_TERM, encoding: .ascii) ?? "")

        serverPID = reader.readInt(.INT4)

        seed = try reader.readString(.STRING_FIXED, encoding: .ascii, length: 8)

        reader.skip(1)

        var flags = 0
        // read capability flags (lower 2 bytes)
        flags = reader.readInt(.INT2)
        // read character set (1 byte)
        serverDefaultCollationIndex = reader.readInt(.INT1)
        // read status flags (2 bytes)
        statusFlags = reader.readInt(.INT2)
        // read capability flags (upper 2 bytes)
        flags |= reader.readInt(.INT2) << 16

        capabilityFlags = CapabilityFlags(rawValue: flags)

        if capabilityFlags.contains(.CLIENT_PLUGIN_AUTH) {
            // read length of auth-plugin-data (1 byte)
            authPluginDataLength = reader.readInt(.INT1)
        } else {
            reader.skip(1)
        }
        // next 10 bytes are reserved (all [00])
        reader.skip(10)

        serverHasFracSecsSupport = serverVersion >= ServerVersion(major: 5, minor: 6, subminor: 4)

        if capabilityFlags.contains(.CLIENT_SECURE_CONNECTION) {
            let length = max(13, authPluginDataLength - 8)

            seed += try reader.readString(.STRING_FIXED, encoding: .ascii, length: length)
        }

        if capabilityFlags.contains(.CLIENT_PLUGIN_AUTH) {
            authPluginName = try reader.readString(.STRING_TERM, encoding: .ascii)
        }
    }
}
