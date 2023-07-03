//
//  PlayerStatsV3Substitutes.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - PlayerStatsV3Substitutes
struct PlayerStatsV3Substitutes: Codable, Hashable {
    var substitutesIn: Int?
    var out: Int?
    var bench: Int?

    enum CodingKeys: String, CodingKey {
        case substitutesIn = "in"
        case out = "out"
        case bench = "bench"
    }
}
