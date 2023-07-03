//
//  DetailedLatestResultsTVCellVM.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct DetailedLatestResultsTVCellVM {
    
    var onReload: EmptyClosure?
    
    let leagueFixture: LeaguesFixtureV3Response
    private var items: [DetailedLatestResultsTVCellVMItem] = []
    
    private var awayTeamLead: Bool = false
    private var homeTeamLead: Bool = false
    
    init(leagueFixture: LeaguesFixtureV3Response) {
        self.leagueFixture = leagueFixture
        validateTeamLead()
    }
    
    // MARK: - Validate and setup items
    mutating private func validateTeamLead() {
//        if leagueFixture.goalsAwayTeam > leagueFixture.goalsHomeTeam {
//            awayTeamLead = true
//        } else if leagueFixture.goalsHomeTeam > leagueFixture.goalsAwayTeam {
//            homeTeamLead = true
//        } else if leagueFixture.goalsHomeTeam == leagueFixture.goalsAwayTeam {}
//
        if let home = leagueFixture.teams.home.winner {
            homeTeamLead = home
        }
        if let away = leagueFixture.teams.away.winner {
            awayTeamLead = away
        }
        
        setupItems()
    }
    
    // MARK: - Setup items
    mutating private func setupItems() {
        items = [
            .spacing(20),
            .logoNameScore(DetailedLatestresultsContentCellVM(teamLogo: leagueFixture.teams.away.logo, teamName: leagueFixture.teams.away.name, teamScore: leagueFixture.goals.away, isTeamLead: awayTeamLead)),
            .spacing(15),
            .logoNameScore(DetailedLatestresultsContentCellVM(teamLogo: leagueFixture.teams.home.logo, teamName: leagueFixture.teams.home.name, teamScore: leagueFixture.goals.home, isTeamLead: homeTeamLead)),
            .spacing(20)
        ]
        onReload?()
    }
    
    // MARK: - TableView methods
    func getItemsCount() -> Int { items.count }
    
    func getItem(indexPath: IndexPath) -> DetailedLatestResultsTVCellVMItem? {
        guard items.indices.contains(indexPath.item) else { return nil }
        return items[indexPath.item]
    }
}

// MARK: - Cell items
enum DetailedLatestResultsTVCellVMItem: Hashable {
    case logoNameScore(DetailedLatestresultsContentCellVM)
    case spacing(CGFloat)
}

// MARK: - Hashable
extension DetailedLatestResultsTVCellVM : Hashable {
    // MARK: - Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(leagueFixture)
        hasher.combine(items)
    }
    
    static func == (lhs: DetailedLatestResultsTVCellVM, rhs: DetailedLatestResultsTVCellVM) -> Bool {
        return lhs.leagueFixture == rhs.leagueFixture &&
        lhs.items == rhs.items
    }
}
