//
//  AttendedView.swift
//  Encore
//
//  Created by Ye Htet Aung on 20/09/2026.
//

import SwiftData
import SwiftUI

struct AttendedView: View {
    @Query(sort: \Show.date, order: .reverse) private var allShows: [Show] = []
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = AttendedViewModel()

    var body: some View {
        @Bindable var vm = viewModel

        NavigationStack {
            Group {
                if viewModel.filteredShows(allShows).isEmpty {
                    ContentUnavailableView(
                        "No Result",
                        systemImage: "magnifyingglass"
                    )
                } else {
                    List {
                        ForEach(viewModel.filteredShows(allShows)) { show in
                            Text(
                                show.artistName
                            )
                        }
                        .onDelete { indexSet in
                            let shows = viewModel.filteredShows(allShows)
                            for index in indexSet {
                                viewModel.delete(
                                    shows[index],
                                    context: modelContext
                                )
                            }
                        }
                    }
                }
            }
            .navigationTitle("Attended")
            .searchable(text: $vm.searchText, prompt: "Artists, Venues, Cities")
            .toolbar {
                Button("Add Show", systemImage: "plus") {
                    modelContext.insert(
                        Show(
                            artistName: "Radiohead",
                            venueName: "Madison Square Garden",
                            city: "New York",
                            date: .now,
                            status: .attended
                        )
                    )
                }
            }
        }

    }
}

#Preview {
    AttendedView()
        .modelContainer(for: Show.self, inMemory: true)
}
