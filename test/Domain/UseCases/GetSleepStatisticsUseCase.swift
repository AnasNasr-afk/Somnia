//
//  GetSleepStatisticsUseCase.swift
//  test
//

import Foundation

/// Computes aggregate metrics over all logged nights.
struct GetSleepStatisticsUseCase {
    let repository: SleepRepository
    var calendar = Calendar.current

    func execute() throws -> SleepStatistics {
        let sessions = try repository.fetchAll()
        guard !sessions.isEmpty else { return .empty }

        let count = Double(sessions.count)
        return SleepStatistics(
            averageDuration: sessions.map(\.duration).reduce(0, +) / count,
            averageQuality: Double(sessions.map(\.quality.rawValue).reduce(0, +)) / count,
            bestNight: sessions.max { $0.duration < $1.duration },
            dailyTotals: dailyTotals(for: sessions)
        )
    }

    /// Total sleep for each of the past 7 days, keyed by wake day, oldest first.
    private func dailyTotals(for sessions: [SleepSession]) -> [DailySleepTotal] {
        (0..<7).reversed().compactMap { offset in
            guard let date = calendar.date(byAdding: .day, value: -offset, to: .now) else { return nil }
            let day = calendar.startOfDay(for: date)
            let total = sessions
                .filter { calendar.isDate($0.wakeTime, inSameDayAs: day) }
                .map(\.duration)
                .reduce(0, +)
            return DailySleepTotal(day: day, duration: total)
        }
    }
}
