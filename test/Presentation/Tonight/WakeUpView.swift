//
//  WakeUpView.swift
//  Somnia
//

import SwiftUI

/// Presented after waking up: review the night, rate it, and save.
struct WakeUpView: View {
    @Bindable var viewModel: WakeUpViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("Your night") {
                    LabeledContent("Bedtime", value: viewModel.bedtime.formatted(date: .abbreviated, time: .shortened))
                    LabeledContent("Wake time", value: viewModel.wakeTime.formatted(date: .abbreviated, time: .shortened))
                    LabeledContent("Duration", value: viewModel.duration.formattedHoursMinutes)
                }

                Section("How did you sleep?") {
                    QualityPicker(quality: $viewModel.quality)
                }

                Section("Notes") {
                    TextField("Anything notable? (optional)", text: $viewModel.notes, axis: .vertical)
                }
            }
            .navigationTitle("Good Morning")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if viewModel.save() {
                            dismiss()
                        }
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
    WakeUpView(viewModel: CompositionRoot.makeWakeUpViewModel(
        bedtime: .now.addingTimeInterval(-8 * 3600),
        wakeTime: .now
    ))
}
