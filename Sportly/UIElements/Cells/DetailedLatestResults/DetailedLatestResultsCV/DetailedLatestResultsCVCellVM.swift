//
//  DetailedLatestResultsCVCellVM.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct DetailedLatestResultsCVCellVM {
    
    var onReload: EmptyClosure?
    let leagueFixtures: [LeaguesFixtureV3Response]
    private var items: [DetailedLatestResultsCVCellVMItem] = []
    
    init(leagueFixtures: [LeaguesFixtureV3Response]) {
        self.leagueFixtures = leagueFixtures
        validateData()
    }
    
    // MARK: - Validate and convert data
    mutating private func validateData() {
        guard leagueFixtures.count == 2 else { print("Fixtures.count must be 2"); return }
        
        for fixture in leagueFixtures {
            addItem(fixture)
        }
        onReload?()
    }
    
    // MARK: - Create and configure items
    mutating private func addItem(_ fixture: LeaguesFixtureV3Response) {
        let item: DetailedLatestResultsCVCellVMItem = .twoContentCells(DetailedLatestResultsTVCellVM(leagueFixture: fixture))
        items.append(item)
    }
    
    // MARK: - TableView methods
    func getItemsCount() -> Int { items.count }
    
    func getItem(indexPath: IndexPath) -> DetailedLatestResultsCVCellVMItem? {
        guard items.indices.contains(indexPath.item) else { return nil }
        return items[indexPath.item]
    }
}

// MARK: - Cell items
enum DetailedLatestResultsCVCellVMItem: Hashable {
    case twoContentCells(DetailedLatestResultsTVCellVM)
}

extension DetailedLatestResultsCVCellVM: Hashable {
    // MARK: - Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(leagueFixtures)
        hasher.combine(items)
    }
    
    static func == (lhs: DetailedLatestResultsCVCellVM, rhs: DetailedLatestResultsCVCellVM) -> Bool {
        return lhs.leagueFixtures == rhs.leagueFixtures &&
        lhs.items == rhs.items
    }
}
