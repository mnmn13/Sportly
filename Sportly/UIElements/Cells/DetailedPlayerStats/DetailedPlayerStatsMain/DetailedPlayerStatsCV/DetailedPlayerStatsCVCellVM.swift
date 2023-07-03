//
//  DetailedPlayerStatsCVCellVM.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct DetailedPlayerStatsCVCellVM {
    
    let image: String
    let playerNumber: Int
    let playerScore: Int?
    
}

extension DetailedPlayerStatsCVCellVM: Hashable {}
