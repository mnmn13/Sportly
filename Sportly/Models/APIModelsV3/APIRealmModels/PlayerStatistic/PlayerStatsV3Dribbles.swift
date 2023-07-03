//
//  PlayerStatsV3Dribbles.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - PlayerStatsV3Dribbles
struct PlayerStatsV3Dribbles: Codable, Hashable {
    var attempts: Int?
    var success: Int?
    var past: Int?

    enum CodingKeys: String, CodingKey {
        case attempts = "attempts"
        case success = "success"
        case past = "past"
    }
}
