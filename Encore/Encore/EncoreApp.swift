//
//  EncoreApp.swift
//  Encore
//
//  Created by Ye Htet Aung on 20/09/2026.
//

import SwiftUI
import SwiftData

@main
struct EncoreApp: App {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                MainTabView()
            } else {
                OnboardingView()
            }
        }
        .modelContainer(for: Show.self)
    }
}
