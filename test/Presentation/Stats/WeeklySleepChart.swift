//
//  WeeklySleepChart.swift
//  test
//

import SwiftUI
import Charts

/// Hours slept per day over the last week, with an 8-hour goal line.
struct WeeklySleepChart: View {
    let dailyTotals: [DailySleepTotal]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Last 7 Days", systemImage: "calendar")
                .font(.caption)
                .foregroundStyle(.secondary)

            Chart(dailyTotals) { item in
                BarMark(
                    x: .value("Day", item.day, unit: .day),
                    y: .value("Hours", item.duration / 3600)
                )
                .foregroundStyle(.indigo.gradient)
                .cornerRadius(4)

                RuleMark(y: .value("Goal", 8))
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
                    .foregroundStyle(.orange)
                    .annotation(position: .top, alignment: .trailing) {
                        Text("8h goal")
                            .font(.caption2)
                            .foregroundStyle(.orange)
                    }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .day)) { _ in
                    AxisValueLabel(format: .dateTime.weekday(.abbreviated))
                }
            }
            .frame(height: 200)
        }
        .padding()
        .background(.quaternary.opacity(0.5), in: RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    WeeklySleepChart(dailyTotals: (0..<7).reversed().map { offset in
        DailySleepTotal(
            day: Calendar.current.startOfDay(for: .now.addingTimeInterval(Double(-offset) * 86400)),
            duration: Double.random(in: 5...9) * 3600
        )
    })
    .padding()
}
