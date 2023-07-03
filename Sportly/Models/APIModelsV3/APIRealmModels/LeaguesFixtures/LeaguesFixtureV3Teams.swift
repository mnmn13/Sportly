//
//  LeaguesFixtureV3Teams.swift
//  Sportly
//
//  Created by MN on 28.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct LeaguesFixtureV3Teams: HashCoded {
    let home: LeaguesFixtureV3Team
    let away: LeaguesFixtureV3Team
    
    enum CodingKeys: String, CodingKey {
        case home = "home"
        case away = "away"
    }
}
