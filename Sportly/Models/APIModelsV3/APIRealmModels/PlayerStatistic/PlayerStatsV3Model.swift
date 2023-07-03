//
//  PlayerStatsV3Model.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - PlayerStatsV3Model
struct PlayerStatsV3Model: Codable, Hashable {
    var modelGet: String
    var parameters: PlayerStatsV3Parameters
    var errors: AnyDecodable?
    var results: Int
    var paging: PlayerStatsV3Paging
    var response: [PlayerStatsV3Response]

    enum CodingKeys: String, CodingKey {
        case modelGet = "get"
        case parameters = "parameters"
        case errors = "errors"
        case results = "results"
        case paging = "paging"
        case response = "response"
    }
}
