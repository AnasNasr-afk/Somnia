//
//  SleepStore.swift
//  test
//
//  Presentation-layer state shared by all tabs.
//  Talks to the domain exclusively through use cases.
//

import Foundation
import Observation

@Observable
final class SleepStore {
    private(set) var sessions: [SleepSession] = []
    private(set) var statistics: SleepStatistics = .empty
    private(set) var sleepStartedAt: Date?

    private let getHistory: GetSleepHistoryUseCase
    private let getStatistics: GetSleepStatisticsUseCase
    private let logSleep: LogSleepUseCase
    private let deleteSleep: DeleteSleepUseCase
    private let trackSleep: TrackSleepUseCase

    init(
        getHistory: GetSleepHistoryUseCase,
        getStatistics: GetSleepStatisticsUseCase,
        logSleep: LogSleepUseCase,
        deleteSleep: DeleteSleepUseCase,
        trackSleep: TrackSleepUseCase
    ) {
        self.getHistory = getHistory
        self.getStatistics = getStatistics
        self.logSleep = logSleep
        self.deleteSleep = deleteSleep
        self.trackSleep = trackSleep

        sleepStartedAt = trackSleep.currentSleepStart
        refresh()
    }

    // MARK: - Actions

    func startSleeping() {
        trackSleep.start()
        sleepStartedAt = trackSleep.currentSleepStart
    }

    func finishSleeping(wakeTime: Date, quality: SleepQuality, notes: String) {
        try? trackSleep.complete(wakeTime: wakeTime, quality: quality, notes: notes)
        sleepStartedAt = trackSleep.currentSleepStart
        refresh()
    }

    func logNight(bedtime: Date, wakeTime: Date, quality: SleepQuality, notes: String) {
        try? logSleep.execute(bedtime: bedtime, wakeTime: wakeTime, quality: quality, notes: notes)
        refresh()
    }

    func delete(_ session: SleepSession) {
        try? deleteSleep.execute(id: session.id)
        refresh()
    }

    /// Re-reads history and statistics from the domain.
    private func refresh() {
        sessions = (try? getHistory.execute()) ?? []
        statistics = (try? getStatistics.execute()) ?? .empty
    }
}
