//
//  AttendedViewModel.swift
//  Encore
//
//  Created by Ye Htet Aung on 15/09/2026.
//

import Foundation
import SwiftData

@Observable
final class AttendedViewModel {
    var searchText = ""
    var showingAddSheet = false

    func filteredShow(_ show: [Show]) -> [Show] {
        let attended = show.filter({ $0.status == .attended })
        guard !searchText.isEmpty else { return attended }
        return attended.filter {
            $0.artistName.localizedCaseInsensitiveContains(searchText)
                || $0.venueName.localizedCaseInsensitiveContains(searchText)
                || $0.city.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    func delete(_ show: Show, context: ModelContext) {
        context.delete(show)
    }
}
