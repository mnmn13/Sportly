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
    
    //MARK: - Football
    
    //Leagues
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
    
    func requestLeagueStandings(league: Int, season: Int, completion: @escaping SimpleClosure<[LeaguesInfoResponse]>) {
        request(endpoint: .stanfingsByseasonAndLeague(season: season, league: league)) { data in
            do {
                let model = try JSONDecoder().decode(LeaguesInfoModel.self, from: data)
                completion(model.response)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    /// 10 by default
    func reguestFixturesByLeagueID(id: Int, last: Int = 8, completion: @escaping SimpleClosure<[LeaguesInfoV2Fixture]>) {
        request(endpoint: .lastFixturesFromleagueID(id: id, last: last)) { data in
            do {
                let model = try JSONDecoder().decode(LeaguesInfoV2Model.self, from: data)
                completion(model.api.fixtures)
            } catch let error {
                print(error.localizedDescription)
            }
        }
//        loadModelFromJson(completion: completion)
    }
    
    func requestFixtureBySeasonAndLeague(season: String, league: Int, last: Int, completion: @escaping SimpleClosure<[LeaguesFixtureV3Response]>) {
//        request(endpoint: .fixturesBySeasonAndLeague(season: season, league: league, last: last)) { data in
//            do {
//                let model = try JSONDecoder().decode(LeaguesFixtureV3Model.self, from: data)
//                completion(model.response)
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }
        loadModelFromJson(completion: completion)
    }
    
    func requestPlayersStats(season: Int, league: Int, completion: @escaping SimpleClosure<[PlayerStatsV3Response]>) {
        request(endpoint: .playersStatsByLeague(season: 2022, league: 39)) { data in
            do {
                let model = try JSONDecoder().decode(PlayerStatsV3Model.self, from: data)
                completion(model.response)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        loadModelFromJson(completion: completion)
    }
    
    func requestPlayersStats(season: Int, league: Int, page: Int) async -> [PlayerStatsV3Response] {
        let data = await request(endpoint: .playersStatsByLeague(season: 2022, league: 39))
        do {
            let model = try JSONDecoder().decode(PlayerStatsV3Model.self, from: data)
            return model.response
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func requestPlayerStats(season: Int, league: Int, page: Int) async throws -> [PlayerStatsV3Response] {
        
    }
    
    func requesstTeamsForLeague() async -> [LeaguesInfoV2Fixture] {
        var fixturesToReturn: [LeaguesInfoV2Fixture] = []
         await loadModelFromJson { fixtures in
            fixturesToReturn = fixtures
        }
        return fixturesToReturn
    }
    
    // MARK: - TestFunc
    private func testRequest() {
        
    }
    
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
    func loadModelFromJson(completion: SimpleClosure<[PlayerStatsV3Response]>) {
        if let url = Bundle.main.url(forResource: "playerStatsV3", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(PlayerStatsV3Model.self, from: data)
                completion(jsonData.response)
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
