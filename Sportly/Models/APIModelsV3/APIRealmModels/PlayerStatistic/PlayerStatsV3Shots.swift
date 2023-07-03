//
//  PlayerStatsV3Shots.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - PlayerStatsV3Shots
struct PlayerStatsV3Shots: Codable, Hashable {
    var total: Int?
    var on: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case on = "on"
    }
}
