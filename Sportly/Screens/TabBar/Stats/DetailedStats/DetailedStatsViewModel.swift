//
//  DetailedStatsViewModel.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

protocol DetailedStatsViewModelType {
    //Bind
    var onReload: SimpleClosure<DetailedStatsReload>? { get set }
    var onReload2: SimpleClosure<Changes>? { get set }
    
    func loadData()
    //TableView
    func getItemsCount() -> Int
    func getItem(indexPath: IndexPath) -> DetailedStatsItem?
    func getSizeForTable(leagueStanding: [LeaguesInfoStanding]) -> CGFloat
}

class DetailedStatsViewModel: DetailedStatsViewModelType {
    
    var onReload: SimpleClosure<DetailedStatsReload>?
    var onReload2: SimpleClosure<Changes>?
    
    fileprivate let coordinator: StatsCoordinatorType
    private let masterService: MasterService
    private let callBackService: CallbackService
    private let leagueModel: LeaguesInfoResponse
//    private var leagueFixtures: [LeaguesInfoV2Fixture] = []
    private var leagueFixtures: [LeaguesFixtureV3Response] = []
    private var leagueStandings: [[LeaguesInfoStanding]] = []
    private var playersStats: [PlayerStatsV3Response] = []
    
    private var items: [DetailedStatsItem] = []
    
    init(coordinator: StatsCoordinatorType, serviceHolder: ServiceHolder, leagueModel: LeaguesInfoResponse) {
        self.coordinator = coordinator
        self.masterService = serviceHolder.get()
        self.callBackService = serviceHolder.get()
        self.leagueModel = leagueModel
    }
    
    func loadData() {
        masterService.requestForLeagueStandings(season: leagueModel.league.season ?? "", league: leagueModel.league.id, last: 8) { [weak self] response in
            guard let self else { return }
            self.leagueFixtures = response
            self.leagueStandings = leagueModel.league.standings!
            masterService.requestPlayerStats(season: leagueModel.league.season ?? 0, league: leagueModel.league.id) { playersStats in
                self.playersStats = playersStats
                updateScreen()
            }
        }
    }
    
    private func setupInitialItems() {
        startHeaderBlock()
        startLatestResultBlock()
        startTableBlock()
        
    }
    
    // MARK: - Header block
    private func startHeaderBlock() {
        let headerItems: [DetailedStatsItem] = [
            .spacing(30),
            .header(DetailedStatsHeaderCellVM(leagueLogo: leagueModel.league.logo, leagueName: leagueModel.league.name)),
        ]
        items.append(contentsOf: headerItems)
    }
    
    // MARK: - Latest results block
    private func startLatestResultBlock() {
        let latestResultsItems: [DetailedStatsItem] = [
            .title(DetailedStatsTitleVM(title: "Latest Results")),
            .latestResults(DetailedLatestResultsMainCellVM(isOnScreenToVC: { [weak self] _ in
                self?.onReload?(.expandLR)
            }, leagueFixtures: leagueFixtures)),
        ]
        items.append(contentsOf: latestResultsItems)
    }
    
    // MARK: - Table block
    private func startTableBlock() {
        guard let standings = leagueStandings.first else { return }
        var tableBlockItems: [DetailedStatsItem] = []
        let title: DetailedStatsItem = .title(DetailedStatsTitleVM(title: "Table"))
        tableBlockItems.append(title)
        let groups = leagueStandings.compactMap({$0.first?.group})
        if groups.count >= 2 {
            let groupItem: DetailedStatsItem = .groups(DetailedTableGroupsCVCellVM(callbackService: callBackService, groupCallBack: { [weak self] index in
                guard let self else { return }
                self.changeTableContent(index)
            }, groups: groups))
            tableBlockItems.append(groupItem)
        }
        let spacing: DetailedStatsItem = .spacing(20)
        tableBlockItems.append(spacing)
        let table: DetailedStatsItem = .table(DetailedTableGroupsMainCellVM(callbackService: callBackService, leagueStandings: standings))
        tableBlockItems.append(table)
        items.append(contentsOf: tableBlockItems)
    }
    
    private func changeTableContent(_ index: IndexPath) {
        let item: DetailedStatsItem = .table(DetailedTableGroupsMainCellVM(callbackService: callBackService, leagueStandings: leagueStandings[index.item]))
        let old = items
        replaceItem(item)
        let new = items
        onReload2?(Changes(new: new, old: old))
    }
    
    private func replaceItem(_ item: DetailedStatsItem) {
        if let index = items.firstIndex(where: { currentItem in
            switch (currentItem, item) {
            case (.header, .header),
                 (.title, .title),
                 (.latestResults, .latestResults),
                 (.groups, .groups),
                 (.table, .table),
                 (.spacing, .spacing):
                return true
            default:
                return false
            }
        }) {
            items[index] = item
        }
    }
    
    // MARK: - Player stats
    private func startPlayerStatsBlock() {
        
    }
    
    // MARK: - Update screen
    private func updateScreen() {
        let old = items
        setupInitialItems()
        onReload2?(.init(new: items, old: old))
    }
    
    // MARK: - Calculate size
    func getSizeForTable(leagueStanding: [LeaguesInfoStanding]) -> CGFloat {
        let size = (leagueStanding.count + 1) * 44
        return CGFloat(integerLiteral: size)
    }
    
    private func startPlayeStatsBlock() {
        guard !playersStats.isEmpty else { return }
        
//        let topGoals = playersStats.filter({$0.statistics.first.})
        
    }
    
    
    // MARK: - TableView methods
    
    func getItemsCount() -> Int { items.count }
    
    func getItem(indexPath: IndexPath) -> DetailedStatsItem? {
        guard items.indices.contains(indexPath.item) else { return nil }
        return items[indexPath.item]
    }
}

// MARK: - Items
enum DetailedStatsItem: Hashable {
    case header(DetailedStatsHeaderCellVM)
    case title(DetailedStatsTitleVM)//
    case latestResults(DetailedLatestResultsMainCellVM)
    case groups(DetailedTableGroupsCVCellVM)
    case table(DetailedTableGroupsMainCellVM)
    case spacing(CGFloat)
}

// MARK: - Reload
enum DetailedStatsReload {
    case all
    case rows(at: [IndexPath])
    case expandLR
}
