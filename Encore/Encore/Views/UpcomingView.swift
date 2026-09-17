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
        @Bindable var vm = viewModel()
        
        NavigationStack {
            Group {
                if viewModel.filteredShows(allShows).isEmpty {
                    ContentUnavailableView("No Upcoming Shows", systemImage: "calender")
                }
            }
        }
    }
}

#Preview {
    UpcomingView()
}
