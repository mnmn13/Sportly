//
//  PlayerStatsV3Tackles.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - PlayerStatsV3Tackles
struct PlayerStatsV3Tackles: Codable, Hashable {
    var total: Int?
    var blocks: Int?
    var interceptions: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case blocks = "blocks"
        case interceptions = "interceptions"
    }
}
