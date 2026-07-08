//
//  CompositionRoot.swift
//  Somnia
//
//  The only place that knows about every layer: it wires concrete
//  Data implementations into Domain use cases and builds the
//  ViewModels the Presentation layer needs.
//

import Foundation

enum CompositionRoot {
    // Shared infrastructure — one instance behind all use cases.
    private static let sleepRepository = JSONSleepRepository()
    private static let trackingRepository = UserDefaultsTrackingRepository()

    private static var logSleep: LogSleepUseCase {
        LogSleepUseCase(repository: sleepRepository)
    }

    private static var trackSleep: TrackSleepUseCase {
        TrackSleepUseCase(trackingRepository: trackingRepository, logSleep: logSleep)
    }

    // MARK: - ViewModel factories

    static func makeTonightViewModel() -> TonightViewModel {
        TonightViewModel(trackSleep: trackSleep)
    }

    static func makeWakeUpViewModel(bedtime: Date, wakeTime: Date) -> WakeUpViewModel {
        WakeUpViewModel(bedtime: bedtime, wakeTime: wakeTime, trackSleep: trackSleep)
    }

    static func makeLogSleepViewModel() -> LogSleepViewModel {
        LogSleepViewModel(logSleep: logSleep)
    }

    static func makeHistoryViewModel() -> HistoryViewModel {
        HistoryViewModel(
            getHistory: GetSleepHistoryUseCase(repository: sleepRepository),
            deleteSleep: DeleteSleepUseCase(repository: sleepRepository)
        )
    }

    static func makeStatsViewModel() -> StatsViewModel {
        StatsViewModel(getStatistics: GetSleepStatisticsUseCase(repository: sleepRepository))
    }
}
