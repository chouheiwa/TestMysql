//
//  TranscationState.swift
//  TestMysql
//
//  Created by Di on 2019/3/10.
//  Copyright © 2019 chouheiwa. All rights reserved.
//

import Foundation

enum TransactionState: Int {
    case notStarted = 0
    case inProgress = 1
    case started = 2
    case completed = 3
}
