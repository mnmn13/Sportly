//
//  LeaguesInfoV2Team.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesInfoV2Team
struct LeaguesInfoV2Team: Codable, Hashable {
    var teamID: Int
    var teamName: String
    var logo: String

    enum CodingKeys: String, CodingKey {
        case teamID = "team_id"
        case teamName = "team_name"
        case logo = "logo"
    }
}
