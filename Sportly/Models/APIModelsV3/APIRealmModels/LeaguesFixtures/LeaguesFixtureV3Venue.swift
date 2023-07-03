//
//  LeaguesFixtureV3Venue.swift
//  Sportly
//
//  Created by MN on 28.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesFixtureV3Venue
struct LeaguesFixtureV3Venue: Codable, Hashable {
    var id: Int
    var name: String
    var city: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case city = "city"
    }
}
