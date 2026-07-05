//
//  SleepStatistics.swift
//  test
//

import Foundation

/// Aggregate sleep metrics computed by the domain layer.
struct SleepStatistics: Equatable {
    let averageDuration: TimeInterval?
    let averageQuality: Double?
    let bestNight: SleepSession?
    /// Total sleep per day for the most recent week, oldest day first.
    let dailyTotals: [DailySleepTotal]

    static let empty = SleepStatistics(
        averageDuration: nil,
        averageQuality: nil,
        bestNight: nil,
        dailyTotals: []
    )
}

/// Total sleep credited to a single calendar day (by wake time).
struct DailySleepTotal: Identifiable, Equatable {
    let day: Date
    let duration: TimeInterval

    var id: Date { day }
}
