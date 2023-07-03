//
//  TeamInfoModel.swift
//  Sportly
//
//  Created by MN on 05.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

// MARK: - TeamInfoModel
struct TeamInfoModel: HashCoded {
    var purpleGet: String
    var parameters: TeamInfoParameters
    var errors: [AnyDecodable]
    var results: Int
    var paging: TeamInfoPaging
    var response: [TeamInfoResponse]

    enum CodingKeys: String, CodingKey {
        case purpleGet = "get"
        case parameters = "parameters"
        case errors = "errors"
        case results = "results"
        case paging = "paging"
        case response = "response"
    }
}
// MARK: - TeamInfoPaging
struct TeamInfoPaging: HashCoded {
    var current: Int
    var total: Int

    enum CodingKeys: String, CodingKey {
        case current = "current"
        case total = "total"
    }
}
// MARK: - TeamInfoParameters
struct TeamInfoParameters: HashCoded {
    var league: String
    var season: String

    enum CodingKeys: String, CodingKey {
        case league = "league"
        case season = "season"
    }
}
// MARK: - TeamInfoResponse
struct TeamInfoResponse: HashCoded {
    var team: TeamInfoTeam
    var venue: TeamInfoVenue

    enum CodingKeys: String, CodingKey {
        case team = "team"
        case venue = "venue"
    }
}
// MARK: - TeamInfoTeam
struct TeamInfoTeam: HashCoded {
    var id: Int
    var name: String
    var code: String?
    var country: String?
    var founded: Int?
    var national: Bool
    var logo: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case code = "code"
        case country = "country"
        case founded = "founded"
        case national = "national"
        case logo = "logo"
    }
}
// MARK: - TeamInfoVenue
struct TeamInfoVenue: HashCoded {
    var id: Int?
    var name: String?
    var address: String?
    var city: String?
    var capacity: Int?
    var surface: String?
    var image: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case address = "address"
        case city = "city"
        case capacity = "capacity"
        case surface = "surface"
        case image = "image"
    }
}
