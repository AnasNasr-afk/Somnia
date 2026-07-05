//
//  SleepSession.swift
//  test
//
//  Domain entity: pure business model with no persistence or UI concerns.
//

import Foundation

/// A single night of sleep, from bedtime to wake time.
struct SleepSession: Identifiable, Equatable {
    let id: UUID
    var bedtime: Date
    var wakeTime: Date
    var quality: SleepQuality
    var notes: String

    init(
        id: UUID = UUID(),
        bedtime: Date,
        wakeTime: Date,
        quality: SleepQuality,
        notes: String = ""
    ) {
        self.id = id
        self.bedtime = bedtime
        self.wakeTime = wakeTime
        self.quality = quality
        self.notes = notes
    }

    /// Total time asleep in seconds.
    var duration: TimeInterval {
        wakeTime.timeIntervalSince(bedtime)
    }
}

/// How restful the night felt, on a five-point scale.
enum SleepQuality: Int, CaseIterable, Identifiable {
    case terrible = 1
    case poor
    case okay
    case good
    case excellent

    var id: Int { rawValue }

    var label: String {
        switch self {
        case .terrible: "Terrible"
        case .poor: "Poor"
        case .okay: "Okay"
        case .good: "Good"
        case .excellent: "Excellent"
        }
    }

    var emoji: String {
        switch self {
        case .terrible: "😫"
        case .poor: "😕"
        case .okay: "😐"
        case .good: "🙂"
        case .excellent: "😴"
        }
    }
}
