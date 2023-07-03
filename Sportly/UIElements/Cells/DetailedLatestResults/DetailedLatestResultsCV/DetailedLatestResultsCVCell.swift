//
//  DetailedLatestResultsCVCell.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class DetailedLatestResultsCVCell: UICollectionViewCell {
    
    static let identifier = String(describing: DetailedLatestResultsCVCell.self)
    
    private var viewModel: DetailedLatestResultsCVCellVM?
    
    // MARK: - TableView
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.isScrollEnabled = false
        table.bounces = false
        table.separatorStyle = .singleLine
//        table.separatorColor = UIColor(named: "gray2")
        table.separatorColor = Asset.Colors.gray2.systemColor
        table.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        registerCells(table)
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    // MARK: - RegisterCells
    private func registerCells(_ tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "empty")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        tableView.register(DetailedLatestResultsTVCell.self, forCellReuseIdentifier: DetailedLatestResultsTVCell.identifier)
    }
    
    // MARK: - Configure
    func configure(_ viewModel: DetailedLatestResultsCVCellVM) {
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
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(160)
        }
    }
}

// MARK: - UITableViewDelegate
extension DetailedLatestResultsCVCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = viewModel?.getItem(indexPath: indexPath) else { return .leastNormalMagnitude }
        switch item {
        case .twoContentCells: return 80
        }
    }
}

// MARK: - UITableViewDataSource
extension DetailedLatestResultsCVCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getItemsCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel?.getItem(indexPath: indexPath) else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
        switch item {
        case .twoContentCells(let detailedLatestResultsTVCellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailedLatestResultsTVCell.identifier, for: indexPath) as? DetailedLatestResultsTVCell else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
            cell.configure(detailedLatestResultsTVCellVM)
            if indexPath.item == viewModel!.getItemsCount() - 1 { cell.hideSeparator() }
            cell.backgroundColor = UIColor(projColors: .gray)
            return cell
        }
    }
}
