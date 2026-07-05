//
//  GetSleepHistoryUseCase.swift
//  test
//

import Foundation

/// Fetches all logged nights, newest first.
struct GetSleepHistoryUseCase {
    let repository: SleepRepository

    func execute() throws -> [SleepSession] {
        try repository.fetchAll().sorted { $0.wakeTime > $1.wakeTime }
    }
}
