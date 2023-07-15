//
//  JSONManager.swift
//  Sportly
//
//  Created by MN on 09.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

class JSONManager: JSONBase {
    
    static let shared = JSONManager()
    
    private override init() {
        super.init()
    }
    
    // MARK: - Player stats
    func loadPlayerStatsFromJson() async throws -> [PlayerStatsV3Response] {
        guard let data = getDataFromJSON(.playerStatsV3All) else { return [] }
        let jsonData = try! JSONDecoder().decode(PlayerStatsV3Model.self, from: data)
        return jsonData.response
    }
    
    // MARK: - League fixture
    func loadLeagueFixtureFronJson() async throws -> [LeaguesFixtureV3Response] {
        guard let data = getDataFromJSON(.fixturesV3) else { throw ErrorGenesis.basicError(.dataError )}
        let jsonData = try! JSONDecoder().decode(LeaguesFixtureV3Model.self, from: data)
        return jsonData.response
    }
    
    // MARK: - League standings
    func loadLeagueStandingsFromJson() async throws -> LeaguesInfoResponse {
        guard let data = getDataFromJSON(.standingsV3) else { throw ErrorGenesis.basicError(.dataError) }
        let jsonData = try! JSONDecoder().decode(LeaguesInfoModel.self, from: data)
        guard let response = jsonData.response.first else { throw ErrorGenesis.basicError(.dataError) }
        return response
    }
}
