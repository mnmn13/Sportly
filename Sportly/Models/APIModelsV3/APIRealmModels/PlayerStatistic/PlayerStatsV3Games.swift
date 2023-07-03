//
//  PlayerStatsV3Games.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - PlayerStatsV3Games
struct PlayerStatsV3Games: Codable, Hashable {
    var appearences: Int?
    var lineups: Int?
    var minutes: Int?
    var number: Int?
    var position: String
    var rating: Int?
    var captain: Bool

    enum CodingKeys: String, CodingKey {
        case appearences = "appearences"
        case lineups = "lineups"
        case minutes = "minutes"
        case number = "number"
        case position = "position"
        case rating = "rating"
        case captain = "captain"
    }
}
