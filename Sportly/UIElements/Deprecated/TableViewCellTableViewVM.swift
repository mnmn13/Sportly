//
//  TableViewCellTableViewVM.swift
//  Sportly
//
//  Created by MN on 14.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

struct TableViewCellTableViewVM {
    
    var onReload: EmptyClosure?
    
    fileprivate let callBackService: CallbackService
    
    var cellType: TableViewCellType
    
    private var items: [TableViewCellTableViewType] = []
    
    init(callBackService: CallbackService, cellType: TableViewCellType) {
        self.callBackService = callBackService
        self.cellType = cellType
        setupItems()
    }
    
    mutating private func setupItems() {
        
        switch cellType {
        case .leagueStatsOverviewCell(let leaguesInfoResponse):
            
            items = [
                .imageLogoChevron(CellForTableViewCellVM(callBackService: callBackService, logo: leaguesInfoResponse.league.logo, leagueTitle: leaguesInfoResponse.league.name)),
                .imageLogoChevron(CellForTableViewCellVM(callBackService: callBackService, logo: leaguesInfoResponse.league.logo, leagueTitle: leaguesInfoResponse.league.name))
            ]
            break
        case .leaguesStatsDetailedLatestResultsCell(let leaguesInfoResponse):
            break
        case .leaguesStatsDetailedTableCell(let leaguesInfoResponse):
            break
        }
    }
    
    //MARK: - TableView
    func getNumberOfItems() -> Int { items.count }
    
    func getItems(indexPath: IndexPath) -> TableViewCellTableViewType? {
        guard items.indices.contains(indexPath.item) else { return nil }
        return items[indexPath.item]
    }
}

enum TableViewCellTableViewType: Equatable {
    case imageLogoChevron(CellForTableViewCellVM)
    
    
    static func ==(lhs: TableViewCellTableViewType, rhs: TableViewCellTableViewType) -> Bool {
        switch (lhs, rhs) {
        case let (.imageLogoChevron(vm1), .imageLogoChevron(vm2)):
            return vm1 == vm2
        }
    }
}

enum TableViewCellType: Equatable {
    case leagueStatsOverviewCell(LeaguesInfoResponse)
    case leaguesStatsDetailedLatestResultsCell(LeaguesInfoResponse)
    case leaguesStatsDetailedTableCell(LeaguesInfoResponse)
    
    static func ==(lhs: TableViewCellType, rhs: TableViewCellType) -> Bool {
        switch (lhs, rhs) {
        case let (.leagueStatsOverviewCell(info1), .leagueStatsOverviewCell(info2)):
            return info1 == info2
        case let (.leaguesStatsDetailedLatestResultsCell(info1), .leaguesStatsDetailedLatestResultsCell(info2)):
            return info1 == info2
        case let (.leaguesStatsDetailedTableCell(info1), .leaguesStatsDetailedTableCell(info2)):
            return info1 == info2
        default:
            return false
        }
    }
}

extension TableViewCellTableViewVM: Equatable {
    static func ==(lhs: TableViewCellTableViewVM, rhs: TableViewCellTableViewVM) -> Bool {
        return lhs.cellType == rhs.cellType && lhs.items == rhs.items
    }
}
