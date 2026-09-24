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
                    EmptyStateView(
                        icon: "music.mic",
                        title: viewModel.searchText.isEmpty ? "No Shows Yet" : "No Results",
                        message: viewModel.searchText.isEmpty
                            ? "Start logging for the concert you've been to" : "Try searching for something else"
                    )
                } else {
                    List {
                        ForEach(viewModel.filteredShows(allShows)) { show in
                            NavigationLink(value: show) {
                                ShowRowView(show: show)
                            }
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
            .navigationDestination(for: Show.self) { show in
                ShowDetailView(show: show)

            }
            .toolbar {
                Button("Add show!", systemImage: "plus") {
                    viewModel.showingAddSheet = true
                }
            }
            .sheet(isPresented: $vm.showingAddSheet) {
                AddEditShowView(initialStatus: .attended)
            }
        }

    }
}

#Preview {
    AttendedView()
        .modelContainer(for: Show.self, inMemory: true)
}
