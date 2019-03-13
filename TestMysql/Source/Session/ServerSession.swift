//
//  ServerSession.swift
//  TestMysql
//
//  Created by Di on 2019/3/8.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

protocol ServerSession: class {
    var capabilities: ServerCapabilities? { get set }

    var statusFlag: StatusFlag {get set}

    var transcationState: TransactionState { get set }

    var clientParam: CapabilityFlags { get set }

    var hasLongColumnInfo: Bool { get set }

    var serverVariables: [String: String] {get set}

    var serverVersion: ServerVersion { get }

    var serverDefaultCharset: CharacterSet { get }

    var errorMessageEncoding: CharacterSet { get set }

    var connectedSocket: MysqlSocket { get set }
}

// MARK: - StatusFlag
extension ServerSession {
    var isCursorExists: Bool {
        return statusFlag.contains(.SERVER_STATUS_CURSOR_EXISTS)
    }

    var isAutocommit: Bool {
        return statusFlag.contains(.SERVER_STATUS_AUTOCOMMIT)
    }

    var hasMoreResults: Bool {
        return statusFlag.contains(.SERVER_MORE_RESULTS_EXISTS)
    }

    var isLastRowSend: Bool {
        return statusFlag.contains(.SERVER_STATUS_LAST_ROW_SENT)
    }

    var noGoodIndexUsed: Bool {
        return statusFlag.contains(.SERVER_STATUS_NO_GOOD_INDEX_USED)
    }

    var noIndexUsed: Bool {
        return statusFlag.contains(.SERVER_STATUS_NO_INDEX_USED)
    }

    var queryWasSlow: Bool {
        return statusFlag.contains(.SERVER_QUERY_WAS_SLOW)
    }
}

// MARK: - CapabilityFlags
extension ServerSession {
    var useMultiResults: Bool {
        return clientParam.contains(.CLIENT_MULTI_RESULTS) || clientParam.contains(.CLIENT_PS_MULTI_RESULTS)
    }

    var isEOFDeprecated: Bool {
        return clientParam.contains(.CLIENT_DEPRECATE_EOF)
    }
}

extension ServerSession {
    func getServerVariable(name: String) -> String? {
        return serverVariables[name]
    }
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
