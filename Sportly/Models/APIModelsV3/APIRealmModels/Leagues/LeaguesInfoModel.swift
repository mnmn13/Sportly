//
//  LeaguesInfoModel.swift
//  Sportly
//
//  Created by MN on 16.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - LeaguesInfoModel
struct LeaguesInfoModel: Codable, Hashable {
    var modelGet: String
    var parameters: LeaguesInfoParameters
    var errors: [AnyDecodable]
    var results: Int
    var paging: LeaguesInfoPaging
    var response: [LeaguesInfoResponse]

    enum CodingKeys: String, CodingKey {
        case modelGet = "get"
        case parameters = "parameters"
        case errors = "errors"
        case results = "results"
        case paging = "paging"
        case response = "response"
    }
}
