//
//  LeaguesFixtureV3Parameters.swift
//  Sportly
//
//  Created by MN on 28.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesFixtureV3Parameters
struct LeaguesFixtureV3Parameters: Codable, Hashable {
    var league: String
    var last: String
    var season: String

    enum CodingKeys: String, CodingKey {
        case league = "league"
        case last = "last"
        case season = "season"
    }
}
