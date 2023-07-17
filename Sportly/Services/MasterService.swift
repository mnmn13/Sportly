//
//  MasterService.swift
//  Sportly
//
//  Created by MN on 11.05.2023.
//

import Foundation

class MasterService: Service {
    fileprivate let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    //MARK: - Services
    private var userService = UserService()
    private var storageService = StorageService()
    //MARK: - Properties
    private var networkConnection: Bool = false
    
    var leagues: [LeaguesInfoResponse]? {
        didSet {
            guard let leagues = leagues else { return }
            leaguesCallback?(leagues)
        }
    }
    
    var leaguesStandings: [LeaguesInfoResponse]? {
        didSet {
            guard let leaguesStandings = leaguesStandings else { return }
            leaguesStandingsCallback?(leaguesStandings)
        }
    }
    
    var teams: [TeamInfoResponse] = []
    var allTeams: [TeamInfoResponse] = [] // Used if the user has not selected any league
    
    //MARK: - Callback
    var requestCallback: SimpleClosure<Decodable>?
    var leaguesCallback: SimpleClosure<[LeaguesInfoResponse]>?
    var leaguesStandingsCallback: SimpleClosure<[LeaguesInfoResponse]>?
    
    private var networkManager = NetworkManager.shared
    
    init() {
        bindForNetworkReachability()
        print(url)
    }
    
    private func bindForNetworkReachability() {
        NetworkManager.shared.isInternetReachable = { [weak self] bool in
            guard let self = self else { return }
            self.networkConnection = bool
        }
    }
    
    @available(*, deprecated, message: "Refactor required")
    func requestLeagueStandings(league: Int, season: Int, completion: @escaping SimpleClosure<LeaguesInfoResponse>) {
//        networkManager.requestLeagueStandings(league: league, season: season) { [weak self] response in
//            guard let self = self else { return }
//            guard let response = response.first else { return }
//            completion(response)
//        }
        networkManager.loadModelFromJson() { response in
            completion(response)
        }
    }
    
    @available(*, deprecated, message: "Refactor required")
    func requestForTeamsByLeague(league: Int, season: Int) {
        networkManager.requestTeamsByLeague(league: league, season: season) { [weak self] teams in
            guard let self = self else { return }
            self.teams.append(contentsOf: teams)
        }
    }
    
    // MARK: - REFACTORED
    
    // MARK: - League standings
    func getLeagueStandings(season: Int, league: Int) async throws -> LeaguesInfoResponse {
        if networkConnection {
            return try await networkManager.requestLeagueStandings(season: season, league: league)
        } else {
            throw ErrorGenesis.storageError(.notAvailable)
        }
    }
    
    func getLeaguesStandings(season: Int, leagues: [Int]) async throws -> [LeaguesInfoResponse] {
        if networkConnection {
            return try await networkManager.requestLeaguesStandings(leagues: leagues, season: season)
        } else {
            throw ErrorGenesis.storageError(.notAvailable)
        }
    }
    
    // MARK: - League fixtures
    func getLeagueFixtures(season: String, league: Int, last: Int = 8) async throws -> [LeaguesFixtureV3Response] {
        if networkConnection {
            return try await networkManager.requestFixtures(season: season, league: league, last: last)
        } else {
            throw ErrorGenesis.storageError(.notAvailable)
        }
    }
    
    // MARK: - Player stats
    func getPlayerStats(season: Int, league: Int) async throws -> [PlayerStatsV3Response] {
        if networkConnection {
            return try await networkManager.requestPlayerStats(season: season, league: league)
        } else {
            throw ErrorGenesis.storageError(.notAvailable)
        }
    }
    
    // MARK: - Teams
    func getTeams(league: Int, season: Int) async throws -> [TeamInfoResponse] {
        if networkConnection {
            return try await networkManager.requestTeamsByLeague(league: league, season: season)
        } else {
            throw ErrorGenesis.storageError(.notAvailable)
        }
    }
    
    // MARK: - Leagues
    func getLeagues() async throws -> [LeaguesInfoResponse] {
        if networkConnection {
            return try await networkManager.requestLeagues()
        } else {
            throw ErrorGenesis.storageError(.notAvailable)
        }
    }
}
