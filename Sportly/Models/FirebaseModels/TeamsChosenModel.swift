//
//  TeamsChosenModel.swift
//  Sportly
//
//  Created by MN on 07.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct TeamsChosenModel: HashCoded {
    var teamsID: [Int]?
    
    func isEmpty() -> Bool {
        var result: Bool = false
        if let teamsID = teamsID {
            if teamsID.isEmpty {
                result = false
            } else {
                result = true
            }
        }
        return result
    }
}
