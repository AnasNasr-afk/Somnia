//
//  LogSleepViewModel.swift
//  Somnia
//

import Foundation
import Observation

/// Presentation logic for the manual log form: field state and validation.
@Observable
final class LogSleepViewModel {
    var bedtime: Date
    var wakeTime: Date
    var quality: SleepQuality = .okay
    var notes = ""

    var isValid: Bool {
        wakeTime > bedtime
    }

    private let logSleep: LogSleepUseCase

    init(logSleep: LogSleepUseCase) {
        self.logSleep = logSleep
        let now = Date.now
        wakeTime = now
        bedtime = Calendar.current.date(byAdding: .hour, value: -8, to: now) ?? now
    }

    /// Returns true when the night was saved.
    func save() -> Bool {
        do {
            try logSleep.execute(bedtime: bedtime, wakeTime: wakeTime, quality: quality, notes: notes)
            return true
        } catch {
            return false
        }
    }
}
