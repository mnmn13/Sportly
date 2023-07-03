//
//  LeagueBubbleModel.swift
//  Sportly
//
//  Created by MN on 13.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct LeagueBubbleModel {
    
    var key: String
    var value: LeaguesInfoResponse
    var isOnScreen: Bool
    
    init(value: LeaguesInfoResponse) {
        self.key = value.league.name
        self.value = value
        self.isOnScreen = false
    }
}
