//
//  SessionRow.swift
//  test
//

import SwiftUI

/// One night's summary: date, times, duration, and quality.
struct SessionRow: View {
    let session: SleepSession

    var body: some View {
        HStack(spacing: 12) {
            Text(session.quality.emoji)
                .font(.title2)

            VStack(alignment: .leading, spacing: 2) {
                Text(session.wakeTime, format: .dateTime.weekday(.wide).month().day())
                    .font(.headline)
                Text("\(session.bedtime.formatted(date: .omitted, time: .shortened)) → \(session.wakeTime.formatted(date: .omitted, time: .shortened))")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                if !session.notes.isEmpty {
                    Text(session.notes)
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                        .lineLimit(1)
                }
            }

            Spacer()

            Text(session.formattedDuration)
                .font(.headline)
                .foregroundStyle(.indigo)
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    List {
        SessionRow(session: SleepSession(
            bedtime: .now.addingTimeInterval(-7.5 * 3600),
            wakeTime: .now,
            quality: .good,
            notes: "Slept great after a long run."
        ))
    }
}
