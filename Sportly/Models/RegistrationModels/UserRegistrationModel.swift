//
//  UserRegistrationModel.swift
//  Sportly
//
//  Created by MN on 31.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct UserRegistration: HashCoded {
    
    var userName: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var password: String?
    var confirmPassword: String?
    
    var favouriteGameType: GamesChosenModel?
    var favouriteLeagues: [Int]?
    var favouriteTeams: [Int]?
}
