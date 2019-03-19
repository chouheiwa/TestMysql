//
//  MysqlSocket.swift
//  TestMysql
//
//  Created by Di on 2019/3/5.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation
import SwiftAsyncSocket

class MysqlSocket: Socket {
    var currentUser: String = ""

    var currentPassword: String = ""

    var currentDataBase: String = ""

    typealias HandShakeBlock = (ServerHandShake) -> Void
    var handShakeBlock: HandShakeBlock?

    private var authProvider: AuthProvider!

    var host: String
    var port: UInt16

    var socket: SwiftAsyncSocket

    var isSSLEstablish: Bool {
        return socket.isSecure
    }

    private var serverSession: ServerSession!

    init(host: String, port: UInt16 = 3306) {
        socket = SwiftAsyncSocket(delegate: nil, delegateQueue: DispatchQueue.global())

        self.host = host
        self.port = port

        socket.delegate = self

        authProvider = ProviderFactory.makeAuthProvider(self)

        serverSession = NativeServerSession(socket: self)
    }

    func connect() throws {
        try socket.connect(toHost: host, onPort: port)
    }

    func startSSL() {
        socket.startTLS()
    }

    func initialHandShakeReceive(_ block: @escaping ((ServerHandShake) -> Void)) {
        self.handShakeBlock = block
    }

    func needAuthority() {
        
    }
}

extension MysqlSocket: SwiftAsyncSocketDelegate {
    func socket(_ socket: SwiftAsyncSocket, didConnect toHost: String, port: UInt16) {
        socket.readData(timeOut: -1, tag: 0)
    }

    func socket(_ socket: SwiftAsyncSocket, didRead data: Data, with tag: Int) {
        print("ReceiveData")
        print("Data Length: \(data.count)")

        let list = try! Parser().parser(data: data)

        let auth = try! ServerHandShake(list!.data)

        print(auth.serverVersion)
    }
}


