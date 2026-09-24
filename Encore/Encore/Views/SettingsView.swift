//
//  SettingsView.swift
//  Encore
//
//  Created by Ye Htet Aung on 21/09/2026.
//

import SwiftData
import SwiftUI

struct SettingsView: View {
    @Query private var allShows: [Show]
    @State private var viewModel = SettingsViewModel()

    var body: some View {
        NavigationStack {
            Form {
                Section("Your Stats") {
                    LabeledContent("Shows Attended", value: "\(viewModel.attendedCount(allShows))")
                    LabeledContent("Shows Upcoming", value: "\(viewModel.upcomingCout(allShows))")
                    LabeledContent("Seen this Year", value: "\(viewModel.seenThisYear(allShows))")
                    if let topArtist = viewModel.topArtist(allShows) {
                        LabeledContent("Most Seen Artist", value: topArtist)
                    }
                }

                Section("Notifications") {
                    Toggle(
                        "Show Remainders",
                        isOn: Binding(
                            get: { viewModel.notificationsEnabled },
                            set: { enabled in
                                if enabled {
                                    viewModel.requestNotificationsPermission()
                                }
                            }
                        )
                    )
                }

                Section("Your Data") {
                    ShareLink(item: viewModel.exportText(allShows)) {
                        Label("Export History", systemImage: "square.and.arrow.up")
                    }
                    .disabled(allShows.isEmpty)
                }

                Section("App") {
                    LabeledContent(
                        "Version",
                        value: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
                    )
                }
            }
            .navigationTitle("Settings")
            .onAppear {
                viewModel.checkNotificationsStatus()
            }
        }
    }
}

#Preview {
    SettingsView()
}
