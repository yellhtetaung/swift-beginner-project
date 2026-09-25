//
//  ContentView.swift
//  PickAPal
//
//  Created by Ye Htet Aung on 26/09/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var names: [String] = []
    @State private var nameToAdd = ""
    @State private var pickedName = ""
    @State private var shouldRemovePickedName = false

    var body: some View {
        VStack {
            VStack(spacing: 8) {
                Image(systemName: "person.3.sequence.fill")
                    .foregroundStyle(.tint)
                    .symbolRenderingMode(.hierarchical)
                Text("Pick-a-Pal")
            }
            .font(.title)
            .bold()

            Text(pickedName.isEmpty ? " " : pickedName)
                .font(.title2)
                .bold()
                .foregroundStyle(.tint)

            List {
                ForEach(names, id: \.description) { name in
                    Text(name)
                }
                .onDelete { indexSet in
                    names.remove(atOffsets: indexSet)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))

            TextField("Add Name", text: $nameToAdd)
                .autocorrectionDisabled()
                .onSubmit {
                    let trimmed = nameToAdd.trimmingCharacters(in: .whitespaces)
                    guard !trimmed.isEmpty else { return }
                    names.append(nameToAdd)
                    nameToAdd = ""
                }

            Divider()

            Toggle("Remove when picked", isOn: $shouldRemovePickedName)

            Button {
                if let randomName = names.randomElement() {
                    pickedName = randomName

                    if shouldRemovePickedName {
                        names.removeAll { name in
                            name == randomName
                        }
                    }
                } else {
                    pickedName = ""
                }
            } label: {
                Text("Pick Random Name")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
