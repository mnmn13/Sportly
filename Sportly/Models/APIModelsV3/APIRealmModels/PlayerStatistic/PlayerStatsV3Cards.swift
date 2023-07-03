//
//  PlayerStatsV3Cards.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - PlayerStatsV3Cards
struct PlayerStatsV3Cards: Codable, Hashable {
    var yellow: Int?
    var yellowred: Int?
    var red: Int?

    enum CodingKeys: String, CodingKey {
        case yellow = "yellow"
        case yellowred = "yellowred"
        case red = "red"
    }
}
