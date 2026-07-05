//
//  SleepInProgressView.swift
//  test
//

import SwiftUI

/// Shown while a sleep session is in progress, with a live elapsed timer.
struct SleepInProgressView: View {
    let startedAt: Date
    /// Called when the user taps "Wake Up".
    let onWake: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "zzz")
                .font(.system(size: 72))
                .foregroundStyle(.white.opacity(0.9))
                .symbolEffect(.variableColor.iterative, options: .repeating)

            Text("Sleeping…")
                .font(.title.bold())
                .foregroundStyle(.white)

            // Self-updating elapsed time since bedtime.
            Text(startedAt, style: .timer)
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .monospacedDigit()
                .foregroundStyle(.white)

            Button(action: onWake) {
                Label("Wake Up", systemImage: "sun.max.fill")
                    .font(.headline)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .controlSize(.large)
        }
    }
}

#Preview {
    ZStack {
        NightSkyBackground()
        SleepInProgressView(startedAt: .now.addingTimeInterval(-7 * 3600)) {}
    }
}
