//
//  StorageService.swift
//  Sportly
//
//  Created by MN on 06.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

class StorageService: Service {
    
    private let realm = RealmManager.shared
    
    func saveData(gameType: GameType, data: Decodable) {
    
        switch gameType {
        case .footBall(let footballRequest):
            
            switch footballRequest {
            case .leaguesByLast:
                guard let data = data as? [LeaguesInfoResponse] else { return }
                let wrappedModels = data.map { RealmLeagueInfoModel(leguesInfoModel: $0) }
                for model in wrappedModels {
                    realm.saveData(model)
                }
            case .teamsInformationByLeague:
                break
            }
        }
    }
    
    func getData(gameType: GameType) {
        
        switch gameType {
        case .footBall(let footballRequest):
            switch footballRequest {
            case .leaguesByLast:
                break
            case .teamsInformationByLeague:
                break
            }
        }
    }
    
    func saveLeagues(leagues: [LeaguesInfoResponse]) {
        let wrappedModels = leagues.map { RealmLeagueInfoModel(leguesInfoModel: $0) }
        for model in wrappedModels {
            realm.saveData(model)
        }
    }
    
}
