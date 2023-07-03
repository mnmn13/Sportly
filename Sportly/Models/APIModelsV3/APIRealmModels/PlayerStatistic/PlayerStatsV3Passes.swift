//
//  PlayerStatsV3Passes.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - PlayerStatsV3Passes
struct PlayerStatsV3Passes: Codable, Hashable {
    var total: Int?
    var key: Int?
    var accuracy: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case key = "key"
        case accuracy = "accuracy"
    }
}
