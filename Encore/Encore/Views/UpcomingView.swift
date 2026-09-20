//
//  UpcomingView.swift
//  Encore
//
//  Created by Ye Htet Aung on 21/09/2026.
//

import SwiftUI
import SwiftData

struct UpcomingView: View {
    @Query private var shows: [Show]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(shows) { show in
                    
                }
            }
            .navigationTitle("Upcoming")
            .toolbar {
                Button("Add Show", systemImage: "plus") {
                    
                }
            }
        }
    }
}

#Preview {
    UpcomingView()
        .modelContainer(for: Show.self, inMemory: true)
}
