//
//  LeaguesInfoSeason.swift
//  Sportly
//
//  Created by MN on 16.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesInfoSeason
struct LeaguesInfoSeason: Codable, Hashable {
    var year: Int
    var start: String
    var end: String
    var current: Bool
    var coverage: LeaguesInfoCoverage

    enum CodingKeys: String, CodingKey {
        case year = "year"
        case start = "start"
        case end = "end"
        case current = "current"
        case coverage = "coverage"
    }
}

extension LeaguesInfoSeason {
    init(realmObject: RealmLeaguesInfoSeason) {
        year = realmObject.year
        start = realmObject.start
        end = realmObject.end
        current = realmObject.current
        coverage = LeaguesInfoCoverage(realmObject: realmObject.coverage)
    }
}
