//
//  PlayerStatsV3Paging.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - PlayerStatsV3Paging
struct PlayerStatsV3Paging: Codable, Hashable {
    var current: Int
    var total: Int

    enum CodingKeys: String, CodingKey {
        case current = "current"
        case total = "total"
    }
}
