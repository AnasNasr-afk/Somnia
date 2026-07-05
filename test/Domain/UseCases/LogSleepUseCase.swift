//
//  LogSleepUseCase.swift
//  test
//

import Foundation

/// Validates and records a completed night of sleep.
struct LogSleepUseCase {
    let repository: SleepRepository

    enum ValidationError: Error {
        case wakeBeforeBed
    }

    @discardableResult
    func execute(bedtime: Date, wakeTime: Date, quality: SleepQuality, notes: String) throws -> SleepSession {
        guard wakeTime > bedtime else { throw ValidationError.wakeBeforeBed }

        let session = SleepSession(bedtime: bedtime, wakeTime: wakeTime, quality: quality, notes: notes)
        try repository.save(session)
        return session
    }
}
