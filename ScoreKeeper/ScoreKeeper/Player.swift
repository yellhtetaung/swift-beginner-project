//
//  Player.swift
//  ScoreKeeper
//
//  Created by Ye Htet Aung on 26/09/2026.
//

import Foundation

struct Player: Identifiable {
    let id = UUID()
    var name: String
    var score: Int
}
