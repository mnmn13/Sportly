//
//  LeaguesFixtureV3Fixture.swift
//  Sportly
//
//  Created by MN on 28.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesFixtureV3Fixture
struct LeaguesFixtureV3Fixture: Codable, Hashable {
    var id: Int
    var referee: String
    var timezone: String
    var date: String
    var timestamp: Int
    var periods: LeaguesFixtureV3Periods
    var venue: LeaguesFixtureV3Venue
    var status: LeaguesFixtureV3Status

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case referee = "referee"
        case timezone = "timezone"
        case date = "date"
        case timestamp = "timestamp"
        case periods = "periods"
        case venue = "venue"
        case status = "status"
    }
}
