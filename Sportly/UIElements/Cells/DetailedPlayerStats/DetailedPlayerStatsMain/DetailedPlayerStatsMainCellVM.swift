//
//  DetailedPlayerStatsMainCellVM.swift
//  Sportly
//
//  Created by MN on 30.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

class DetailedPlayerStatsMainCellVM {
    
    var onReload: SimpleClosure<Changes>?
    
    private var playerStats: [PlayerStatsV3Response]
    private let cellType: DetailedPlayerStatsMainCellVMType
    private var goalsPlayers: [PlayerStatsV3Response] = []
    private var assistsPlayers: [PlayerStatsV3Response] = []
    private var goalsAndAssists: [PlayerStatsV3Response] = []
    
    private var items: [DetailedPlayerStatsMainCellVMItem] = []
    
    init(playerStats: [PlayerStatsV3Response], cellType: DetailedPlayerStatsMainCellVMType) {
        self.playerStats = playerStats
        self.cellType = cellType
        convetData()
        setupInitialItems()
    }
    
    func convetData() {
        switch cellType {
        case .goals:
            let players = playerStats.filter({ $0.statistics.first?.goals.total != nil })
            let goalPlayers = players.filter({ ($0.statistics.first?.goals.total)! > 0 })
            goalsPlayers.append(contentsOf: goalPlayers)
        case .assists:
            let players = playerStats.filter({ $0.statistics.first?.goals.assists != nil })
            let assistPlayers = players.filter({ ($0.statistics.first?.goals.assists)! > 0 })
            assistsPlayers.append(contentsOf: assistPlayers)
        case .goalsAndAssists:
            break
        }
    }
    
    private func startGoalsBlock() {
        guard !goalsPlayers.isEmpty else { return }
        var goalItems: [DetailedPlayerStatsMainCellVMItem] = []
//        let filteredPlayers = goalsPlayers.sorted { player1, player2 in
//            let goals1 = player1.statistics.first?.goals.total ?? 0
//            let goals2 = player2.statistics.first?.goals.total ?? 0
//            return goals1 > goals2
//        }
        
        let filteredPlayers = goalsPlayers.sorted(by: { ($0.statistics.first?.goals.total ?? 0) > ($1.statistics.first?.goals.total ?? 0) })
        
        for filteredPlayer in filteredPlayers {
            let item: DetailedPlayerStatsMainCellVMItem = .playerCard(DetailedPlayerStatsCVCellVM(image: filteredPlayer.player.photo, playerScore: filteredPlayer.statistics.first?.goals.total ?? 0, playerName: filteredPlayer.player.name))
            goalItems.append(item)
        }
        items.append(contentsOf: goalItems)
    }
    
    private func startAssistsBlock() {
        guard !assistsPlayers.isEmpty else { return }
        var assistsItems: [DetailedPlayerStatsMainCellVMItem] = []
        let filteredPlayers = assistsPlayers.sorted(by: { ($0.statistics.first?.goals.assists ?? 0) > ($1.statistics.first?.goals.assists ?? 0) })
        for filteredPlayer in filteredPlayers {
            let item: DetailedPlayerStatsMainCellVMItem = .playerCard(DetailedPlayerStatsCVCellVM(image: filteredPlayer.player.photo, playerScore: filteredPlayer.statistics.first?.goals.total ?? 0, playerName: filteredPlayer.player.name))
            assistsItems.append(item)
        }
        items.append(contentsOf: assistsItems)
    }
    
    private func setupInitialItems() {
        items.removeAll()
        startGoalsBlock()
        startAssistsBlock()
    }
    
    private func updateScreen() {
        let old = items
        setupInitialItems()
        onReload?(.init(new: items, old: old))
    }
    
    // MARK: - CollectionView methods
    func numberOfItems() -> Int { items.count }
    
    func getItem(indexPath: IndexPath) -> DetailedPlayerStatsMainCellVMItem? {
        guard items.indices.contains(indexPath.item) else { return nil }
        return items[indexPath.item]
    }
}

enum DetailedPlayerStatsMainCellVMItem: Hashable {
    case playerCard(DetailedPlayerStatsCVCellVM)
}

enum DetailedPlayerStatsMainCellVMType: Hashable {
    case goals
    case assists
    case goalsAndAssists
}

extension DetailedPlayerStatsMainCellVM: Hashable {
    static func == (lhs: DetailedPlayerStatsMainCellVM, rhs: DetailedPlayerStatsMainCellVM) -> Bool {
        lhs.playerStats == rhs.playerStats && lhs.cellType == rhs.cellType
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(playerStats)
        hasher.combine(cellType)
    }
    
}
