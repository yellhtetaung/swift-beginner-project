//
//  UpcomingView.swift
//  Encore
//
//  Created by Ye Htet Aung on 21/09/2026.
//

import SwiftData
import SwiftUI

struct UpcomingView: View {
    @Query(sort: \Show.date) private var allShows: [Show]
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = UpcomingViewModel()

    var body: some View {
        @Bindable var vm = viewModel

        NavigationStack {
            Group {
                if viewModel.filteredShow(allShows).isEmpty {
                    ContentUnavailableView(
                        "No Upcoming Show",
                        systemImage: "calendar"
                    )
                } else {
                    List {
                        ForEach(viewModel.filteredShow(allShows)) { show in
                            NavigationLink(value: show) {
                                ShowRowView(show: show)
                            }
                            .swipeActions(edge: .leading) {
                                Button("Attend") {
                                    viewModel.showToMarkAttended = show
                                }
                                .tint(.green)
                            }
                        }
                        .onDelete { indexSet in
                            let shows = viewModel.filteredShow(allShows)
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
            .navigationTitle("Upcoming")
            .navigationDestination(for: Show.self) { show in
                // ShowDetailView
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add Show!", systemImage: "plus") {
                        viewModel.showingAddSheet = true
                    }
                }
            }
            .sheet(isPresented: $vm.showingAddSheet) {
                AddEditShowView(initialStatus: .upcoming)
            }
            .sheet(item: $vm.showToMarkAttended) { show in
                MarkToAttendedSheet(show: show, viewModel: viewModel)
            }
        }
    }
}

#Preview {
    UpcomingView()
        .modelContainer(for: Show.self, inMemory: true)
}
