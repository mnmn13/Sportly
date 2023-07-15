//
//  DetailedStatsViewController.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit
import SnapKit
import SkeletonView

class DetailedStatsViewController: UIViewController {
    
    var viewModel: DetailedStatsViewModel!
    private var latestResCellExpanded: Bool = true
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isScrollEnabled = true
        tableView.bounces = true
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorColor = .black
        tableView.estimatedRowHeight = 300
        tableView.backgroundView?.backgroundColor = .black
        tableView.backgroundColor = .black
        registerCells(tableView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindForReload()
        bindForReload2()
        setupConstraints()
        view.backgroundColor = .black
        loadData()
        view.superview?.backgroundColor = .black
    }
    
    private func loadData() {
        Task {
            await viewModel.loadData()
        }
    }
    
    //Bind
    private func bindForReload() {
        viewModel.onReload = { [weak self] reloadType in
            guard let self = self else { return }
            switch reloadType {
            case .all: self.tableView.reloadData()
            case .rows(at: let at): self.tableView.reloadRows(at: at, with: .fade)
            case .expandLR:
                self.latestResCellExpanded = !latestResCellExpanded
                UIView.animate(withDuration: 0.3) {
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                }
            }
        }
    }
    
    private func bindForReload2() {
        viewModel.onReload2 = { [weak self] changes in
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
    
    //Constraints
    private func setupConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
    
    //Register cells
    private func registerCells(_ tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "empty")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        tableView.register(DetailedStatsHeaderCell.self, forCellReuseIdentifier: DetailedStatsHeaderCell.identifier)
        tableView.register(DetailedStatsTitleCell.self, forCellReuseIdentifier: DetailedStatsTitleCell.identifier)
        tableView.register(DetailedLatestResultsMainCell.self, forCellReuseIdentifier: DetailedLatestResultsMainCell.identifier)
        tableView.register(DetailedTableGroupsCVCell.self, forCellReuseIdentifier: DetailedTableGroupsCVCell.identifier)
        tableView.register(DetailedTableGroupsMainCell.self, forCellReuseIdentifier: DetailedTableGroupsMainCell.identifier)
    }
}

// MARK: - UITableViewDelegate
extension DetailedStatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = viewModel.getItem(indexPath: indexPath) else { return .leastNormalMagnitude }
        switch item {
        case .header: return 150
        case .title: return 50
        case .latestResults:
            if latestResCellExpanded {
                return 250
            } else {
                return 50
            }
        case .groups: return 60
        case .table(let cellVM): return viewModel.getSizeForTable(leagueStanding: cellVM.leagueStandings)
        case .spacing(let spacing): return spacing
        }
    }
}

// MARK: - UITableViewDataSource
extension DetailedStatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel.getItem(indexPath: indexPath) else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath)}
        
        switch item {
        case .header(let detailedStatsHeaderCellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailedStatsHeaderCell.identifier, for: indexPath) as? DetailedStatsHeaderCell else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
            cell.configure(detailedStatsHeaderCellVM)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            cell.backgroundColor = .black
            cell.selectionStyle = .none
            return cell
        case .title(let detailedStatsTitleVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailedStatsTitleCell.identifier, for: indexPath) as? DetailedStatsTitleCell else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
            cell.configure(detailedStatsTitleVM)
            return cell
        case .latestResults(let detailedLatestResultsMainCellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailedLatestResultsMainCell.identifier, for: indexPath) as? DetailedLatestResultsMainCell else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
            cell.configure(detailedLatestResultsMainCellVM)
            cell.hideSeparator()
            return cell
        case .groups(let cellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailedTableGroupsCVCell.identifier, for: indexPath) as? DetailedTableGroupsCVCell else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
            cell.configure(cellVM)
            cell.hideSeparator()
            return cell
        case .table(let cellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailedTableGroupsMainCell.identifier, for: indexPath) as? DetailedTableGroupsMainCell else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
            cell.configure(cellVM)
            cell.hideSeparator()
            return cell
        case .spacing:
            let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
            if indexPath.item == 0 {
                cell.backgroundColor = .black
            } else {
                cell.backgroundColor = .white
            }
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 800)
            cell.selectionStyle = .none
            return cell
        }
    }
}
