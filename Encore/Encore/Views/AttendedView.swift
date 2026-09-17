//
//  AttendedView.swift
//  Encore
//
//  Created by Ye Htet Aung on 15/09/2026.
//

import SwiftData
import SwiftUI

struct AttendedView: View {
    @Query(sort: \Show.date, order: .reverse) private var allShows: [Show] = []
    @Environment(\.modelContext) private var context
    @State private var viewModel = AttendedViewModel()

    var body: some View {
        @Bindable var vm = viewModel

        NavigationStack {
            Group {
                if viewModel.filteredShow(allShows).isEmpty {
                    ContentUnavailableView("No Results", systemImage: "magnifyingglass")
                } else {
                    List {
                        ForEach(viewModel.filteredShow(allShows)) { show in
                            NavigationLink(value: show) {
                                ShowRowView(show: show)
                            }
                        }
                        .onDelete { indexSet in
                            let shows = viewModel.filteredShow(allShows)

                            for index in indexSet {
                                viewModel.delete(shows[index], context: context)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Attended")
            .searchable(text: $vm.searchText, prompt: "Artists, Venues, Cities")
            .navigationDestination(for: Show.self) { show in
                // ShowDetailView
            }
            .toolbar {
                Button("Add Show!", systemImage: "plus") {
                    viewModel.showingAddSheet = true
                }
            }
            .sheet(isPresented: $vm.showingAddSheet) {
                AddEditShowView()
            }
        }
    }
}

#Preview {
    AttendedView()
        .modelContainer(for: Show.self)
}
