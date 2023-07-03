//
//  PlayerStatsV3Statistic.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - PlayerStatsV3Statistic
struct PlayerStatsV3Statistic: Codable, Hashable {
    var team: PlayerStatsV3Team
    var league: PlayerStatsV3League
    var games: PlayerStatsV3Games
    var substitutes: PlayerStatsV3Substitutes
    var shots: PlayerStatsV3Shots
    var goals: PlayerStatsV3Goals
    var passes: PlayerStatsV3Passes
    var tackles: PlayerStatsV3Tackles
    var duels: PlayerStatsV3Duels
    var dribbles: PlayerStatsV3Dribbles
    var fouls: PlayerStatsV3Fouls
    var cards: PlayerStatsV3Cards
    var penalty: PlayerStatsV3Penalty

    enum CodingKeys: String, CodingKey {
        case team = "team"
        case league = "league"
        case games = "games"
        case substitutes = "substitutes"
        case shots = "shots"
        case goals = "goals"
        case passes = "passes"
        case tackles = "tackles"
        case duels = "duels"
        case dribbles = "dribbles"
        case fouls = "fouls"
        case cards = "cards"
        case penalty = "penalty"
    }
}
