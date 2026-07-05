//
//  JSONSleepRepository.swift
//  test
//

import Foundation

/// Persists sessions as a single JSON file in the app's Documents directory.
final class JSONSleepRepository: SleepRepository {
    private let fileURL: URL

    init(fileURL: URL = URL.documentsDirectory.appending(path: "sleep-sessions.json")) {
        self.fileURL = fileURL
    }

    func fetchAll() throws -> [SleepSession] {
        try fetchAllDTOs().compactMap { $0.toDomain() }
    }

    func save(_ session: SleepSession) throws {
        var dtos = try fetchAllDTOs()
        dtos.removeAll { $0.id == session.id }
        dtos.append(SleepSessionDTO(session))
        try write(dtos)
    }

    func delete(id: UUID) throws {
        var dtos = try fetchAllDTOs()
        dtos.removeAll { $0.id == id }
        try write(dtos)
    }

    // MARK: - File access

    private func fetchAllDTOs() throws -> [SleepSessionDTO] {
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return [] }
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode([SleepSessionDTO].self, from: data)
    }

    private func write(_ dtos: [SleepSessionDTO]) throws {
        let data = try JSONEncoder().encode(dtos)
        try data.write(to: fileURL, options: .atomic)
    }
}
