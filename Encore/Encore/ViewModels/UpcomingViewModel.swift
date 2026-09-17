//
//  UpcomingViewModel.swift
//  Encore
//
//  Created by Ye Htet Aung on 17/09/2026.
//

import Foundation
import SwiftData

@Observable
final class UpcomingViewModel {
    var showingAddSheet = false

    func filteredShows(_ shows: [Show]) -> [Show] {
        shows
            .filter { $0.status == .upcoming }
            .sorted { $0.date < $1.date }
    }
    
    func delete(_ show: Show, context: ModelContext) {
        context.delete(show)
    }
}
