//
//  DetailedTableGroupsMainCellVM.swift
//  Sportly
//
//  Created by MN on 24.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

class DetailedTableGroupsMainCellVM {
    
    // MARK: - CallBack's
    var onReload: EmptyClosure?
    
    // MARK: - Prorerties
    private let callbackService: CallbackService
    let leagueStandings: [LeaguesInfoStanding]
    private var items: [DetailedTableGroupsMainCellVMItem] = []
    
    init(callbackService: CallbackService, leagueStandings: [LeaguesInfoStanding]) {
        self.callbackService = callbackService
        self.leagueStandings = leagueStandings
    }
    
    // MARK: - Configure Items
    func configureInitialItems() {
        guard let firstStanding = leagueStandings.first else { return }
        let item: DetailedTableGroupsMainCellVMItem = .header(DetailedTableGroupsTableCellVM(teamStansing: firstStanding))
        items.append(item)
        configureOtherItems()
    }
    
    private func configureOtherItems() {
        for leagueStanding in leagueStandings {
            let item: DetailedTableGroupsMainCellVMItem = .content(DetailedTableGroupsTableContentCellVM(teamStandings: leagueStanding))
            items.append(item)
        }
        onReload?()
    }
    
    // MARK: - TableView methods
    func getItemsCount() -> Int { items.count }
    
    func getItem(indexPath: IndexPath) -> DetailedTableGroupsMainCellVMItem? {
        guard items.indices.contains(indexPath.item) else { return nil }
        return items[indexPath.item]
    }
}

enum DetailedTableGroupsMainCellVMItem: Hashable {
    case header(DetailedTableGroupsTableCellVM)
    case content(DetailedTableGroupsTableContentCellVM)
}

extension DetailedTableGroupsMainCellVM: Hashable {
    // MARK: - Hashable
    static func == (lhs: DetailedTableGroupsMainCellVM, rhs: DetailedTableGroupsMainCellVM) -> Bool {
        return lhs.leagueStandings == rhs.leagueStandings &&
        lhs.items == rhs.items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(leagueStandings)
        hasher.combine(items)
    }
}
