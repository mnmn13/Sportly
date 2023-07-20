//
//  DetailedTableGroupsTableCell.swift
//  Sportly
//
//  Created by MN on 24.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class DetailedTableGroupsTableCell: UITableViewCell {
    
    static let identifier = String(describing: DetailedTableGroupsTableCell.self)
    
    private var viewModel: DetailedTableGroupsTableCellVM?
    
    private var fontSize: CGFloat = 16
    
    private lazy var groupLabel: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: fontSize, weight: .heavy)
        label.font = FontFamily.Montserrat.Montserrat_ExtraBold(size: fontSize)
        return label
    }()
    
    private lazy var gamesPlayedLabel: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: fontSize, weight: .heavy)
        label.font = FontFamily.Montserrat.Montserrat_ExtraBold(size: fontSize)
        label.textAlignment = .center
        label.text = "GP"
        return label
    }()
    
    private lazy var wins: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: fontSize, weight: .heavy)
        label.font = FontFamily.Montserrat.Montserrat_ExtraBold(size: fontSize)
        label.textAlignment = .center
        label.text = "W"
        return label
    }()
    
    private lazy var draws: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: fontSize, weight: .heavy)
        label.font = FontFamily.Montserrat.Montserrat_ExtraBold(size: fontSize)
        label.textAlignment = .center
        label.text = "D"
        return label
    }()
    
    private lazy var losses: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: fontSize, weight: .heavy)
        label.font = FontFamily.Montserrat.Montserrat_ExtraBold(size: fontSize)
        label.textAlignment = .center
        label.text = "L"
        return label
    }()
    
    private lazy var points: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: fontSize, weight: .heavy)
        label.font = FontFamily.Montserrat.Montserrat_ExtraBold(size: fontSize)
        label.textAlignment = .center
        label.text = "P"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
//        contentView.backgroundColor = UIColor(projColors: .gray)
        contentView.backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    // MARK: - Configure
    func configure(_ viewModel: DetailedTableGroupsTableCellVM) {
        self.viewModel = viewModel
        setupContent()
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        contentView.addSubview(groupLabel)
        contentView.addSubview(gamesPlayedLabel)
        contentView.addSubview(wins)
        contentView.addSubview(draws)
        contentView.addSubview(losses)
        contentView.addSubview(points)
        
        groupLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        points.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-5)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(25)
        }
        
        losses.snp.makeConstraints { make in
            make.trailing.equalTo(points.snp.leading).offset(-5)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(25)
        }
        
        draws.snp.makeConstraints { make in
            make.trailing.equalTo(losses.snp.leading).offset(-5)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(25)
        }
        
        wins.snp.makeConstraints { make in
            make.trailing.equalTo(draws.snp.leading).offset(-5)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(25)
        }
        
        gamesPlayedLabel.snp.makeConstraints { make in
            make.trailing.equalTo(wins.snp.leading).offset(-10)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(30)
        }
    }
    
    // MARK: - Content
    private func setupContent() {
        guard var viewModelCopy = viewModel else { fatalError() }
        groupLabel.text = viewModelCopy.group
    }
}
