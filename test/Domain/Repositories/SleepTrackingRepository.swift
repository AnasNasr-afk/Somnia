//
//  SleepTrackingRepository.swift
//  test
//

import Foundation

/// Boundary for remembering an in-progress sleep session across app launches.
protocol SleepTrackingRepository {
    /// When the current session started, or nil when not tracking.
    func currentSleepStart() -> Date?

    /// Pass nil to clear tracking.
    func setSleepStart(_ date: Date?)
}
