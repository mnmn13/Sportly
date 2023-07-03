//
//  DetailedTableGroupsCVCellVM.swift
//  Sportly
//
//  Created by MN on 23.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct DetailedTableGroupsCVCellVM {
    
    // MARK: - CallBack's
    var groupCallBack: SimpleClosure<IndexPath>?
    var onReload: SimpleClosure<DetailedTableGroupsCVCellVMReloadType>?
    
    // MARK: - Properties
    private var callbackService: CallbackService
//    private var standings: [[LeaguesInfoStanding]]
    private var groups: [String] = []
    private var items: [DetailedTableGroupsCVCellVMItem] = []
    private var itemSelected: IndexPath?
    
    init(callbackService: CallbackService, groupCallBack: SimpleClosure<IndexPath>?, groups: [String]) {
        self.callbackService = callbackService
        self.groupCallBack = groupCallBack
        self.groups = groups
        validateData()
    }
    
    // MARK: - ValidateData
    mutating private func validateData() {
//        guard standings.first?.first?.group != nil else {fatalError("\(type(of: self)) \(#function)")}
//        groups.append(contentsOf: standings.compactMap({$0.first?.group}))
        createItems()
    }
    
    // MARK: - Create items
    mutating private func createItems() {
        for group in groups {
            let item: DetailedTableGroupsCVCellVMItem = .groups(DetailedTableGroupsTitleCellVM(group: group))
            items.append(item)
        }
//        onReload?(.allWithAnimation)
    }
    
    // MARK: - Cell tapped action
    mutating func itemSelected(indexPath: IndexPath) {
        if itemSelected != indexPath {
            groupCallBack?(indexPath)
            itemSelected = indexPath
        }
    }
    
    // MARK: - CollectionView methods
    func getItemsCount() -> Int { items.count }
    
    func getItem(indexPath: IndexPath) -> DetailedTableGroupsCVCellVMItem? {
        guard items.indices.contains(indexPath.item) else { return nil }
        return items[indexPath.item]
    }
}

// MARK: - Equitable ViewModel
extension DetailedTableGroupsCVCellVM: Hashable {
    func hash(into hasher: inout Hasher) {
//        hasher.combine(standings)
        hasher.combine(groups)
        hasher.combine(items)
    }
    
    static func == (lhs: DetailedTableGroupsCVCellVM, rhs: DetailedTableGroupsCVCellVM) -> Bool {
//        return lhs.standings == rhs.standings &&
            return lhs.groups == rhs.groups &&
            lhs.items == rhs.items
    }
}

// MARK: - Cell items
enum DetailedTableGroupsCVCellVMItem: Hashable {
    case groups(DetailedTableGroupsTitleCellVM)
}

// MARK: - Reload type enum

enum DetailedTableGroupsCVCellVMReloadType {
    case allWithAnimation
    case atIndexWithAnimation
}
