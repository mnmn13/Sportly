//
//  LeaguesInfoLeague.swift
//  Sportly
//
//  Created by MN on 16.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesInfoLeague
struct LeaguesInfoLeague: Codable, Hashable {
    var id: Int
    var name: String
    var type: String? //LeaguesInfoType
    var logo: String
    var flag: String?
    var season: Int?
    var country: String?
    var standings: [[LeaguesInfoStanding]]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case logo = "logo"
        case flag = "flag"
        case season = "season"
        case country = "country"
        case standings = "standings"
    }
}

extension LeaguesInfoLeague {
    init(realmObject: RealmLeagueInfoLeague?) {
        guard let realmObject = realmObject else { id = 0; name = ""; type = ""; logo = ""; return }
        id = realmObject.id
        name = realmObject.name
        type = realmObject.type
        logo = realmObject.logo
    }
}
