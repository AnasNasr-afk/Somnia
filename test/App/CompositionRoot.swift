//
//  CompositionRoot.swift
//  test
//
//  The only place that knows about every layer: it wires concrete
//  Data implementations into Domain use cases, then hands the
//  Presentation layer a ready-to-use store.
//

import Foundation

enum CompositionRoot {
    static func makeSleepStore() -> SleepStore {
        let sleepRepository = JSONSleepRepository()
        let trackingRepository = UserDefaultsTrackingRepository()
        let logSleep = LogSleepUseCase(repository: sleepRepository)

        return SleepStore(
            getHistory: GetSleepHistoryUseCase(repository: sleepRepository),
            getStatistics: GetSleepStatisticsUseCase(repository: sleepRepository),
            logSleep: logSleep,
            deleteSleep: DeleteSleepUseCase(repository: sleepRepository),
            trackSleep: TrackSleepUseCase(
                trackingRepository: trackingRepository,
                logSleep: logSleep
            )
        )
    }
}
