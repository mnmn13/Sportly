//
//  LeaguesFixtureV3Response.swift
//  Sportly
//
//  Created by MN on 28.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesFixtureV3Response
struct LeaguesFixtureV3Response: Codable, Hashable {
    var fixture: LeaguesFixtureV3Fixture
    var league: LeaguesFixtureV3League
    var teams: LeaguesFixtureV3Teams
    var goals: LeaguesFixtureV3Goals
    var score: LeaguesFixtureV3Score

    enum CodingKeys: String, CodingKey {
        case fixture = "fixture"
        case league = "league"
        case teams = "teams"
        case goals = "goals"
        case score = "score"
    }
}
