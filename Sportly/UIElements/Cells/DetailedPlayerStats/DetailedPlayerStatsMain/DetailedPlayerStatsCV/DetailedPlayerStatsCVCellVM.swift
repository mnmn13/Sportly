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
    let playerNumber: Int = 17
    let playerScore: Int?
    let playerName: String
}

extension DetailedPlayerStatsCVCellVM: Hashable {}
