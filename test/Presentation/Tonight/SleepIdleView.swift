//
//  SleepIdleView.swift
//  test
//

import SwiftUI

/// Prompt shown when no sleep is being tracked.
struct SleepIdleView: View {
    /// Called when the user taps "Start Sleeping".
    let onStart: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "moon.zzz.fill")
                .font(.system(size: 72))
                .foregroundStyle(.white.opacity(0.9))

            Text("Ready for bed?")
                .font(.title.bold())
                .foregroundStyle(.white)

            Text("Tap the button when you turn in,\nand again when you wake up.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.7))

            Button(action: onStart) {
                Label("Start Sleeping", systemImage: "bed.double.fill")
                    .font(.headline)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
            }
            .buttonStyle(.borderedProminent)
            .tint(.indigo)
            .controlSize(.large)
        }
    }
}

#Preview {
    ZStack {
        NightSkyBackground()
        SleepIdleView {}
    }
}
