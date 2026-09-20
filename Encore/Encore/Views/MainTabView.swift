//
//  MainTabView.swift
//  Encore
//
//  Created by Ye Htet Aung on 21/09/2026.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    var body: some View {

        TabView {
            Tab("Attended", systemImage: "music.mic") {
                AttendedView()
            }

            Tab("Upcoming", systemImage: "calendar") {
                UpcomingView()
            }

            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }
        }

    }
}

#Preview {
    MainTabView()
        .modelContainer(for: Show.self, inMemory: true)
}
