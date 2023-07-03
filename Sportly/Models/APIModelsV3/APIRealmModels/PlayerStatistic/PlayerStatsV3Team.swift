//
//  PlayerStatsV3Team.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - PlayerStatsV3Team
struct PlayerStatsV3Team: Codable, Hashable {
    var id: Int
    var name: String
    var logo: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case logo = "logo"
    }
}
