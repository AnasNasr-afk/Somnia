//
//  UserDefaultsTrackingRepository.swift
//  test
//

import Foundation

/// Stores the in-progress sleep start time in UserDefaults so it survives relaunch.
final class UserDefaultsTrackingRepository: SleepTrackingRepository {
    private let defaults: UserDefaults
    private let key = "sleepStartedAt"

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func currentSleepStart() -> Date? {
        defaults.object(forKey: key) as? Date
    }

    func setSleepStart(_ date: Date?) {
        defaults.set(date, forKey: key)
    }
}
