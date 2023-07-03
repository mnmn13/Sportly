//
//  LeaguesInfoV2API.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesInfoV2API
struct LeaguesInfoV2API: Codable, Hashable {
    var results: Int
    var fixtures: [LeaguesInfoV2Fixture]

    enum CodingKeys: String, CodingKey {
        case results = "results"
        case fixtures = "fixtures"
    }
}
