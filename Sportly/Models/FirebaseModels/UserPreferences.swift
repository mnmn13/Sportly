//
//  UserPreferences.swift
//  Sportly
//
//  Created by MN on 13.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct FirebaseUserPreferences: HashCoded {
    var games: FirebaseUserPreferencesGames?
}

struct FirebaseUserPreferencesGames: HashCoded {
    var football: FirebaseUserPreferencesGamesFootball?
}

struct FirebaseUserPreferencesGamesFootball: HashCoded {
    var leagues: [Int]?
    var teams: [Int]?
}
