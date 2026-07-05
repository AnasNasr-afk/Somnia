//
//  Formatting.swift
//  test
//
//  Display formatting lives in the Presentation layer,
//  keeping domain entities free of UI concerns.
//

import Foundation

extension TimeInterval {
    /// Formats a duration like "7h 32m".
    var formattedHoursMinutes: String {
        let totalMinutes = Int(self / 60)
        return "\(totalMinutes / 60)h \(totalMinutes % 60)m"
    }
}

extension SleepSession {
    /// Duration formatted like "7h 32m".
    var formattedDuration: String {
        duration.formattedHoursMinutes
    }
}
