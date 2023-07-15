//
//  Request.swift
//  Sportly
//
//  Created by MN on 08.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import Alamofire

class Request {
    
    // MARK: - Test function
    ///Used only for testing internet requests
    func request(endpoint: FootballEndpoint, completion: @escaping SimpleClosure<Data>) {
        
        let request = AF.request(endpoint.url, method: endpoint.method, parameters: endpoint.parametrs, headers: endpoint.headers)
        
        request.response { response in
            if response.response?.statusCode == 200 {
                guard let data = response.data else { return }
                
                completion(data)
            } else {
                AlertHelper.showAlert(msg: "Internal error occurred")
            }
        }
    }
    
    //MARK: - Main request
    func request(endpoint: FootballEndpoint) async throws -> Data {
        let request = AF.request(endpoint.url, method: endpoint.method, parameters: endpoint.parametrs, headers: endpoint.headers)
        
        return try await withCheckedThrowingContinuation { continuation in
            request.response { response in
                if let statusCode = response.response?.statusCode, (200..<300).contains(statusCode) {
                    guard let data = response.data else {
                        continuation.resume(throwing: ErrorGenesis.basicError(.dataError))
                        return
                    }
                    continuation.resume(returning: data)
                } else {
                    response.handleResponseError()
                    let error = ErrorGenesis.networkError(.requestFailed)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

// MARK: - Endpoint
enum FootballEndpoint {
    
    case getLeagues
    case getTeamsForLeague(league: Int, season: Int)
    case leaguesById(leagueID: Int)
    case stanfingsByseasonAndLeague(season: Int, league: Int)
    case fixturesBySeasonAndLeague(season: String, league: Int, last: Int)
    case playersStatsByLeague(season: Int, league: Int, page: Int)
    
    var baseURL: String { return "https://api-football-v1.p.rapidapi.com/v3/" }
    
    var path: String {
        switch self {
//        case .getLeagues(let season, let count): return "leagues?season=\(season)&type=league&current=true&last=\(count)"
        case .getLeagues: return "leagues?current=true"
        case .getTeamsForLeague(let league, let season): return "teams?league=\(league)&season=\(season)"
        case .leaguesById(let leagueID): return "leagues?id=\(leagueID)"
        case .stanfingsByseasonAndLeague(let season, let league): return "standings?season=\(season)&league=\(league)"
        case .fixturesBySeasonAndLeague(let season, let league, let last): return "fixtures?league=\(league)&season=\(season)&last=\(last)"
        case .playersStatsByLeague(let season, let league, let page): return "players?league=\(league)&season=\(season)&page=\(page)"
        }
    }
    
    var method: Alamofire.HTTPMethod { .get }
    
    var parametrs: Parameters? { .none }
    
    var headers: HTTPHeaders {
            var header = HTTPHeaders()
        let apiKey = HTTPHeader(name: "X-RapidAPI-Key", value: PrivateKeys.APIFootballKey)
            let apiHost = HTTPHeader(name: "X-RapidAPI-Host", value: "api-football-v1.p.rapidapi.com")
            header.add(apiKey)
            header.add(apiHost)
            return header
    }
    
    var url: URL { URL(string: baseURL + path)! }
    
}

enum FootballEndpointV2 {
    case lastFixturesFromleagueID(id: Int, last: Int)
    
    var baseURL: String { "https://api-football-v1.p.rapidapi.com/v2/" }
    
    var path: String {
        switch self {
        case .lastFixturesFromleagueID(let id, let last): return "fixtures/league/\(id)/last/\(last)"
        }
    }
    
    var method: Alamofire.HTTPMethod { .get }
    
    var parameters: Parameters? { .none }
    
    var headers: HTTPHeaders {
        var header = HTTPHeaders()
        let apiKey = HTTPHeader(name: "X-RapidAPI-Key", value: PrivateKeys.APIFootballKeyV2)
        let apiHost = HTTPHeader(name: "X-RapidAPI-Host", value: "api-football-v1.p.rapidapi.com")
        header.add(apiKey)
        header.add(apiHost)
        return header
    }
    
    var url: URL { URL(string: baseURL + path)! }
}
