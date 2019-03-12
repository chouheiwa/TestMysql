//
//  ServerVersion.swift
//  TestMysql
//
//  Created by Di on 2019/3/8.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

class ServerVersion {
    var major: Int = 0
    var minor: Int = 0
    var subminor: Int = 0

    var completeVersion: String?

    init() {}

    init(versionString: String) {
        let list = versionString.split(separator: ".")

        guard list.count > 2 else {
            return
        }

        major = Int(list[0]) ?? 0
        minor = Int(list[1]) ?? 0
        subminor = Int(list[2]) ?? 0
    }

    init(completeVersion: String? = nil, major: Int, minor: Int, subminor: Int) {
        self.major = major
        self.minor = minor
        self.subminor = subminor

        self.completeVersion = completeVersion
    }
}

extension ServerVersion: CustomStringConvertible {
    var description: String {
        return "\(major).\(minor).\(subminor)"
    }
}

extension ServerVersion {
    static func > (left: ServerVersion, right: ServerVersion) -> Bool {
        guard left.major == right.major else {
            return left.major > right.major
        }

        guard left.minor == right.minor else {
            return left.minor > right.minor
        }

        return left.subminor > right.subminor
    }

    static func < (left: ServerVersion, right: ServerVersion) -> Bool {
        guard left.major == right.major else {
            return left.major < right.major
        }

        guard left.minor == right.minor else {
            return left.minor < right.minor
        }

        return left.subminor < right.subminor
    }

    static func == (left: ServerVersion, right: ServerVersion) -> Bool {
        return (left.major == right.major) &&
            (left.minor == right.minor) &&
            (left.subminor == right.subminor)
    }

    static func >= (left: ServerVersion, right: ServerVersion) -> Bool {
        return left > right || left == right
    }

    static func <= (left: ServerVersion, right: ServerVersion) -> Bool {
        return left < right || left == right
    }
}
