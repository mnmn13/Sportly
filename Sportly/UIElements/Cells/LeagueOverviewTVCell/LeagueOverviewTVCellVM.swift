//
//  LeagueOverviewTVCellVM.swift
//  Sportly
//
//  Created by MN on 19.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct LeagueOverviewTVCellVM {
    var onReload: SimpleClosure<Changes>?
    
    var leagueTapped: SimpleClosure<LeaguesInfoResponse>?
    
    var leagueModel: LeaguesInfoResponse
    
    private var firstRankLeague: LeaguesInfoStanding?
    private var secondRankLeague: LeaguesInfoStanding?
    private var thirdRankLeague: LeaguesInfoStanding?
    private var moreTeamsCount: Int?
    
    private var items: [LeagueOverviewItem] = []
    
    init(leagueModel: LeaguesInfoResponse, leagueTapped: SimpleClosure<LeaguesInfoResponse>?) {
        self.leagueModel = leagueModel
        self.leagueTapped = leagueTapped
//        setupItems()
//        convertData()
    }
    
    mutating func convertData() {
//        guard let firstRankLeague = leagueModel.league.standings.map({ $0.map({$0.filter({$0.rank == 1 && $0.group == "Group A"})}) })?.first?.first else { return }
//        guard let secondRankLeague = leagueModel.league.standings.map({ $0.map({$0.filter({$0.rank == 2 && $0.group == "Group A"})}) })?.first?.first else { return }
//        guard let thirdRankLeague = leagueModel.league.standings.map({ $0.map({$0.filter({$0.rank == 3 && $0.group == "Group A"})}) })?.first?.first else { return }
        
        guard let firstRankLeague = leagueModel.league.standings?.first?.filter({$0.rank == 1}).first else { return }
        guard let secondRankLeague = leagueModel.league.standings?.first?.filter({$0.rank == 2}).first else { return }
        guard let thirdRankLeague = leagueModel.league.standings?.first?.filter({$0.rank == 3}).first else { return }
        
        guard let allTeams = leagueModel.league.standings?.first.flatMap({$0}) else { return }
        moreTeamsCount = allTeams.count - 3
        
        self.firstRankLeague = firstRankLeague
        self.secondRankLeague = secondRankLeague
        self.thirdRankLeague = thirdRankLeague
        setupItems()
    }
    
    mutating private func setupItems() {
        items = [
            .logoAndTitle(LogoAndTitleTVCellVM(logo: leagueModel.league.logo, leagueTitle: leagueModel.league.name)),
            .logosAndLabel(LogosAndLabelVM(firstLogo: firstRankLeague?.team?.logo, secondLogo: secondRankLeague?.team?.logo, thirdLogo: thirdRankLeague?.team?.logo, moreRanks: moreTeamsCount))
        ]
    }
    
    // MARK: - UpdateScreen
    mutating func updateScreen() {
        let old = items
        convertData()
        onReload?(.init(new: items, old: old))
    }
    
    // MARK: - TalbeView methods
    
    func didTap() {
        leagueTapped?(leagueModel)
    }
    
    func getNumberOfItems() -> Int { items.count }
    
    func getItems(indexPath: IndexPath) -> LeagueOverviewItem? {
        guard items.indices.contains(indexPath.item) else { return nil }
        return items[indexPath.item]
    }
}

extension LeagueOverviewTVCellVM: Hashable {
    static func == (lhs: LeagueOverviewTVCellVM, rhs: LeagueOverviewTVCellVM) -> Bool {
        lhs.leagueModel == rhs.leagueModel && lhs.items == rhs.items
    }
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(leagueModel)
//           hasher.combine(firstRankLeague)
//           hasher.combine(secondRankLeague)
//           hasher.combine(thirdRankLeague)
//           hasher.combine(moreTeamsCount)
           hasher.combine(items)
       }
}


enum LeagueOverviewItem: Hashable {
    case logoAndTitle(LogoAndTitleTVCellVM)
    case logosAndLabel(LogosAndLabelVM)
}
