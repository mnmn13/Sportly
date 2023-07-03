//
//  DetailedLatestResultsTVCell.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class DetailedLatestResultsTVCell: UITableViewCell {
    
    static let identifier = String(describing: DetailedLatestResultsTVCell.self)
    
    private var viewModel: DetailedLatestResultsTVCellVM?
    
    // MARK: - TableView
    private lazy var tableView: UITableView = {
       let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.isScrollEnabled = false
        table.separatorStyle = .none
        table.backgroundColor = .clear
        registerCells(table)
        return table
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
//        contentView.backgroundColor = UIColor(projColors: .gray)
        contentView.backgroundColor = Asset.Colors.gray.systemColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    // MARK: - Register cells
    private func registerCells(_ tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "empty")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        tableView.register(DetailedLatestresultsContentCell.self, forCellReuseIdentifier: DetailedLatestresultsContentCell.identifier)
    }
    
    // Hide separator
    func hideSeparator() {
        self.separatorInset = UIEdgeInsets(top: 0, left: 400, bottom: 0, right: 0)
    }
    
    // MARK: - Configure
    func configure(_ viewModel: DetailedLatestResultsTVCellVM) {
        self.viewModel = viewModel
        bindForReload()
    }
    
    // MARK: - Binding
    private func bindForReload() {
        guard var viewModel = viewModel else { fatalError() }
        viewModel.onReload = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
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
extension DetailedLatestResultsTVCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = viewModel?.getItem(indexPath: indexPath) else { return .leastNormalMagnitude }
        switch item {
        case .logoNameScore: return 15
        case .spacing(let spacing): return spacing
        }
    }
}

// MARK: - UITableViewDataSource
extension DetailedLatestResultsTVCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getItemsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel?.getItem(indexPath: indexPath) else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
        switch item {
        case .logoNameScore(let detailedLatestresultsContentCellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailedLatestresultsContentCell.identifier, for: indexPath) as? DetailedLatestresultsContentCell else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
            cell.configure(detailedLatestresultsContentCellVM)
            cell.contentView.backgroundColor = UIColor(projColors: .gray)
            return cell
        case .spacing:
            let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
    }
}
