//
//  StatsView.swift
//  test
//

import SwiftUI

/// Weekly sleep chart plus summary statistics.
struct StatsView: View {
    @Environment(SleepStore.self) private var store

    var body: some View {
        NavigationStack {
            ScrollView {
                if store.sessions.isEmpty {
                    ContentUnavailableView(
                        "No Data Yet",
                        systemImage: "chart.bar",
                        description: Text("Your sleep trends will appear here once you log a few nights.")
                    )
                    .padding(.top, 80)
                } else {
                    VStack(spacing: 16) {
                        WeeklySleepChart(dailyTotals: store.statistics.dailyTotals)

                        HStack(spacing: 16) {
                            StatCard(
                                title: "Avg. Duration",
                                value: store.statistics.averageDuration?.formattedHoursMinutes ?? "—",
                                icon: "clock.fill"
                            )
                            StatCard(
                                title: "Avg. Quality",
                                value: store.statistics.averageQuality.map { String(format: "%.1f / 5", $0) } ?? "—",
                                icon: "star.fill"
                            )
                        }

                        if let best = store.statistics.bestNight {
                            StatCard(
                                title: "Best Night",
                                value: "\(best.formattedDuration) on \(best.wakeTime.formatted(.dateTime.weekday(.wide).month().day()))",
                                icon: "trophy.fill"
                            )
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Stats")
        }
    }
}

#Preview {
    StatsView()
        .environment(CompositionRoot.makeSleepStore())
}
