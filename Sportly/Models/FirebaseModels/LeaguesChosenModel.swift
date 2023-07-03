//
//  LeaguesChosenModel.swift
//  Sportly
//
//  Created by MN on 07.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct LeaguesChosenModel: HashCoded {
    var leaguesID: [Int]?
    
    func isEmpty() -> Bool {
        var result: Bool = false
        if let leaguesID = leaguesID {
            if leaguesID.isEmpty {
                result = false
            } else {
                result = true
            }
        }
        return result
    }
}
