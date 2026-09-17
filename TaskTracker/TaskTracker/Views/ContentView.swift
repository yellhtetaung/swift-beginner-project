//
//  ContentView.swift
//  TaskTracker
//
//  Created by Ye Htet Aung on 15/09/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var taskCount: Int = 0
    @Query private var tasks: [Task]
    @Environment(\.modelContext) private var context
    @State private var newTaskTitle: String = ""

    var body: some View {
        VStack {
            Text("Task Tracker")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom)

            HStack {
                TextField("Add Task", text: $newTaskTitle)
                    .textFieldStyle(.roundedBorder)

                Button("Add", action: addTask)
                    .buttonStyle(.borderedProminent)
                    .disabled(
                        newTaskTitle.trimmingCharacters(in: .whitespaces)
                            .isEmpty
                    )
            }

            List {
                ForEach(tasks) { task in
                    HStack {
                        Text(task.title)
                            .strikethrough(task.isCompleted)
                        Image(
                            systemName: task.isCompleted
                                ? "checkmark.seal.fill" : "circlebadge"
                        )
                    }
                    .onTapGesture {
                        toggleTask(task)
                    }
                }
                .onDelete(perform: deleteTask)
            }
        }
        .padding()
    }

    private func addTask() {
        var newTask = Task(title: newTaskTitle)
        context.insert(newTask)
        newTaskTitle = ""
    }

    private func toggleTask(_ task: Task) {
        task.isCompleted.toggle()
    }
    
    private func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            context.delete(tasks[index])
        }
    }
}

#Preview {
    ContentView()
}
