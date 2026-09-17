//
//  Task.swift
//  TaskTracker
//
//  Created by Ye Htet Aung on 15/09/2026.
//

import Foundation
import SwiftData

@Model
class Task {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    
    init(title: String, isCompleted: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
    }
}
