//
//  SleepRepository.swift
//  test
//
//  The domain owns this contract; the Data layer provides the implementation.
//  This is the dependency-inversion boundary of Clean Architecture.
//

import Foundation

/// Boundary for persisting sleep sessions.
protocol SleepRepository {
    func fetchAll() throws -> [SleepSession]
    func save(_ session: SleepSession) throws
    func delete(id: UUID) throws
}
