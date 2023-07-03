//
//  LeaguesFixtureV3Team.swift
//  Sportly
//
//  Created by MN on 28.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct LeaguesFixtureV3Team: HashCoded {
    let id: Int
    let name: String
    let logo: String
    let winner: Bool?
}
