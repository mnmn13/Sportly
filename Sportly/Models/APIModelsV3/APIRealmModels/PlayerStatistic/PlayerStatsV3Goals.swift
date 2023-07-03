//
//  PlayerStatsV3Goals.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - PlayerStatsV3Goals
struct PlayerStatsV3Goals: Codable, Hashable {
    var total: Int?
    var conceded: Int?
    var assists: Int?
    var saves: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case conceded = "conceded"
        case assists = "assists"
        case saves = "saves"
    }
}
