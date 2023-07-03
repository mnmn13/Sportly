//
//  LeaguesInfoCoverage.swift
//  Sportly
//
//  Created by MN on 16.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesInfoCoverage
struct LeaguesInfoCoverage: Codable, Hashable {
    var fixtures: LeaguesInfoFixtures?
    var standings: Bool
    var players: Bool
    var topScorers: Bool
    var topAssists: Bool
    var topCards: Bool
    var injuries: Bool
    var predictions: Bool
    var odds: Bool

    enum CodingKeys: String, CodingKey {
        case fixtures = "fixtures"
        case standings = "standings"
        case players = "players"
        case topScorers = "top_scorers"
        case topAssists = "top_assists"
        case topCards = "top_cards"
        case injuries = "injuries"
        case predictions = "predictions"
        case odds = "odds"
    }
}

extension LeaguesInfoCoverage {
    init(realmObject: RealmLeaguesInfoCoverage?) {
        guard let realmObject = realmObject else {fixtures = nil; standings = false; players = false; topScorers = false; topAssists = false; topCards = false; injuries = false; predictions = false; odds = false; return }
        fixtures = LeaguesInfoFixtures(realmObject: realmObject.fixtures)
        standings = realmObject.standings
        players = realmObject.players
        topScorers = realmObject.topScorers
        topAssists = realmObject.topAssists
        topCards = realmObject.topCards
        injuries = realmObject.injuries
        predictions = realmObject.predictions
        odds = realmObject.odds
    }
}
