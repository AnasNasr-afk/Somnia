//
//  ContentView.swift
//  Somnia
//
//  Created by Anas Nasr on 05/07/2026.
//

import SwiftUI

struct ContentView: View {
    // Tab ViewModels live for the app's lifetime; each tab reloads
    // its data onAppear so changes made elsewhere show up.
    @State private var tonightViewModel = CompositionRoot.makeTonightViewModel()
    @State private var historyViewModel = CompositionRoot.makeHistoryViewModel()
    @State private var statsViewModel = CompositionRoot.makeStatsViewModel()

    var body: some View {
        TabView {
            Tab("Tonight", systemImage: "moon.stars.fill") {
                TonightView(viewModel: tonightViewModel)
            }
            Tab("History", systemImage: "list.bullet") {
                HistoryView(viewModel: historyViewModel)
            }
            Tab("Stats", systemImage: "chart.bar.fill") {
                StatsView(viewModel: statsViewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
