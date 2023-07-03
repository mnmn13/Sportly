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
    private var networkService = NetworkService()
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
//        requestFixturesByLeagueID(id: 39) { fixtures in
//            dump(fixtures)
//        }
    }
    
    private func bindForNetworkReachability() {
        NetworkManager.shared.isInternetReachable = { [weak self] bool in
            guard let self = self else { return }
            //            if UserDefaults.standard.isLoggedIn {
            self.networkConnection = bool
            //                self.networkConnection = false
            //MARK: - Start functions

//            self.requestForleagues(count: 1)
            
            //            }
        }
    }
    
    func requestForleagues() {
        networkManager.requestLeagues { [weak self] leagues in
            guard let self = self else { return }
            self.leagues = leagues
        }
    }
    
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
    
    func requestForLeagueStandings(season: String, league: Int, last: Int, completion: @escaping SimpleClosure<[LeaguesFixtureV3Response]>) {
//        networkManager.requestFixtureBySeasonAndLeague(season: season, league: league, last: last) { response in
//            completion(response)
//        }
        networkManager.requestFixtureBySeasonAndLeague(season: season, league: league, last: last) { response in
            completion(response)
        }
    }
    
    
    func requestForTeamsByLeague(league: Int, season: Int) {
        networkManager.requestTeamsByLeague(league: league, season: season) { [weak self] teams in
            guard let self = self else { return }
            self.teams.append(contentsOf: teams)
        }
    }
    
    func requestFixturesByLeagueID(id: Int, last: Int = 8, completion: @escaping SimpleClosure<[LeaguesInfoV2Fixture]>) {
        networkManager.reguestFixturesByLeagueID(id: id, last: last) { fixtures in
            completion(fixtures)
        }
    }
    
    func requestPlayerStats(season: Int, league: Int, completion: @escaping SimpleClosure<[PlayerStatsV3Response]>) {
        networkManager.requestPlayersStats(season: <#T##Int#>, league: <#T##Int#>) { statsResponse in
            completion(statsResponse)
        }
    }
}
