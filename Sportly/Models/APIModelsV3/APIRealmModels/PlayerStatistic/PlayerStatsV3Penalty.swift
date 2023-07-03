//
//  PlayerStatsV3Penalty.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - PlayerStatsV3Penalty
struct PlayerStatsV3Penalty: Codable, Hashable {
    var won: Int?
    var commited: Int?
    var scored: Int?
    var missed: Int?
    var saved: Int?

    enum CodingKeys: String, CodingKey {
        case won = "won"
        case commited = "commited"
        case scored = "scored"
        case missed = "missed"
        case saved = "saved"
    }
}
