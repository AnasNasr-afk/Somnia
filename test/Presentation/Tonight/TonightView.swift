//
//  TonightView.swift
//  test
//

import SwiftUI

/// The main tab: start/stop live sleep tracking, or log a night manually.
/// Composes small child views, passing them data and callbacks.
struct TonightView: View {
    @Environment(SleepStore.self) private var store
    @State private var showingManualLog = false
    @State private var pendingWake: PendingWake?

    var body: some View {
        NavigationStack {
            ZStack {
                NightSkyBackground()

                VStack(spacing: 32) {
                    Spacer()

                    if let startedAt = store.sleepStartedAt {
                        SleepInProgressView(startedAt: startedAt) {
                            pendingWake = PendingWake(wakeTime: .now)
                        }
                    } else {
                        SleepIdleView {
                            store.startSleeping()
                        }
                    }

                    Spacer()

                    Button("Log a past night manually") {
                        showingManualLog = true
                    }
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.7))
                    .padding(.bottom)
                }
                .padding()
            }
            .navigationTitle("Tonight")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .sheet(isPresented: $showingManualLog) {
                LogSleepView()
            }
            .sheet(item: $pendingWake) { pending in
                WakeUpView(
                    bedtime: store.sleepStartedAt ?? pending.wakeTime,
                    wakeTime: pending.wakeTime
                )
            }
        }
    }
}

/// The wake time frozen at the moment "Wake Up" was tapped,
/// wrapped so it can drive `.sheet(item:)`.
private struct PendingWake: Identifiable {
    let wakeTime: Date
    var id: Date { wakeTime }
}

#Preview {
    TonightView()
        .environment(CompositionRoot.makeSleepStore())
}
