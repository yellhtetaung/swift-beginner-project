//
//  TaskTrackerApp.swift
//  TaskTracker
//
//  Created by Ye Htet Aung on 15/09/2026.
//

import SwiftData
import SwiftUI

@main
struct TaskTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Task.self, inMemory: true)
    }
}
