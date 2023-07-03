//
//  LeaguesInfoTeam.swift
//  Sportly
//
//  Created by MN on 16.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesInfoTeam
struct LeaguesInfoTeam: Codable, Hashable {
    var id: Int?
    var name: String?
    var logo: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case logo = "logo"
    }
}
