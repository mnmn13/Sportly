//
//  RequestModel.swift
//  Sportly
//
//  Created by MN on 04.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

//struct RequestModel {
//
//    let sdfasdf = GameType.footBall
//
//    func getHeaders(_ gameType: GameType) -> HTTPHeaders {
//        switch gameType {
//        case .footBall:
//            var header = HTTPHeaders()
//            let apiKey = HTTPHeader(name: "X-RapidAPI-Key", value: "b3e5361a2bmsh0ff9217838689aap10ea2ejsn106d6d9cdbb4")
//            let apiHost = HTTPHeader(name: "X-RapidAPI-Host", value: "api-football-v1.p.rapidapi.com")
//            header.add(apiKey)
//            header.add(apiHost)
//            return header
//        case .basketball:
//            var header = HTTPHeaders()
//            let apiKey = HTTPHeader(name: "X-RapidAPI-Key", value: "b3e5361a2bmsh0ff9217838689aap10ea2ejsn106d6d9cdbb4")
//            let apiHost = HTTPHeader(name: "X-RapidAPI-Host", value: "api-football-v1.p.rapidapi.com")
//            header.add(apiKey)
//            header.add(apiHost)
//            return header
//        case .baseball:
//            var header = HTTPHeaders()
//            let apiKey = HTTPHeader(name: "X-RapidAPI-Key", value: "b3e5361a2bmsh0ff9217838689aap10ea2ejsn106d6d9cdbb4")
//            let apiHost = HTTPHeader(name: "X-RapidAPI-Host", value: "api-football-v1.p.rapidapi.com")
//            header.add(apiKey)
//            header.add(apiHost)
//            return header
//        case .volleyball:
//            var header = HTTPHeaders()
//            let apiKey = HTTPHeader(name: "X-RapidAPI-Key", value: "b3e5361a2bmsh0ff9217838689aap10ea2ejsn106d6d9cdbb4")
//            let apiHost = HTTPHeader(name: "X-RapidAPI-Host", value: "api-football-v1.p.rapidapi.com")
//            header.add(apiKey)
//            header.add(apiHost)
//            return header
//        case .NBA:
//            var header = HTTPHeaders()
//            let apiKey = HTTPHeader(name: "X-RapidAPI-Key", value: "b3e5361a2bmsh0ff9217838689aap10ea2ejsn106d6d9cdbb4")
//            let apiHost = HTTPHeader(name: "X-RapidAPI-Host", value: "api-football-v1.p.rapidapi.com")
//            header.add(apiKey)
//            header.add(apiHost)
//            return header
//        case .rugby:
//            var header = HTTPHeaders()
//            let apiKey = HTTPHeader(name: "X-RapidAPI-Key", value: "b3e5361a2bmsh0ff9217838689aap10ea2ejsn106d6d9cdbb4")
//            let apiHost = HTTPHeader(name: "X-RapidAPI-Host", value: "api-football-v1.p.rapidapi.com")
//            header.add(apiKey)
//            header.add(apiHost)
//            return header
//        case .hockey:
//            var header = HTTPHeaders()
//            let apiKey = HTTPHeader(name: "X-RapidAPI-Key", value: "b3e5361a2bmsh0ff9217838689aap10ea2ejsn106d6d9cdbb4")
//            let apiHost = HTTPHeader(name: "X-RapidAPI-Host", value: "api-football-v1.p.rapidapi.com")
//            header.add(apiKey)
//            header.add(apiHost)
//            return header
//        }
//    }
//
//    func getRequestType() {}
//
//    enum Header {
//        case footBall
//        case basketball
//        case baseball
//        case volleyball
//        case NBA
//        case rugby
//        case hockey
//    }
//
//    enum GameType {
//        case footBall
//        case basketball
//        case baseball
//        case volleyball
//        case NBA
//        case rugby
//        case hockey
//    }
//}
//
//enum GameType: HashCoded {
//    case footBall(FootballRequest)
////    case basketball
////    case baseball
////    case volleyball
////    case NBA
////    case rugby
////    case hockey
//}
//
//enum FootballRequest: HashCoded {
//    case leaguesByLast(responseCount: Int)
//    case teamsInformationByLeague(league: Int, season: Int)
//
//    var header: HTTPHeaders {
//        var header = HTTPHeaders()
//        let apiKey = HTTPHeader(name: "X-RapidAPI-Key", value: "b3e5361a2bmsh0ff9217838689aap10ea2ejsn106d6d9cdbb4")
//        let apiHost = HTTPHeader(name: "X-RapidAPI-Host", value: "api-football-v1.p.rapidapi.com")
//        header.add(apiKey)
//        header.add(apiHost)
//        return header
//    }
//
//    var requestString: String {
//        let baseAPI = "https://api-football-v1.p.rapidapi.com/v3/"
//        switch self {
//        case .leaguesByLast(let count):
//            return baseAPI + "leagues?current=true&last=\(count)"
//        case .teamsInformationByLeague(let league, let season): return baseAPI + "teams?league=\(league)&season=\(season)"
//        }
//    }
//
//    var responseModel: Decodable.Type {
//        switch self {
//        case .leaguesByLast(_): return LeaguesInfoModel.self
//        case .teamsInformationByLeague(_, _): return AnyDecodable.self
//        }
//    }
//
//    var realmModel: Object.Type {
//        switch self {
//        case .leaguesByLast:
//            return RealmLeagueInfoModel.self
//        case .teamsInformationByLeague:
//            return RealmLeagueInfoModel.self
//        }
//    }
//}

//enum BasketballRequest {
//    case test
//
//    var requestString: String
//}




// leagues?current=true&last=
