//
//  PlayerStatsV3Player.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct PlayerStatsV3Player: Codable, Hashable {
    var id: Int
    var name: String
    var firstname: String
    var lastname: String
    var age: Int?
    var birth: PlayerStatsV3Birth
    var nationality: String
    var height: String?
    var weight: String?
    var injured: Bool
    var photo: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case firstname = "firstname"
        case lastname = "lastname"
        case age = "age"
        case birth = "birth"
        case nationality = "nationality"
        case height = "height"
        case weight = "weight"
        case injured = "injured"
        case photo = "photo"
    }
}
