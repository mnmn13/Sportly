//
//  LeaguesInfoPaging.swift
//  Sportly
//
//  Created by MN on 16.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesInfoPaging
struct LeaguesInfoPaging: Codable, Hashable {
    var current: Int
    var total: Int

    enum CodingKeys: String, CodingKey {
        case current = "current"
        case total = "total"
    }
}
