//
//  WakeUpView.swift
//  test
//

import SwiftUI

/// Presented after waking up: review the night, rate it, and save.
struct WakeUpView: View {
    @Environment(SleepStore.self) private var store
    @Environment(\.dismiss) private var dismiss

    let bedtime: Date
    let wakeTime: Date

    @State private var quality: SleepQuality = .good
    @State private var notes = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Your night") {
                    LabeledContent("Bedtime", value: bedtime.formatted(date: .abbreviated, time: .shortened))
                    LabeledContent("Wake time", value: wakeTime.formatted(date: .abbreviated, time: .shortened))
                    LabeledContent("Duration", value: wakeTime.timeIntervalSince(bedtime).formattedHoursMinutes)
                }

                Section("How did you sleep?") {
                    QualityPicker(quality: $quality)
                }

                Section("Notes") {
                    TextField("Anything notable? (optional)", text: $notes, axis: .vertical)
                }
            }
            .navigationTitle("Good Morning")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        store.finishSleeping(wakeTime: wakeTime, quality: quality, notes: notes)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    // Dismissing without saving keeps the session running.
                    Button("Keep Sleeping") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    WakeUpView(bedtime: .now.addingTimeInterval(-8 * 3600), wakeTime: .now)
        .environment(CompositionRoot.makeSleepStore())
}
