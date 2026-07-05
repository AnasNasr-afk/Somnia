//
//  DeleteSleepUseCase.swift
//  test
//

import Foundation

/// Removes a logged night from history.
struct DeleteSleepUseCase {
    let repository: SleepRepository

    func execute(id: UUID) throws {
        try repository.delete(id: id)
    }
}
