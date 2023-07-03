//
//  DetailedLatestResultsMainCellVM.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

class DetailedLatestResultsMainCellVM {
    
    // MARK: - CallBack's
    var isOnScreen: SimpleClosure<DetailedLatestResultsMainCellReloadType>?
    var isOnScreenToVC: SimpleClosure<Bool>?
    var onReload: SimpleClosure<Changes>?
    
    // MARK: - Properties
    private let leagueFixtures: [LeaguesFixtureV3Response]
    private var items: [DetailedLatestResultsMainCellItem] = []
    private var collectionViewItem: [DetailedLatestResultsMainCellItem] = []
    
    init(isOnScreenToVC: SimpleClosure<Bool>?, leagueFixtures: [LeaguesFixtureV3Response]) {
        self.isOnScreenToVC = isOnScreenToVC
        self.leagueFixtures = leagueFixtures
    }
    
    // MARK: - Prepare data and setup initial items
    func prepareData() {
        createCVItem()
        setupInitialItems()
        addCVItem()
    }
    
    // MARK: - Setup initial items
    private func setupInitialItems() {
        items = [
            .labelAndChevron(DetailedLatestResultsLabelChevronCellVM(roundLabel: leagueFixtures.first?.league.round ?? "", cellTappedCallBack: { [weak self] isOnScreen in
                guard let self = self else { return }
                self.hideShowCollectionView(isOnScreen)
                self.isOnScreenToVC?(false)
            }))
        ]
    }
    
    // MARK: - Hide/Show rows with animation
    private func hideShowCollectionView(_ isOnScreen: Bool) {
//        switch isOnScreen {
//        case true:
//            items.append(contentsOf: collectionViewItem)
//            let index = IndexPath(item: 1, section: 0)
//            self.isOnScreen?(.showSVWithAnimation(indexPath: index))
//        case false:
//            items.removeLast()
//            let index = IndexPath(item: 1, section: 0)
//            self.isOnScreen?(.hideSVWithAnimation(indexPath: index))
//        }
        
        switch isOnScreen {
        case true:
            let old = items
            items.append(contentsOf: collectionViewItem)
            onReload?(.init(new: items, old: old))
        case false:
            let old = items
            items.removeLast()
            onReload?(.init(new: items, old: old))
        }
        
    }
    
    // MARK: - Create collectionView item
    private func createCVItem() {
        let item: DetailedLatestResultsMainCellItem = .CVStats(DetailedLatestResultsCellVM(leaguesFixtures: leagueFixtures))
        collectionViewItem = [item]
    }
    
    // MARK: - Add collectionView item with animation
    private func addCVItem() {
        items.append(contentsOf: collectionViewItem)
        let index = IndexPath(item: 1, section: 0)
        isOnScreen?(.showSVWithAnimation(indexPath: index))
    }
    
    // MARK: - TableView methods
    func getItemsCount() -> Int { items.count }
     
    func getItem(indexPath: IndexPath) -> DetailedLatestResultsMainCellItem? {
        guard items.indices.contains(indexPath.item) else { return nil }
        return items[indexPath.item]
    }
}

// MARK: - Cell items
enum DetailedLatestResultsMainCellItem: Hashable {
    case labelAndChevron(DetailedLatestResultsLabelChevronCellVM)
    case CVStats(DetailedLatestResultsCellVM)
}

// MARK: - Reload type enum
enum DetailedLatestResultsMainCellReloadType {
    case showSVWithAnimation(indexPath: IndexPath)
    case hideSVWithAnimation(indexPath: IndexPath)
    case showWithoutAnimation(indexPath: IndexPath)
}

extension DetailedLatestResultsMainCellVM: Hashable {
    static func == (lhs: DetailedLatestResultsMainCellVM, rhs: DetailedLatestResultsMainCellVM) -> Bool {
        return lhs.leagueFixtures == rhs.leagueFixtures &&
        lhs.items == rhs.items &&
        lhs.collectionViewItem == rhs.collectionViewItem
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(leagueFixtures)
        hasher.combine(items)
        hasher.combine(collectionViewItem)
    }
}
