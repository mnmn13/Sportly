//
//  DetailedLatestResultsCellVM.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct DetailedLatestResultsCellVM {
    
    var onReloadl: EmptyClosure?
    var leaguesFixtures: [LeaguesFixtureV3Response]
    private var items: [DetailedLatestResultsCellVMItem] = []
    
    init(leaguesFixtures: [LeaguesFixtureV3Response]) {
        self.leaguesFixtures = leaguesFixtures
        validateData()
    }
    
    // MARK: - Validate and convert data
    mutating private func validateData() {
        guard !leaguesFixtures.isEmpty, leaguesFixtures.count > 1 else { return }
        guard leaguesFixtures.count % 2 == 0 else { leaguesFixtures.removeLast(); return validateData() }
        
        for i in stride(from: 0, to: leaguesFixtures.count, by: 2) {
            let first = leaguesFixtures[i]
            let second = leaguesFixtures[i + 1]
            addItem([first, second])
        }
        onReloadl?()
    }
    
    // MARK: - Create and configure items
    mutating private func addItem(_ fixtures: [LeaguesFixtureV3Response]) {
        let item: DetailedLatestResultsCellVMItem = .unitedContentCells(DetailedLatestResultsCVCellVM(leagueFixtures: fixtures))
        items.append(item)
    }
    
    // MARK: - CollectionView methods
    func getNumberIfItems() -> Int { items.count }
    
    func getItem(_ indexPath: IndexPath) -> DetailedLatestResultsCellVMItem? {
        guard items.indices.contains(indexPath.item) else { return nil }
        return items[indexPath.item]
    }
    
}

// MARK: - Cell items
enum DetailedLatestResultsCellVMItem: Hashable {
    case unitedContentCells(DetailedLatestResultsCVCellVM)
}

// MARK: - Hashable
extension DetailedLatestResultsCellVM: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(leaguesFixtures)
        hasher.combine(items)
    }
    
    static func == (lhs: DetailedLatestResultsCellVM, rhs: DetailedLatestResultsCellVM) -> Bool {
        return lhs.leaguesFixtures == rhs.leaguesFixtures &&
        lhs.items == rhs.items
    }
}

