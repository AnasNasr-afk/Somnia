//
//  StatsViewModel.swift
//  Somnia
//

import Foundation
import Observation

/// Presentation logic for the Stats tab.
@Observable
final class StatsViewModel {
    private(set) var statistics: SleepStatistics = .empty

    var hasData: Bool {
        statistics != .empty
    }

    private let getStatistics: GetSleepStatisticsUseCase

    init(getStatistics: GetSleepStatisticsUseCase) {
        self.getStatistics = getStatistics
    }

    func load() {
        statistics = (try? getStatistics.execute()) ?? .empty
    }
}
