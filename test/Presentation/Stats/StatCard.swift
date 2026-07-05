//
//  StatCard.swift
//  test
//

import SwiftUI

/// A small labeled statistic in a rounded card.
struct StatCard: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: icon)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.title3.bold())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.quaternary.opacity(0.5), in: RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    HStack {
        StatCard(title: "Avg. Duration", value: "7h 12m", icon: "clock.fill")
        StatCard(title: "Avg. Quality", value: "3.8 / 5", icon: "star.fill")
    }
    .padding()
}
