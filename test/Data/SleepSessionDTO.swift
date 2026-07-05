//
//  SleepSessionDTO.swift
//  test
//
//  Codable lives here, not on the entity: the on-disk format is a
//  Data-layer detail the domain never sees.
//

import Foundation

/// Codable mirror of `SleepSession`, matching the on-disk JSON format.
struct SleepSessionDTO: Codable {
    var id: UUID
    var bedtime: Date
    var wakeTime: Date
    var quality: Int
    var notes: String

    init(_ session: SleepSession) {
        id = session.id
        bedtime = session.bedtime
        wakeTime = session.wakeTime
        quality = session.quality.rawValue
        notes = session.notes
    }

    /// Returns nil if the stored quality value is out of range.
    func toDomain() -> SleepSession? {
        guard let quality = SleepQuality(rawValue: quality) else { return nil }
        return SleepSession(id: id, bedtime: bedtime, wakeTime: wakeTime, quality: quality, notes: notes)
    }
}
