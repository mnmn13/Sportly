//
//  TeamsBubbleModel.swift
//  Sportly
//
//  Created by MN on 13.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct TeamsBubbleModel {
    var key: String
    var value: TeamInfoResponse
    var isVisible: Bool = false
    
    init(value: TeamInfoResponse) {
        self.key = value.team.name
        self.value = value
    }
}
