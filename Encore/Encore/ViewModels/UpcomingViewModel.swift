//
//  UpcomingViewModel.swift
//  Encore
//
//  Created by Ye Htet Aung on 21/09/2026.
//

import Foundation
import SwiftData

@Observable
final class UpcomingViewModel {
    var showingAddSheet = false
    var showToMarkAttended: Show?
    var pendingRating = 0

    func filteredShow(_ shows: [Show]) -> [Show] {
        shows
            .filter { $0.status == .upcoming }
            .sorted { $0.date < $1.date }
    }
    
    func delete(_ show: Show, context: ModelContext) {
        context.delete(show)
    }
    
    func markAsAttended(_ show: Show) {
        show.status = .attended
        show.rating = pendingRating > 0 ? pendingRating : nil
        pendingRating = 0
        showToMarkAttended = nil
    }
}
