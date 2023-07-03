//
//  PlayerStatsV3League.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - PlayerStatsV3League
struct PlayerStatsV3League: Codable, Hashable {
    var id: Int
    var name: String
    var country: String
    var logo: String
    var flag: String
    var season: Int

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case country = "country"
        case logo = "logo"
        case flag = "flag"
        case season = "season"
    }
}
