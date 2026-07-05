//
//  QualityPicker.swift
//  test
//

import SwiftUI

/// A row of tappable faces for rating sleep quality.
struct QualityPicker: View {
    @Binding var quality: SleepQuality

    var body: some View {
        HStack {
            ForEach(SleepQuality.allCases) { option in
                Button {
                    quality = option
                } label: {
                    VStack(spacing: 4) {
                        Text(option.emoji)
                            .font(.title2)
                        Text(option.label)
                            .font(.caption2)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
                    .background(
                        quality == option ? Color.indigo.opacity(0.2) : .clear,
                        in: RoundedRectangle(cornerRadius: 8)
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    @Previewable @State var quality = SleepQuality.good
    QualityPicker(quality: $quality)
        .padding()
}
