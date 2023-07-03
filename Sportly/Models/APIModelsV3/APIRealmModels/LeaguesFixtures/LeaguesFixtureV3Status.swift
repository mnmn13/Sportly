//
//  LeaguesFixtureV3Status.swift
//  Sportly
//
//  Created by MN on 28.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesFixtureV3Status
struct LeaguesFixtureV3Status: Codable, Hashable {
    var long: String
    var short: String
    var elapsed: Int

    enum CodingKeys: String, CodingKey {
        case long = "long"
        case short = "short"
        case elapsed = "elapsed"
    }
}
