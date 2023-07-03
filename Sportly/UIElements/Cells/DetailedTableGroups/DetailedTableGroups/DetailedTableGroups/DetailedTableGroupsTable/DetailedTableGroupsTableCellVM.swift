//
//  DetailedTableGroupsTableCellVM.swift
//  Sportly
//
//  Created by MN on 24.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct DetailedTableGroupsTableCellVM {
    
    let teamStansing: LeaguesInfoStanding
    
    lazy var group: String = {
        teamStansing.group ?? ""
    }()
}

// MARK: - Hashable
extension DetailedTableGroupsTableCellVM: Hashable {}
