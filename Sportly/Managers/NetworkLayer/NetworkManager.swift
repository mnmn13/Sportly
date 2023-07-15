//
//  NetworkManager.swift
//  Sportly
//
//  Created by MN on 11.05.2023.
//

import Foundation
import Alamofire

class NetworkManager: Request {
    
    static let shared = NetworkManager()
    private override init() {
        super.init()
//        testRequest()
    }
    
    private let testMode: Bool = true
    
    private let jsonManager = JSONManager.shared
    
    //MARK: - NetworkReachabilityManager
    private let manager = NetworkReachabilityManager(host: "www.apple.com")
    var isInternetReachable: SimpleClosure<Bool>?
    
    func startMonitoring() {
        manager?.startListening(onQueue: DispatchQueue.main, onUpdatePerforming: { [weak self] (status) in
            guard let self = self else { return }
            switch status {
            case .notReachable:
                print("network connection status - lost")
                self.isInternetReachable?(false)
            case .reachable(.ethernetOrWiFi):
                print("network connection status - ethernet/WiFI")
                self.isInternetReachable?(true)
            case .reachable(.cellular):
                print("network connection status - cellular")
                self.isInternetReachable?(true)
            default:
                self.isInternetReachable?(false)
                break
            }
        })
    }
    
    // MARK: - All leagues
    @available(*, deprecated, message: "Refactor required")
    func requestLeagues(completion: @escaping SimpleClosure<[LeaguesInfoResponse]>) {
        
        request(endpoint: .getLeagues) { data in
            do {
                let model = try JSONDecoder().decode(LeaguesInfoModel.self, from: data)
                completion(model.response)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Teams by league
    @available(*, deprecated, message: "Refactor required")
    func requestTeamsByLeague(league: Int, season: Int, completion: @escaping SimpleClosure<[TeamInfoResponse]>) {
        
        request(endpoint: .getTeamsForLeague(league: league, season: season)) { data in
            do {
                let model = try JSONDecoder().decode(TeamInfoModel.self, from: data)
                completion(model.response)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - League standings
    func requestLeagueStandings(season: Int, league: Int) async throws -> LeaguesInfoResponse {
        if testMode {
            return try await jsonManager.loadLeagueStandingsFromJson()
        } else {
            let data = try await request(endpoint: .stanfingsByseasonAndLeague(season: season, league: league))
            guard let model = try JSONDecoder().decode(LeaguesInfoModel.self, from: data).response.first else { throw ErrorGenesis.basicError(.dataError) }
            return model
        }
    }
    
    // MARK: - Fixtures
    
    /// Returns firxture by season and leagueID
    func requestFixtures(season: String, league: Int, last: Int) async throws -> [LeaguesFixtureV3Response] {
        if testMode {
            return try await jsonManager.loadLeagueFixtureFronJson()
        } else {
            let data = try await request(endpoint: .fixturesBySeasonAndLeague(season: season, league: league, last: last))
            let model = try JSONDecoder().decode(LeaguesFixtureV3Model.self, from: data)
            return model.response
        }
    }
    
    // MARK: - Player stats block
    func requestPlayerStats(season: Int, league: Int) async throws -> [PlayerStatsV3Response] {
        if testMode {
            return try await jsonManager.loadPlayerStatsFromJson()
        } else {
            return try await requestAllPlayersStats(season: season, league: league)
        }
    }
    
    private func requestAllPlayersStats(season: Int, league: Int) async throws -> [PlayerStatsV3Response] {
        let firstStats = try await requestPlayerStatsModel(season: season, league: league)
        let allPages = firstStats.paging.total
        let delayInSeconds: TimeInterval = 60
        
        return try await withThrowingTaskGroup(of: [PlayerStatsV3Response].self, body: { group in
            var returnResponse: [PlayerStatsV3Response] = []
            
            for page in 2...allPages {
                if page % 25 == 0 || page % 25 == 1 || page % 25 == 2 {
                    Task {
                        BannerManager.shared.show(.warning, "Data will be loaded in just a minute")
                        await Task.sleep(UInt64(delayInSeconds * Double(NSEC_PER_SEC)))
                    }
                }
                group.addTask {
                    return try await self.requestPlayerStatsModel(season: season, league: league, page: page).response
                }
            }
            
            for try await response in group {
                returnResponse.append(contentsOf: response)
            }
            return returnResponse
        })
    }
    
    private func requestPlayerStatsModel(season: Int, league: Int, page: Int = 1) async throws -> PlayerStatsV3Model {
            let data = try await request(endpoint: .playersStatsByLeague(season: season, league: league, page: page))
            let model = try JSONDecoder().decode(PlayerStatsV3Model.self, from: data)
            return model
    }
    
    // MARK: - TestFunc
    private func testRequest() {}
    
    @available(*, deprecated, message: "Test function, uses exclusively for debug")
    func loadModelFromJson(completion: SimpleClosure<LeaguesInfoResponse>) {
        
        if let url = Bundle.main.url(forResource: "standingsV3", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(LeaguesInfoModel.self, from: data)
                guard let response = jsonData.response.first else { return }
                completion(response)
            } catch let error {
                print("error:\(error.localizedDescription)")
            }
        }
    }
    
    @available(*, deprecated, message: "Test function, uses exclusively for debug")
    func loadModelFromJson(completion: SimpleClosure<[LeaguesInfoV2Fixture]>) {
        
        if let url = Bundle.main.url(forResource: "fixturesV2", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(LeaguesInfoV2Model.self, from: data)
                completion(jsonData.api.fixtures)
            } catch let error {
                print("error:\(error.localizedDescription)")
            }
        }
    }
    
    @available(*, deprecated, message: "Test function, uses exclusively for debug")
    func loadModelFromJson3(completion: SimpleClosure<PlayerStatsV3Model>) {
        if let url = Bundle.main.url(forResource: "playerStatsV3allPages", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(PlayerStatsV3Model.self, from: data)
                completion(jsonData)
            } catch let error {
                print("error:\(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - TestFunc
    @available(*, deprecated, message: "Test function, uses exclusively for debug")
    private func loadModelFromJson(completion: SimpleClosure<[LeaguesFixtureV3Response]>) {
        if let url = Bundle.main.url(forResource: "fixturesV3", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(LeaguesFixtureV3Model.self, from: data)
                completion(jsonData.response)
            } catch let error {
                print("error:\(error.localizedDescription)")
            }
        }
    }
}

struct AnyDecodable: HashCoded {}
