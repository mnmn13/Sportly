//
//  LeaguesInfoAll.swift
//  Sportly
//
//  Created by MN on 16.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesInfoAll
struct LeaguesInfoAll: Codable, Hashable {
    var played: Int?
    var win: Int?
    var draw: Int?
    var lose: Int?
    var goals: LeaguesInfoGoals?

    enum CodingKeys: String, CodingKey {
        case played = "played"
        case win = "win"
        case draw = "draw"
        case lose = "lose"
        case goals = "goals"
    }
}
