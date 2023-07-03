//
//  LeaguesFixtureV3Paging.swift
//  Sportly
//
//  Created by MN on 28.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesFixtureV3Paging
struct LeaguesFixtureV3Paging: Codable, Hashable {
    var current: Int
    var total: Int

    enum CodingKeys: String, CodingKey {
        case current = "current"
        case total = "total"
    }
}
