//
//  LeaguesInfoCountry.swift
//  Sportly
//
//  Created by MN on 16.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesInfoCountry
struct LeaguesInfoCountry: Codable, Hashable {
    var name: String
    var code: String?
    var flag: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case code = "code"
        case flag = "flag"
    }
}

extension LeaguesInfoCountry {
    init(realmObject: RealmLeaguesInfoCountry?) {
        guard let realmObject = realmObject else { name = ""; code = ""; flag = ""; return }
        name = realmObject.name
        code = realmObject.code
        flag = realmObject.flag
    }
}
