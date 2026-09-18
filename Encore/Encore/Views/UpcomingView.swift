//
//  UpcomingView.swift
//  Encore
//
//  Created by Ye Htet Aung on 15/09/2026.
//

import SwiftUI
import SwiftData

struct UpcomingView: View {
    @Query(sort: \Show.date) private var allShows: [Show]
    @Environment(\.modelContext) private var context
    @State private var viewModel = UpcomingViewModel()
    
    var body: some View {
        @Bindable var vm = viewModel
        
        NavigationStack {
            Group {
                if viewModel.filteredShows(allShows).isEmpty {
                    ContentUnavailableView("No Upcoming Shows", systemImage: "calendar")
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
                                viewModel.delete(shows[index], context: context)
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
                    Button("Add Show", systemImage: "plus") {
                        viewModel.showingAddSheet = true
                    }
                }
            }
            .sheet(isPresented: $vm.showingAddSheet) {
                AddEditShowView(initialStatus: .upcoming)
            }
        }
    }
}

#Preview {
    UpcomingView()
        .modelContainer(for: Show.self, inMemory: true)
}
