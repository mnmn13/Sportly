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
    var onReload: SimpleClosure<Changes>? { get set }
    var cellsOnScreen: SimpleClosure<Int>? { get set }
    var skeletonSwitch: SimpleClosure<Bool>? { get set }
    
    func loadData() async
    
    //TableView
    
    func getItemsCount() -> Int
    func getItem(indexPath: IndexPath) -> StatisticItem?
    
    func validateTappedCell(_ index: IndexPath)
//    func loadNextData(prefetchRowsAt indexPaths: [IndexPath])
}

class StatsViewModel: StatsViewModelType {
    
    var onReload: SimpleClosure<Changes>?
    var cellsOnScreen: SimpleClosure<Int>?
    var skeletonSwitch: SimpleClosure<Bool>?
    
    fileprivate let coordinator: StatsCoordinatorType
    private let masterService: MasterService
    private let callBackService: CallbackService
    private var items: [StatisticItem] = []
//    private var leaguesCounter: Int = 5
    private var leaguesStandings: [LeaguesInfoResponse] = []
    private var firstReloadFlag: Bool = true
    private let firstLeaguesToShow: [Int] = [1, 2, 39, 78, 140, 135, 61, 88, 741, 3, 40, 203, 179, 79, 41, 253, 235, 8, 94, 218]//, 119]
    private var leagueLimit: Int = 5
    private var onScreen: Set<Int> = []
    
    init(coordinator: StatsCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        self.masterService = serviceHolder.get()
        callBackService = serviceHolder.get()
    }
    
    func loadData() async {
        await requestForData()
        updateScreen()
    }
    
    private func requestForData() async {
        let newData = Array(firstLeaguesToShow.filter({ !onScreen.contains($0) }).prefix(leagueLimit))
        if !newData.isEmpty {
            if let standings = try? await masterService.getLeaguesStandings(season: 2022, leagues: newData) {
                leaguesStandings.append(contentsOf: standings)
            }
        } else {
            let newLeagues = generateLeaguesID()
            if let standings = try? await masterService.getLeaguesStandings(season: 2022, leagues: newLeagues) {
                leaguesStandings.append(contentsOf: standings)
            }
        }
    }
    
    func loadMore() async {
        
    }
    
    private func generateLeaguesID() -> [Int] {
        var newNumbers: [Int] = []
        var number = 1
        while newNumbers.count < leagueLimit {
            if !onScreen.contains(number) {
                newNumbers.append(number)
            }
            number += 1
        }
        return newNumbers
    }
    
    private func setupItems() {
        startHeaderBlock()
        startListBlock()
    }
    
    
    // Setup block items
    private func startHeaderBlock() {
        items = [.text(TextTVCellVM(text: "Statistics", cellType: .title)), .spacing(10) ]
    }
    
    private func startListBlock() {
        guard !leaguesStandings.isEmpty else { return }
        appendNewItems(leaguesStandings)
    }
    
    // Add new items
    private func appendNewItems(_ items: [LeaguesInfoResponse]) {
        for item in items {
            appendNewItem(item)
            onScreen.insert(item.league.id)
        }
    }
    
    private func appendNewItem(_ item: LeaguesInfoResponse) {
        if !firstReloadFlag { appendSpacing() } else { firstReloadFlag = false }
        let newItem: StatisticItem = .TVCell(LeagueOverviewTVCellVM(leagueModel: item) { [weak self] league in
            guard let self = self else { return }
            self.openDetailedStatictic(with: league)
        })
        items.append(newItem)
    }
    
    // Add spacing
    private func appendSpacing() {
        let spacingItem: StatisticItem = .spacing(20)
        items.append(spacingItem)
    }
    
    // MARK: - Update screen
    private func updateScreen() {
        let old = items
        items.removeAll()
        setupItems()
        onReload?(.init(new: items, old: old))
    }
    
    // Loading data with pagination

    
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

enum StatisticItem: Hashable, Equatable {
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

//enum StaticticReload {
//    case allTV
//    case rows(at: [IndexPath])
//}
