//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Ye Htet Aung on 26/09/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var players: [Player] = [
        Player(name: "Elisha", score: 0),
        Player(name: "Andre", score: 0),
        Player(name: "Jasmine", score: 0),
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Score Keeper")
                .font(.title)
                .bold()
                .padding(.bottom)
            Grid {
                GridRow {
                    Text("Name")
                        .gridColumnAlignment(.leading)
                    Text("Score")
                }
                .font(.headline)

                ForEach($players) { $player in
                    GridRow {
                        TextField("Name", text: $player.name)
                        Stepper("\(player.score)", value: $player.score)
                            .labelsHidden()
                    }
                }
            }
            .padding(.vertical)

            Button("Add Player", systemImage: "plus") {
                players.append(Player(name: "Ye Htet Aung", score: 9))
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
