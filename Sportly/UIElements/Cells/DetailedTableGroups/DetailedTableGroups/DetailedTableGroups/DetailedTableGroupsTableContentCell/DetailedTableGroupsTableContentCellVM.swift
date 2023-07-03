//
//  DetailedTableGroupsTableContentCellVM.swift
//  Sportly
//
//  Created by MN on 25.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct DetailedTableGroupsTableContentCellVM {
    
    let teamStandings: LeaguesInfoStanding
    
    lazy var rank: Int = {
        teamStandings.rank ?? 0
    }()
    
    lazy var teamName: String = {
        teamStandings.team?.name ?? ""
    }()
    
    lazy var teamLogo: String = {
        teamStandings.team?.logo ?? ""
    }()
    
    lazy var pamesPlayed: Int = {
        teamStandings.all?.played ?? 0
    }()
    
    lazy var wins: Int = {
        teamStandings.all?.win ?? 0
    }()
    
    lazy var draws: Int = {
        teamStandings.all?.draw ?? 0
    }()
    
    lazy var losses: Int = {
        teamStandings.all?.lose ?? 0
    }()
    
    lazy var points: Int = {
        teamStandings.points ?? 0
    }()
}

// MARK: - Hashable
extension DetailedTableGroupsTableContentCellVM: Hashable {}
