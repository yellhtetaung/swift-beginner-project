//
//  GratefulMomentsApp.swift
//  GratefulMoments
//
//  Created by Ye Htet Aung on 28/09/2026.
//

import SwiftData
import SwiftUI

@main
struct GratefulMomentsApp: App {
    let dataContainer = DataContainer()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataContainer)
        }
        .modelContainer(dataContainer.modelContainer)
    }
}
