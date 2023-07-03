//
//  PlayerStatsV3Fouls.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - PlayerStatsV3Fouls
struct PlayerStatsV3Fouls: Codable, Hashable {
    var drawn: Int?
    var committed: Int?

    enum CodingKeys: String, CodingKey {
        case drawn = "drawn"
        case committed = "committed"
    }
}
