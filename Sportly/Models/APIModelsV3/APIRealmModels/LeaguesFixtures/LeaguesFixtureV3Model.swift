//
//  LeaguesFixtureV3Model.swift
//  Sportly
//
//  Created by MN on 28.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesFixtureV3Model
struct LeaguesFixtureV3Model: Codable, Hashable {
    var modelGet: String
    var parameters: LeaguesFixtureV3Parameters
    var errors: AnyDecodable?
    var results: Int
    var paging: LeaguesFixtureV3Paging
    var response: [LeaguesFixtureV3Response]

    enum CodingKeys: String, CodingKey {
        case modelGet = "get"
        case parameters = "parameters"
        case errors = "errors"
        case results = "results"
        case paging = "paging"
        case response = "response"
    }
}
