//
//  TableViewCellTableView.swift
//  Sportly
//
//  Created by MN on 14.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit
import SnapKit

class TableViewCellTableView: UITableViewCell {
    
    static let identifier = String(describing: TableViewCellTableView.self)

    var viewModel: TableViewCellTableViewVM?
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .singleLine
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
    
    func configure(viewModel: TableViewCellTableViewVM) {
        self.viewModel = viewModel
        bindForReload()
    }
    
    private func bindForReload() {
        viewModel?.onReload = { [weak self] in
            self?.tableView.reloadData()
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
        tableView.register(CellForTableViewCell.self, forCellReuseIdentifier: CellForTableViewCell.identifier)
    }
    
}

extension TableViewCellTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = viewModel?.getItems(indexPath: indexPath) else { return .leastNormalMagnitude }
        
        switch item {
        case .imageLogoChevron:
            return 70
        }
    }
    
}
extension TableViewCellTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getNumberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = viewModel?.getItems(indexPath: indexPath) else { return .init() }
        switch item {
        case .imageLogoChevron(let cellForTableViewCellVM):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellForTableViewCell.identifier, for: indexPath) as? CellForTableViewCell else { return .init() }
            cell.configure(viewModel: cellForTableViewCellVM)
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor(projColors: .gray)
            return cell
        }
    }
}
