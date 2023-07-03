//
//  LeaguesInfoParameters.swift
//  Sportly
//
//  Created by MN on 16.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesInfoParameters
struct LeaguesInfoParameters: Codable, Hashable {
    var current: String?
    var season: String?
    var last: String?
    var league: String?

    enum CodingKeys: String, CodingKey {
        case current = "current"
        case last = "last"
        case season = "season"
        case league = "league"
    }
}
