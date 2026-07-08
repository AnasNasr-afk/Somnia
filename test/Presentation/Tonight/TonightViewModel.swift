//
//  TonightViewModel.swift
//  Somnia
//

import Foundation
import Observation

/// Presentation logic for the Tonight tab: live sleep tracking state.
@Observable
final class TonightViewModel {
    private(set) var sleepStartedAt: Date?

    private let trackSleep: TrackSleepUseCase

    init(trackSleep: TrackSleepUseCase) {
        self.trackSleep = trackSleep
        sleepStartedAt = trackSleep.currentSleepStart
    }

    func startSleeping() {
        trackSleep.start()
        sleepStartedAt = trackSleep.currentSleepStart
    }

    /// Re-reads tracking state, e.g. after the wake-up sheet is dismissed.
    func refreshTrackingState() {
        sleepStartedAt = trackSleep.currentSleepStart
    }
}
