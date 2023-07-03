//
//  LeaguesInfoStanding.swift
//  Sportly
//
//  Created by MN on 16.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct LeaguesInfoStanding: Codable, Hashable {
    var rank: Int?
    var team: LeaguesInfoTeam?
    var points: Int?
    var goalsDiff: Int?
    var group: String?
    var form: String?
    var status: String?
    var description: String?
    var all: LeaguesInfoAll?
    var home: LeaguesInfoAll?
    var away: LeaguesInfoAll?
    var update: String?// Date?

    enum CodingKeys: String, CodingKey {
        case rank = "rank"
        case team = "team"
        case points = "points"
        case goalsDiff = "goalsDiff"
        case group = "group"
        case form = "form"
        case status = "status"
        case description = "description"
        case all = "all"
        case home = "home"
        case away = "away"
        case update = "update"
    }
}
