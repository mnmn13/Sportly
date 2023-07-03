//
//  DetailedLatestResultsMainCell.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class DetailedLatestResultsMainCell: UITableViewCell {

    static let identifier = String(describing: DetailedLatestResultsMainCell.self)
    
    private var viewModel: DetailedLatestResultsMainCellVM?
    
    // MARK: - TableView
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.isScrollEnabled = false
        table.bounces = false
        table.separatorStyle = .none
        registerCells(table)
        return table
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Hide separator
    func hideSeparator() {
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 800)
    }
    
    // MARK: - Register cells
    private func registerCells(_ tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "empty")
        tableView.register(DetailedLatestResultsCell.self, forCellReuseIdentifier: DetailedLatestResultsCell.identifier)
        tableView.register(DetailedLatestResultsLabelChevronCell.self, forCellReuseIdentifier: DetailedLatestResultsLabelChevronCell.identifier)
    }
    
    // MARK: - Configure
    func configure(_ viewModel: DetailedLatestResultsMainCellVM) {
        self.viewModel = viewModel
//        bindForCVVisiblitity()
        bindForReload()
        self.viewModel?.prepareData()
    }
    
    // MARK: - Binding
    func bindForCVVisiblitity() {
        guard let viewModel = viewModel else { fatalError() }
        viewModel.isOnScreen = { [weak self] reloadType in
            guard let self else { return }
            self.tableView.beginUpdates()
            switch reloadType {
            case .showSVWithAnimation(indexPath: let indexPath):
                self.tableView.insertRows(at: [indexPath], with: .fade)
            case .hideSVWithAnimation(indexPath: let indexPath):
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            case .showWithoutAnimation(let indexPath):
                self.tableView.insertRows(at: [indexPath], with: .automatic)
            }
            self.tableView.endUpdates()
        }
    }
    
    func bindForReload() {
        guard let viewModel = viewModel else { fatalError() }
        viewModel.onReload = { [weak self] changes in
            guard let self else { return }
            if changes != .none {
                self.tableView.performBatchUpdates {
                    self.tableView.insertSections(changes.insertedSection, with: .top)
                    self.tableView.deleteSections(changes.removedSection, with: .bottom)
                    self.tableView.insertRows(at: changes.inserted, with: .fade)
                    self.tableView.deleteRows(at: changes.removed, with: .fade)
                    self.tableView.reloadRows(at: changes.updated, with: .fade)
                }
            }
        }
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        contentView.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate
extension DetailedLatestResultsMainCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = viewModel?.getItem(indexPath: indexPath) else { return .leastNormalMagnitude }
        switch item {
        case .labelAndChevron: return 50
        case .CVStats: return 200
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - UITableViewDataSource
extension DetailedLatestResultsMainCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getItemsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel?.getItem(indexPath: indexPath) else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
        switch item {
        case .labelAndChevron(let detailedLatestResultsLabelChevronCellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailedLatestResultsLabelChevronCell.identifier, for: indexPath) as? DetailedLatestResultsLabelChevronCell else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
            cell.configure(detailedLatestResultsLabelChevronCellVM)
            cell.selectionStyle = .none
            return cell
        case .CVStats(let detailedLatestResultsCellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailedLatestResultsCell.identifier, for: indexPath) as? DetailedLatestResultsCell else { return  tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
            cell.configure(detailedLatestResultsCellVM)
            return cell
        }
    }
}
