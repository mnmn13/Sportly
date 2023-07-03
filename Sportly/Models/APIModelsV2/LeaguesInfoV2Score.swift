//
//  LeaguesInfoV2Score.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesInfoV2Score
struct LeaguesInfoV2Score: Codable, Hashable {
    var halftime: String
    var fulltime: String
    var extratime: String?
    var penalty: String?

    enum CodingKeys: String, CodingKey {
        case halftime = "halftime"
        case fulltime = "fulltime"
        case extratime = "extratime"
        case penalty = "penalty"
    }
}
