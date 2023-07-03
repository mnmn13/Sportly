//
//  LeaguesInfoV2Fixture.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesInfoV2Fixture
struct LeaguesInfoV2Fixture: Codable, Hashable {
    var fixtureID: Int
    var leagueID: Int
    var league: LeaguesInfoV2League
    var eventDate: String
    var eventTimestamp: Int
    var firstHalfStart: Int
    var secondHalfStart: Int
    var round: String
    var status: String
    var statusShort: String
    var elapsed: Int
    var venue: String
    var referee: AnyDecodable?
    var homeTeam: LeaguesInfoV2Team
    var awayTeam: LeaguesInfoV2Team
    var goalsHomeTeam: Int
    var goalsAwayTeam: Int
    var score: LeaguesInfoV2Score

    enum CodingKeys: String, CodingKey {
        case fixtureID = "fixture_id"
        case leagueID = "league_id"
        case league = "league"
        case eventDate = "event_date"
        case eventTimestamp = "event_timestamp"
        case firstHalfStart = "firstHalfStart"
        case secondHalfStart = "secondHalfStart"
        case round = "round"
        case status = "status"
        case statusShort = "statusShort"
        case elapsed = "elapsed"
        case venue = "venue"
        case referee = "referee"
        case homeTeam = "homeTeam"
        case awayTeam = "awayTeam"
        case goalsHomeTeam = "goalsHomeTeam"
        case goalsAwayTeam = "goalsAwayTeam"
        case score = "score"
    }
}
