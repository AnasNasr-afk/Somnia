//
//  HistoryViewModel.swift
//  Somnia
//

import Foundation
import Observation

/// Presentation logic for the History tab.
@Observable
final class HistoryViewModel {
    private(set) var sessions: [SleepSession] = []

    private let getHistory: GetSleepHistoryUseCase
    private let deleteSleep: DeleteSleepUseCase

    init(getHistory: GetSleepHistoryUseCase, deleteSleep: DeleteSleepUseCase) {
        self.getHistory = getHistory
        self.deleteSleep = deleteSleep
    }

    func load() {
        sessions = (try? getHistory.execute()) ?? []
    }

    func delete(_ session: SleepSession) {
        try? deleteSleep.execute(id: session.id)
        load()
    }
}
