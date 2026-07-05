//
//  LogSleepView.swift
//  test
//

import SwiftUI

/// A form for manually logging a past night of sleep.
struct LogSleepView: View {
    @Environment(SleepStore.self) private var store
    @Environment(\.dismiss) private var dismiss

    @State private var bedtime = Calendar.current.date(byAdding: .hour, value: -8, to: .now) ?? .now
    @State private var wakeTime = Date.now
    @State private var quality: SleepQuality = .okay
    @State private var notes = ""

    private var isValid: Bool { wakeTime > bedtime }

    var body: some View {
        NavigationStack {
            Form {
                Section("When") {
                    DatePicker("Bedtime", selection: $bedtime)
                    DatePicker("Wake time", selection: $wakeTime, in: bedtime...)
                }

                Section("How did you sleep?") {
                    QualityPicker(quality: $quality)
                }

                Section("Notes") {
                    TextField("Anything notable? (optional)", text: $notes, axis: .vertical)
                }
            }
            .navigationTitle("Log Sleep")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        store.logNight(bedtime: bedtime, wakeTime: wakeTime, quality: quality, notes: notes)
                        dismiss()
                    }
                    .disabled(!isValid)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    LogSleepView()
        .environment(CompositionRoot.makeSleepStore())
}
