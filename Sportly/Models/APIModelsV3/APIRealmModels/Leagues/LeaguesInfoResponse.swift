//
//  LeaguesInfoResponse.swift
//  Sportly
//
//  Created by MN on 16.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesInfoResponse
struct LeaguesInfoResponse: Codable, Hashable {
    var league: LeaguesInfoLeague
    var country: LeaguesInfoCountry?
    var seasons: [LeaguesInfoSeason]?

    enum CodingKeys: String, CodingKey {
        case league = "league"
        case country = "country"
        case seasons = "seasons"
    }
}

extension LeaguesInfoResponse {
    init(realmObject: RealmLeagueInfoModel) {
        league = LeaguesInfoLeague(realmObject: realmObject.league)
        country = LeaguesInfoCountry(realmObject: realmObject.country)
        seasons = realmObject.seasons.map { LeaguesInfoSeason(realmObject: $0) }
    }
}
