//
//  DetailedTableGroupsTableContentCell.swift
//  Sportly
//
//  Created by MN on 25.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class DetailedTableGroupsTableContentCell: UITableViewCell {
    
    static let identifier = String(describing: DetailedTableGroupsTableContentCell.self)
    
    private var viewModel: DetailedTableGroupsTableContentCellVM?
    
    private var fontSize: CGFloat = 16
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var rank: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Montserrat.Montserrat_Bold(size: fontSize)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var teamLogo: UIImageView = {
        let image = RoundedImageView()
        return image
    }()
    
    private lazy var teamName: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: fontSize, weight: .bold)
        label.font = FontFamily.Montserrat.Montserrat_Bold(size: fontSize)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var gamesPlayed: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: fontSize, weight: .bold)
        label.font = FontFamily.Montserrat.Montserrat_Bold(size: fontSize)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var wins: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: fontSize, weight: .bold)
        label.font = FontFamily.Montserrat.Montserrat_Bold(size: fontSize)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var draws: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: fontSize, weight: .bold)
        label.font = FontFamily.Montserrat.Montserrat_Bold(size: fontSize)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var losses: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: fontSize, weight: .bold)
        label.font = FontFamily.Montserrat.Montserrat_Bold(size: fontSize)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var points: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: fontSize, weight: .bold)
        label.font = FontFamily.Montserrat.Montserrat_Bold(size: fontSize)
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        contentView.backgroundColor = .clear //UIColor(projColors: .gray)
    }
    
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
    
    // MARK: - Configure
    func configure(_ viewModel: DetailedTableGroupsTableContentCellVM) {
        self.viewModel = viewModel
        setupContent()
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        contentView.addSubview(lineView)
        contentView.addSubview(rank)
        contentView.addSubview(teamLogo)
        contentView.addSubview(teamName)
        contentView.addSubview(gamesPlayed)
        contentView.addSubview(wins)
        contentView.addSubview(draws)
        contentView.addSubview(losses)
        contentView.addSubview(points)
        
        lineView.snp.makeConstraints { make in
            make.width.equalTo(3)
            make.top.equalTo(contentView.snp.top).offset(-4)
            make.bottom.equalTo(contentView.snp.bottom).offset(-4)
            make.leading.equalTo(contentView.snp.leading)
        }
        
        rank.snp.makeConstraints { make in
            make.leading.equalTo(lineView.snp.trailing).offset(5)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(25)
        }
        
        teamLogo.snp.makeConstraints { make in
            make.height.equalTo(teamLogo.snp.width)
            make.leading.equalTo(rank.snp.trailing).offset(5)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(15)
        }
        
        teamName.snp.makeConstraints { make in
            make.leading.equalTo(teamLogo.snp.trailing).offset(5)
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
        
        gamesPlayed.snp.makeConstraints { make in
            make.trailing.equalTo(wins.snp.leading).offset(-10)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(30)
        }
    }
    
    // MARK: - Content
    private func setupContent() {
        guard var viewModelCopy = viewModel else { fatalError("ViewModel is nil") }
        lineView.backgroundColor = getLineViewColor(rank: viewModelCopy.rank)
        rank.text = "\(viewModelCopy.rank)"
        teamLogo.setImage(with: viewModelCopy.teamLogo)
        teamName.text = viewModel?.teamName
        points.text = "\(viewModelCopy.points)"
        losses.text = "\(viewModelCopy.losses)"
        draws.text = "\(viewModelCopy.draws)"
        wins.text = "\(viewModelCopy.wins)"
        gamesPlayed.text = "\(viewModelCopy.pamesPlayed)"
    }
    
    func getLineViewColor(rank: Int) -> UIColor {
        switch rank {
        case 1: return .green
        case 2: return .yellow
        default: return .gray
        }
    }
}
