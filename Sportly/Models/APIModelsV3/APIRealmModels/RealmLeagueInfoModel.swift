//
//  RealmLeagueInfoModel.swift
//  Sportly
//
//  Created by MN on 05.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import RealmSwift

class RealmLeagueInfoModel: Object {
    @Persisted(primaryKey: true) var timeStamp: String
    @Persisted var league: RealmLeagueInfoLeague?
    @Persisted var country: RealmLeaguesInfoCountry?
    @Persisted var seasons: List<RealmLeaguesInfoSeason>
    
    convenience init(leguesInfoModel: LeaguesInfoResponse) {
        self.init()
        timeStamp = Time().getTimeStampString()
        league = RealmLeagueInfoLeague(leaguesInfoLeague: leguesInfoModel.league)
        country = RealmLeaguesInfoCountry(leaguesInfoCountry: leguesInfoModel.country!)
        seasons.append(objectsIn: leguesInfoModel.seasons!.map { RealmLeaguesInfoSeason(leaguesInfoSeason: $0) })
    }
}

class RealmLeagueInfoLeague: Object {
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var type: String
    @Persisted var logo: String
    
    convenience init(leaguesInfoLeague: LeaguesInfoLeague) {
        self.init()
        id = leaguesInfoLeague.id
        name = leaguesInfoLeague.name
        type = leaguesInfoLeague.type!
        logo = leaguesInfoLeague.logo
    }
}

class RealmLeaguesInfoCountry: Object {
    @Persisted var name: String
    @Persisted var code: String?
    @Persisted var flag: String?
    
    convenience init(leaguesInfoCountry: LeaguesInfoCountry) {
        self.init()
        name = leaguesInfoCountry.name
        code = leaguesInfoCountry.code
        flag = leaguesInfoCountry.flag
    }
}

class RealmLeaguesInfoSeason: Object {
    @Persisted var year: Int
    @Persisted var start: String
    @Persisted var end: String
    @Persisted var current: Bool
    @Persisted var coverage: RealmLeaguesInfoCoverage?
    
    convenience init(leaguesInfoSeason: LeaguesInfoSeason) {
        self.init()
        year = leaguesInfoSeason.year
        start = leaguesInfoSeason.start
        end = leaguesInfoSeason.end
        current = leaguesInfoSeason.current
        coverage = RealmLeaguesInfoCoverage(leaguesInfoCoverage: leaguesInfoSeason.coverage)
    }
}

class RealmLeaguesInfoCoverage: Object {
    @Persisted var fixtures: RealmLeaguesInfoFixtures?
    @Persisted var standings: Bool
    @Persisted var players: Bool
    @Persisted var topScorers: Bool
    @Persisted var topAssists: Bool
    @Persisted var topCards: Bool
    @Persisted var injuries: Bool
    @Persisted var predictions: Bool
    @Persisted var odds: Bool
    
    convenience init(leaguesInfoCoverage: LeaguesInfoCoverage) {
        self.init()
        if let fxt = leaguesInfoCoverage.fixtures {
            fixtures = RealmLeaguesInfoFixtures(leaguesInfoFixtures: fxt)
        }
//        fixtures = RealmLeaguesInfoFixtures(leaguesInfoFixtures: leaguesInfoCoverage.fixtures)
        standings = leaguesInfoCoverage.standings
        players = leaguesInfoCoverage.players
        topScorers = leaguesInfoCoverage.topScorers
        topAssists = leaguesInfoCoverage.topAssists
        topCards = leaguesInfoCoverage.topCards
        injuries = leaguesInfoCoverage.injuries
        predictions = leaguesInfoCoverage.predictions
        odds = leaguesInfoCoverage.odds
    }
}

class RealmLeaguesInfoFixtures: Object {
    @Persisted var events: Bool
    @Persisted var lineups: Bool
    @Persisted var statisticsFixtures: Bool
    @Persisted var statisticsPlayers: Bool
    
    convenience init(leaguesInfoFixtures: LeaguesInfoFixtures) {
        self.init()
        events = leaguesInfoFixtures.events
        lineups = leaguesInfoFixtures.lineups
        statisticsFixtures = leaguesInfoFixtures.statisticsFixtures
        statisticsPlayers = leaguesInfoFixtures.statisticsPlayers
    }
}
