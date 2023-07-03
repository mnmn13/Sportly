//
//  LeaguesFixtureV3Goals.swift
//  Sportly
//
//  Created by MN on 28.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesFixtureV3Goals
struct LeaguesFixtureV3Goals: Codable, Hashable {
    var home: Int?
    var away: Int?

    enum CodingKeys: String, CodingKey {
        case home = "home"
        case away = "away"
    }
}
