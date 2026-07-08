//
//  WakeUpViewModel.swift
//  Somnia
//

import Foundation
import Observation

/// Presentation logic for the morning check-in sheet.
@Observable
final class WakeUpViewModel {
    let bedtime: Date
    let wakeTime: Date
    var quality: SleepQuality = .good
    var notes = ""

    var duration: TimeInterval {
        wakeTime.timeIntervalSince(bedtime)
    }

    private let trackSleep: TrackSleepUseCase

    init(bedtime: Date, wakeTime: Date, trackSleep: TrackSleepUseCase) {
        self.bedtime = bedtime
        self.wakeTime = wakeTime
        self.trackSleep = trackSleep
    }

    /// Ends the tracked session. Returns true when the night was saved.
    func save() -> Bool {
        do {
            try trackSleep.complete(wakeTime: wakeTime, quality: quality, notes: notes)
            return true
        } catch {
            return false
        }
    }
}
