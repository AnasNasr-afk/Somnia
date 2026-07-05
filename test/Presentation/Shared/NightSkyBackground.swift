//
//  NightSkyBackground.swift
//  test
//

import SwiftUI

/// The full-screen indigo-to-black gradient behind the Tonight tab.
struct NightSkyBackground: View {
    var body: some View {
        LinearGradient(
            colors: [.indigo.opacity(0.7), .black],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

#Preview {
    NightSkyBackground()
}
