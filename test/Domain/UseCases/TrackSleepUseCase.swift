//
//  TrackSleepUseCase.swift
//  test
//

import Foundation

/// Starts, restores, and completes live sleep tracking.
struct TrackSleepUseCase {
    let trackingRepository: SleepTrackingRepository
    let logSleep: LogSleepUseCase

    enum TrackingError: Error {
        case notTracking
    }

    /// When the in-progress session began, or nil when not tracking.
    var currentSleepStart: Date? {
        trackingRepository.currentSleepStart()
    }

    func start(at date: Date = .now) {
        trackingRepository.setSleepStart(date)
    }

    /// Ends the in-progress session, logging it as a completed night.
    @discardableResult
    func complete(wakeTime: Date, quality: SleepQuality, notes: String) throws -> SleepSession {
        guard let bedtime = currentSleepStart else { throw TrackingError.notTracking }

        let session = try logSleep.execute(bedtime: bedtime, wakeTime: wakeTime, quality: quality, notes: notes)
        trackingRepository.setSleepStart(nil)
        return session
    }
}
