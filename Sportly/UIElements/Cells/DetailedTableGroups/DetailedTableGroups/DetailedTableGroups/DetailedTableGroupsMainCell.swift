//
//  DetailedTableGroupsMainCell.swift
//  Sportly
//
//  Created by MN on 24.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class DetailedTableGroupsMainCell: UITableViewCell {
    
    static let identifier = String(describing: DetailedTableGroupsMainCell.self)
    
    private var viewModel: DetailedTableGroupsMainCellVM?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.isScrollEnabled = false
//        table.backgroundColor = UIColor(projColors: .gray)
        table.backgroundColor = Asset.Colors.gray.systemColor
//        table.separatorColor = UIColor(named: "gray2")
        table.separatorColor = Asset.Colors.gray2.systemColor
        table.separatorInset = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 0)
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        table.estimatedRowHeight = 60
        registerCells(table)
        return table
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    func hideSeparator() {
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 800)
        
    }
    
    // MARK: - RagisterCells
    private func registerCells(_ tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "empty")
        tableView.register(DetailedTableGroupsTableCell.self, forCellReuseIdentifier: DetailedTableGroupsTableCell.identifier)
        tableView.register(DetailedTableGroupsTableContentCell.self, forCellReuseIdentifier: DetailedTableGroupsTableContentCell.identifier)
    }
    
    // MARK: - Configure
    func configure(_ viewModel: DetailedTableGroupsMainCellVM) {
        self.viewModel = viewModel
//        bindForReload()
        viewModel.configureInitialItems()
    }
    
    private func bindForReload() {
        guard let viewModel = viewModel else { fatalError("ViewModel is nil") }
        viewModel.onReload = { [weak self] in
            self?.tableView.performBatchUpdates {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
        }
    }
}

// MARK: - UITableViewDelegate
extension DetailedTableGroupsMainCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = viewModel?.getItem(indexPath: indexPath) else { return UITableView.automaticDimension }
        switch item {
        case .header: return 44
        case .content: return 44
        }
    }
}

// MARK: - UITableViewDataSource
extension DetailedTableGroupsMainCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getItemsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel?.getItem(indexPath: indexPath) else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
        switch item {
        case .header(let detailedTableGroupsTableCellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailedTableGroupsTableCell.identifier, for: indexPath) as? DetailedTableGroupsTableCell else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
            cell.configure(detailedTableGroupsTableCellVM)
            cell.backgroundView?.backgroundColor = .clear
            cell.backgroundColor = .clear
            return cell
        case .content(let detailedTableGroupsTableContentCellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailedTableGroupsTableContentCell.identifier, for: indexPath) as? DetailedTableGroupsTableContentCell else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
            cell.configure(detailedTableGroupsTableContentCellVM)
            cell.backgroundColor = .clear
//            if indexPath != IndexPath(row: 1, section: 0) && indexPath.item == viewModel!.getItemsCount() - 1 {
//                cell.hideSeparator()
//                
//            }
            if indexPath.item == viewModel!.getItemsCount() - 1 {
                cell.hideSeparator()
            } else {
                cell.separatorInset = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 0)
            }
            return cell
        }
    }
}
