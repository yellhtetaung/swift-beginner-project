//
//  EncoreApp.swift
//  Encore
//
//  Created by Ye Htet Aung on 15/09/2026.
//

import SwiftUI
import SwiftData

@main
struct EncoreApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(for: Show.self)
    }
}
