//
//  DetailedStatsHeaderCellVM.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct DetailedStatsHeaderCellVM {
    
    let leagueLogo: String?
    let leagueName: String?
    
}

// MARK: - Hashable, Equitable

extension DetailedStatsHeaderCellVM: Hashable {}
