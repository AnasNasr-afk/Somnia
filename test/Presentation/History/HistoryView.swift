//
//  HistoryView.swift
//  Somnia
//

import SwiftUI

/// A list of every logged night, newest first, with swipe-to-delete.
struct HistoryView: View {
    let viewModel: HistoryViewModel

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.sessions.isEmpty {
                    ContentUnavailableView(
                        "No Sleep Logged",
                        systemImage: "moon.zzz",
                        description: Text("Track a night from the Tonight tab, or log one manually.")
                    )
                } else {
                    List {
                        ForEach(viewModel.sessions) { session in
                            SessionRow(session: session)
                                .swipeActions {
                                    Button("Delete", systemImage: "trash", role: .destructive) {
                                        viewModel.delete(session)
                                    }
                                }
                        }
                    }
                }
            }
            .navigationTitle("History")
            .onAppear {
                viewModel.load()
            }
        }
    }
}

#Preview {
    HistoryView(viewModel: CompositionRoot.makeHistoryViewModel())
}
