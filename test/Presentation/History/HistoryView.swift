//
//  HistoryView.swift
//  test
//

import SwiftUI

/// A list of every logged night, newest first, with swipe-to-delete.
struct HistoryView: View {
    @Environment(SleepStore.self) private var store

    var body: some View {
        NavigationStack {
            Group {
                if store.sessions.isEmpty {
                    ContentUnavailableView(
                        "No Sleep Logged",
                        systemImage: "moon.zzz",
                        description: Text("Track a night from the Tonight tab, or log one manually.")
                    )
                } else {
                    List {
                        ForEach(store.sessions) { session in
                            SessionRow(session: session)
                                .swipeActions {
                                    Button("Delete", systemImage: "trash", role: .destructive) {
                                        store.delete(session)
                                    }
                                }
                        }
                    }
                }
            }
            .navigationTitle("History")
        }
    }
}

#Preview {
    HistoryView()
        .environment(CompositionRoot.makeSleepStore())
}
