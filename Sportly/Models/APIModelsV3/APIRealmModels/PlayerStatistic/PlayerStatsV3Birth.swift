//
//  PlayerStatsV3Birth.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - PlayerStatsV3Birth
struct PlayerStatsV3Birth: Codable, Hashable {
    var date: String?
    var place: String?
    var country: String

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case place = "place"
        case country = "country"
    }
}
