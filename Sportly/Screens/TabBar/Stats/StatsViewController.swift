//
//  StatsViewController.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit
import SnapKit

class StatsViewController: UIViewController {
    
    var viewModel: StatsViewModelType!
    
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(projColors: .green1)
        bindForReload()
        loadData()
        setupNav()
        setupTV()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hidesBottomBarWhenPushed = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hidesBottomBarWhenPushed = false
    }
    
    private func loadData() {
        Task {
            await viewModel.loadData()
        }
    }
    
    private func bindForReload() {
        viewModel.onReload = { [weak self] changes in
            guard let self else { return }
            DispatchQueue.main.async {
                if changes != .none {
                    self.tableView.beginUpdates()
                    self.tableView.insertSections(changes.insertedSection, with: .top)
                    self.tableView.deleteSections(changes.removedSection, with: .bottom)
                    self.tableView.insertRows(at: changes.inserted, with: .none)
                    self.tableView.deleteRows(at: changes.removed, with: .none)
                    self.tableView.reloadRows(at: changes.updated, with: .none)
                    self.tableView.endUpdates()
                }
            }
        }
    }
    
    private func bindForCellCount() {
//        viewModel.cellsOnScreen
    }
    
    private func bindForSkeleton() {
        viewModel.skeletonSwitch = { isOn in
            
        }
    }
    
    private func setupNav() {}
    
    private func setupTV() {
        view.addSubview(tableView)
        setupConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.isScrollEnabled = true
        tableView.separatorStyle = .none
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(LeagueOverviewTVCell.self, forCellReuseIdentifier: LeagueOverviewTVCell.identifier)
//        tableView.register(TableViewCellTableView.self, forCellReuseIdentifier: TableViewCellTableView.identifier)
        tableView.register(UINib(nibName: TextTVCell.identifier, bundle: .main), forCellReuseIdentifier: TextTVCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "empty")
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDelegate
extension StatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = viewModel.getItem(indexPath: indexPath) else { return .leastNormalMagnitude }
        
        switch item {
        case .text: return 100
        case .spacing(let cGFloat): return cGFloat
        case .TVCell: return 140
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView != self.tableView {
            viewModel.validateTappedCell(indexPath)
        }
    }
}

//MARK: - UITableViewDataSource
extension StatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = viewModel.getItem(indexPath: indexPath) else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
        
        switch item {
        case .text(let textTVCellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextTVCell.identifier, for: indexPath) as? TextTVCell else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
            cell.configure(with: textTVCellVM)
            cell.selectionStyle = .none
            return cell
        case .spacing:
            let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        case .TVCell(let leagueOverviewTVCellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LeagueOverviewTVCell.identifier, for: indexPath) as? LeagueOverviewTVCell else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
            cell.configure(viewModel: leagueOverviewTVCellVM)
            cell.selectionStyle = .default
            return cell
        }
    }
}

extension StatsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.map { print($0.item) }
//        viewModel.loadNextData(prefetchRowsAt: indexPaths)
    }
}
