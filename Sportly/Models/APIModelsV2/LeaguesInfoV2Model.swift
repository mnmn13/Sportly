//
//  LeaguesInfoV2Model.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesInfoV2Model
struct LeaguesInfoV2Model: Codable, Hashable {
    var api: LeaguesInfoV2API

    enum CodingKeys: String, CodingKey {
        case api = "api"
    }
}
