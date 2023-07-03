//
//  LeaguesFixtureV3Score.swift
//  Sportly
//
//  Created by MN on 28.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct LeaguesFixtureV3Score: Codable, Hashable {
    let halftime: LeaguesFixtureV3Goals?
    let fulltime: LeaguesFixtureV3Goals?
    let extratime: LeaguesFixtureV3Goals?
    let penalty: LeaguesFixtureV3Goals?
}
