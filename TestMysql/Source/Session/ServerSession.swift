//
//  ServerSession.swift
//  TestMysql
//
//  Created by Di on 2019/3/8.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

protocol ServerSession {
    var capabilities: ServerCapabilities { get set }

    var statusFlag: Int {get set}

    var transcationState: TransactionState { get set }

    var isCursorExists: Bool { get }

    var isAutocommit: Bool { get }

    var hasMoreResults: Bool { get }

    var isLastRowSend: Bool { get }

    var noGoodIndexUsed: Bool { get }

    var noIndexUsed: Bool { get }

    var queryWasSlow: Bool { get }

    var clientParam: Int { get set }

    var useMultiResults: Bool { get }

    var isEOFDeprecated: Bool { get }

    var hasLongColumnInfo: Bool { get set }

    var serverVariables: [String: String] {get set}

    func getServerVariable(name: String) -> String?

    func characterSetNamesMatches(mysqlEncodingName: String) -> Bool

    var serverVersion: ServerVersion { get }

    var serverDefaultCharset: String { get }

    var errorMessageEncoding: String.Encoding { get set }

    func getMaxBytesPerChar(charsetName: String) -> Int

    func getMaxBytesPerChar(charsetIndex: Int,charsetName: String) -> Int

    func getEncodingForIndex(_ collationIndex: Int) -> String

    func configureCharacterSets()


}

extension ServerSession {
    /**
     * There was no change between old and current SERVER_STATUS_IN_TRANS state and it is 0.
     */
    static var TRANSACTION_NOT_STARTED: Int {
        return 0
    }

    /**
     * There was no change between old and current SERVER_STATUS_IN_TRANS state and it is 1.
     */
    static var TRANSACTION_IN_PROGRESS: Int {
        return 1
    }

    /**
     * Old SERVER_STATUS_IN_TRANS state was 0 and current one is 1.
     */
    static var TRANSACTION_STARTED: Int {
        return 2
    }

    /**
     * Old SERVER_STATUS_IN_TRANS state was 1 and current one is 0.
     */
    static var TRANSACTION_COMPLETED: Int {
        return 3
    }

    static var LOCAL_CHARACTER_SET_RESULTS: String {
        return "local.character_set_results"
    }
}
