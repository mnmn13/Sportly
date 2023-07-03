//
//  LeaguesInfoV2League.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesInfoV2League
struct LeaguesInfoV2League: Codable, Hashable {
    var name: String
    var country: String
    var logo: String
    var flag: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case country = "country"
        case logo = "logo"
        case flag = "flag"
    }
}
