//
//  LeaguesInfoGoals.swift
//  Sportly
//
//  Created by MN on 16.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesInfoGoals
struct LeaguesInfoGoals: Codable, Hashable {
    var goalsFor: Int?
    var against: Int?

    enum CodingKeys: String, CodingKey {
        case goalsFor = "for"
        case against = "against"
    }
}
