//
//  DetailedPlayerStatsTitleCellVM.swift
//  Sportly
//
//  Created by MN on 30.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

class DetailedPlayerStatsTitleCellVM {
    
    var gameTypeCallBack: SimpleClosure<StatsTypeImage>?
    let statsType: StatsTypeImage
    
    init(gameTypeCallBack: SimpleClosure<StatsTypeImage>?, statsType: StatsTypeImage) {
        self.gameTypeCallBack = gameTypeCallBack
        self.statsType = statsType
    }
    
    // MARK: - TapGesture action
    func gestureTapped() {
        gameTypeCallBack?(statsType)
    }
}

// MARK: - StatsType
enum StatsTypeImage {
    case goals
    case assists
    case goalsAndAssists
}

extension DetailedPlayerStatsTitleCellVM: Hashable {
    static func == (lhs: DetailedPlayerStatsTitleCellVM, rhs: DetailedPlayerStatsTitleCellVM) -> Bool {
        lhs.statsType == rhs.statsType
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(statsType)
    }
}
