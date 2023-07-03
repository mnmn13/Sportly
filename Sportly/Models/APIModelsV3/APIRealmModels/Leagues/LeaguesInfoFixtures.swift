//
//  LeaguesInfoFixtures.swift
//  Sportly
//
//  Created by MN on 16.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesInfoFixtures
struct LeaguesInfoFixtures: Codable, Hashable {
    var events: Bool
    var lineups: Bool
    var statisticsFixtures: Bool
    var statisticsPlayers: Bool

    enum CodingKeys: String, CodingKey {
        case events = "events"
        case lineups = "lineups"
        case statisticsFixtures = "statistics_fixtures"
        case statisticsPlayers = "statistics_players"
    }
}

extension LeaguesInfoFixtures {
    init(realmObject: RealmLeaguesInfoFixtures?) {
        guard let realmObject = realmObject else { events = false; lineups = false; statisticsFixtures = false; statisticsPlayers = false; return }
        events = realmObject.events
        lineups = realmObject.lineups
        statisticsFixtures = realmObject.statisticsFixtures
        statisticsPlayers = realmObject.statisticsPlayers
    }
}
