//
//  PlayerStatsV3Response.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - PlayerStatsV3Response
struct PlayerStatsV3Response: Codable, Hashable {
    var player: PlayerStatsV3Player
    var statistics: [PlayerStatsV3Statistic]

    enum CodingKeys: String, CodingKey {
        case player = "player"
        case statistics = "statistics"
    }
}
