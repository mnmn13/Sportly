//
//  UserModel.swift
//  Sportly
//
//  Created by MN on 28.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct UserModel: HashCoded {
    
    var firstEntry: Bool

    var favouriteGames: GamesChosenModel?
    var favouriteLeagues: LeaguesChosenModel?
    var favouriteTeams: TeamsChosenModel?
    
    var userInfo: UserInfo
//    var favouriteLeagues: [String]
//    var favouriteTeams: [String]
}


