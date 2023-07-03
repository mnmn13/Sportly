//
//  LeaguesFixtureV3Periods.swift
//  Sportly
//
//  Created by MN on 28.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesFixtureV3Periods
struct LeaguesFixtureV3Periods: Codable, Hashable {
    var first: Int
    var second: Int

    enum CodingKeys: String, CodingKey {
        case first = "first"
        case second = "second"
    }
}
