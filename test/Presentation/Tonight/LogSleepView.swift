//
//  LogSleepView.swift
//  Somnia
//

import SwiftUI

/// A form for manually logging a past night of sleep.
struct LogSleepView: View {
    @Bindable var viewModel: LogSleepViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("When") {
                    DatePicker("Bedtime", selection: $viewModel.bedtime)
                    DatePicker("Wake time", selection: $viewModel.wakeTime, in: viewModel.bedtime...)
                }

                Section("How did you sleep?") {
                    QualityPicker(quality: $viewModel.quality)
                }

                Section("Notes") {
                    TextField("Anything notable? (optional)", text: $viewModel.notes, axis: .vertical)
                }
            }
            .navigationTitle("Log Sleep")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if viewModel.save() {
                            dismiss()
                        }
                    }
                    .disabled(!viewModel.isValid)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    LogSleepView(viewModel: CompositionRoot.makeLogSleepViewModel())
}
