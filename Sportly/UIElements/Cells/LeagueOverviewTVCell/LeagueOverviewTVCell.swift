//
//  LeagueOverviewTVCell.swift
//  Sportly
//
//  Created by MN on 19.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class LeagueOverviewTVCell: UITableViewCell {

    static let identifier = String(describing: LeagueOverviewTVCell.self)
    
    var viewModel: LeagueOverviewTVCellVM?
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        registerCells(tableView)
        return tableView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(viewModel: LeagueOverviewTVCellVM) {
        self.viewModel = viewModel
        bindForReload()
        self.viewModel?.convertData()
    }
    
    private func bindForReload() {
        viewModel?.onReload = { [weak self] changes in
            guard let self else { return }
            if changes != .none {
                self.tableView.performBatchUpdates {
                    self.tableView.insertSections(changes.insertedSection, with: .top)
                    self.tableView.deleteSections(changes.removedSection, with: .bottom)
                    self.tableView.insertRows(at: changes.inserted, with: .none)
                    self.tableView.deleteRows(at: changes.removed, with: .none)
                    self.tableView.reloadRows(at: changes.updated, with: .none)
                }
            }
        }
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
        }
    }
    
    private func registerCells(_ tableView: UITableView) {
        tableView.register(LogoAndTitleTVCell.self, forCellReuseIdentifier: LogoAndTitleTVCell.identifier)
        tableView.register(LogosAndLabelCell.self, forCellReuseIdentifier: LogosAndLabelCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "empty")
    }
}

extension LeagueOverviewTVCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = viewModel?.getItems(indexPath: indexPath) else { return .leastNormalMagnitude }
        
        switch item {
        case .logoAndTitle: return 70
        case .logosAndLabel: return 70
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didTap()
    }
}

extension LeagueOverviewTVCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getNumberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let item = viewModel?.getItems(indexPath: indexPath) else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
        switch item {
        case.logoAndTitle(let logoAndTitleTVCellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LogoAndTitleTVCell.identifier, for: indexPath) as? LogoAndTitleTVCell else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
            cell.configure(logoAndTitleTVCellVM)
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor(projColors: .gray)
            return cell
        case .logosAndLabel(let logosAndLabelVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LogosAndLabelCell.identifier, for: indexPath) as? LogosAndLabelCell else { return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath) }
            cell.configure(logosAndLabelVM)
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor(projColors: .gray)
            return cell
        }
    }
}
