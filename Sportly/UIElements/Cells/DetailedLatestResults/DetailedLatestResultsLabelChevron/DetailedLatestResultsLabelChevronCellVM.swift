//
//  DetailedLatestResultsLabelChevronCellVM.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct DetailedLatestResultsLabelChevronCellVM {
    
    let roundLabel: String
    let upSideChevron: String = "chevron.up"
    let downSideChevron: String = "chevron.down"
    var cellTappedCallBack: SimpleClosure<Bool>?
    var chevronSideFlag: Bool = true
    var firstLoadFlag: Bool = false
    
    // MARK: - Cell tapped action
    mutating func cellTapped(_ selected: Bool) {
        chevronSideFlag = selected
        cellTappedCallBack?(chevronSideFlag)
    }
}

extension DetailedLatestResultsLabelChevronCellVM: Hashable {
    static func == (lhs: DetailedLatestResultsLabelChevronCellVM, rhs: DetailedLatestResultsLabelChevronCellVM) -> Bool {
        return lhs.roundLabel == rhs.roundLabel &&
        lhs.chevronSideFlag == rhs.chevronSideFlag &&
        lhs.firstLoadFlag == rhs.firstLoadFlag
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(roundLabel)
        hasher.combine(chevronSideFlag)
        hasher.combine(firstLoadFlag)
    }
}
