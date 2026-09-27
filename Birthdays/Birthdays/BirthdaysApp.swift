//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by Ye Htet Aung on 27/09/2026.
//

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}
