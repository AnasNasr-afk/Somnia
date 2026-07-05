//
//  ContentView.swift
//  test
//
//  Created by Anas Nasr on 05/07/2026.
//

import SwiftUI

struct ContentView: View {
    /// Single source of truth for all sleep data, shared with every tab.
    @State private var store = CompositionRoot.makeSleepStore()

    var body: some View {
        TabView {
            Tab("Tonight", systemImage: "moon.stars.fill") {
                TonightView()
            }
            Tab("History", systemImage: "list.bullet") {
                HistoryView()
            }
            Tab("Stats", systemImage: "chart.bar.fill") {
                StatsView()
            }
        }
        .environment(store)
    }
}

#Preview {
    ContentView()
}
