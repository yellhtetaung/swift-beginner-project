//
//  EmptyStateView.swift
//  Encore
//
//  Created by Ye Htet Aung on 24/09/2026.
//

import SwiftUI

struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String

    var body: some View {
        ContentUnavailableView(title, systemImage: icon, description: Text(message))
    }
}
