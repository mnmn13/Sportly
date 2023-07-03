//
//  PlayerStatsV3Parameters.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - PlayerStatsV3Parameters
struct PlayerStatsV3Parameters: Codable, Hashable {
    var league: String
    var season: String

    enum CodingKeys: String, CodingKey {
        case league = "league"
        case season = "season"
    }
}
