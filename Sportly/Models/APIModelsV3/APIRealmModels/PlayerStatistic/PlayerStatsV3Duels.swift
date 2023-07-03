//
//  PlayerStatsV3Duels.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - PlayerStatsV3Duels
struct PlayerStatsV3Duels: Codable, Hashable {
    var total: Int?
    var won: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case won = "won"
    }
}
