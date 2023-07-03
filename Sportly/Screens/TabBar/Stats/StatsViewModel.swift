//
//  StatsViewModel.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

protocol StatsViewModelType {
    
    //Bind
    var onReload: SimpleClosure<StaticticReload>? { get set }
    var cellsOnScreen: SimpleClosure<Int>? { get set }
    var skeletonSwitch: SimpleClosure<Bool>? { get set }
    
    //TableView
    
    func getItemsCount() -> Int
    func getItem(indexPath: IndexPath) -> StatisticItem?
    
    func validateTappedCell(_ index: IndexPath)
    func loadNextData(prefetchRowsAt indexPaths: [IndexPath])
}

class StatsViewModel: StatsViewModelType {
    
    var onReload: SimpleClosure<StaticticReload>?
    var cellsOnScreen: SimpleClosure<Int>?
    var skeletonSwitch: SimpleClosure<Bool>?
    
    fileprivate let coordinator: StatsCoordinatorType
    private let masterService: MasterService
    private let callBackService: CallbackService
    private var items: [StatisticItem] = []
    private var leaguesCounter: Int = 5
    private var leaguesStandings: [LeaguesInfoResponse] = []
    private var firstReloadFlag: Bool = true
    
    init(coordinator: StatsCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        self.masterService = serviceHolder.get()
        callBackService = serviceHolder.get()
        loadData()
    }
    
    private func loadData() {
        preSetupItems()
        guard masterService.leaguesStandings == nil else { return }
        for i in 1...leaguesCounter {
            masterService.requestLeagueStandings(league: i, season: 2022) { [weak self] league in
                guard let self = self else { return }
                self.leaguesStandings.append(league)
                self.appendNewItems(league)
//                self.appendNewItems(league)
//                self.appendNewItems(league)
//                self.appendNewItems(league)
//                self.appendNewItems(league)
//                self.appendNewItems(league)
//                self.appendNewItems(league)
//                self.appendNewItems(league)
            }
        }
        onReload?(.allTV)
    }
    
    // Setup initial items
    private func preSetupItems() {
        items = [.text(TextTVCellVM(text: "Statistics", cellType: .title)), .spacing(10) ]
    }
    
    // Add new items
    private func appendNewItems(_ item: LeaguesInfoResponse) {
        if !firstReloadFlag { appendSpacing() } else { firstReloadFlag = false }
        let newItem: StatisticItem = .TVCell(LeagueOverviewTVCellVM(leagueModel: item) { [weak self] league in
            guard let self = self else { return }
            self.openDetailedStatictic(with: league)
        })
        items.append(newItem)
        guard let index = items.firstIndex(where: { newItem == $0 } ) else { return }
        let indexPath = IndexPath(item: index, section: 0)
//        onReload?(.rows(at: [indexPath]))
    }
    
    // Add spacing
    private func appendSpacing() {
        let spacingItem: StatisticItem = .spacing(20)
        items.append(spacingItem)
        guard let index = items.firstIndex(where: { spacingItem == $0 } ) else { return }
        let indexPath = IndexPath(item: index, section: 0)
        onReload?(.rows(at: [indexPath]))
    }
    
    // Loading data with pagination
    func loadNextData(prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            leaguesCounter += 1
            masterService.requestLeagueStandings(league: leaguesCounter, season: 2023) { [weak self] response in
                guard let self = self else { return }
                
                let newItem: StatisticItem = .TVCell(LeagueOverviewTVCellVM(leagueModel: response) { league in
                    self.openDetailedStatictic(with: league)
                })
                for _ in 0...1 {
                    items.append(newItem)
                }
                onReload?(.rows(at: [indexPath]))
            }
        }
    }
    
    func validateTappedCell(_ index: IndexPath) {
        let item = items[index.item]
        switch item {
            
        case .text(_): break
        case .spacing(_): break
        case .TVCell(let leagueModel):
            openDetailedStatictic(with: leagueModel.leagueModel)
        }
    }
    
    // MARK: - Navigation
    func openDetailedStatictic(with leagueModel: LeaguesInfoResponse) {
        coordinator.openDetailedStats(with: leagueModel)
    }

    //MARK: - TableView methods
    
    func getItemsCount() -> Int { items.count }
    
    func getItem(indexPath: IndexPath) -> StatisticItem? {
        guard items.indices.contains(indexPath.item) else { return nil }
        return items[indexPath.item]
    }
}

enum StatisticItem: Equatable {
    case text(TextTVCellVM)
    case spacing(CGFloat)
    case TVCell(LeagueOverviewTVCellVM)
    
    static func ==(lhs: StatisticItem, rhs: StatisticItem) -> Bool {
        switch (lhs, rhs) {
        case let (.text(lhsText), .text(rhsText)):
            return lhsText == rhsText
        case let (.spacing(lhsSpacing), .spacing(rhsSpacing)):
            return lhsSpacing == rhsSpacing
        case let (.TVCell(lhsCell), .TVCell(rhsCell)):
            return lhsCell == rhsCell
        default:
            return false
        }
    }
}

enum StaticticReload {
    case allTV
    case rows(at: [IndexPath])
}
