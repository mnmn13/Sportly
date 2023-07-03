//
//  DetailedLatestresultsContentCell.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class DetailedLatestresultsContentCell: UITableViewCell {
    
    static let identifier = String(describing: DetailedLatestresultsContentCell.self)
    
    private var viewModel: DetailedLatestresultsContentCellVM?
    
    // MARK: - Team logo
    private let teamLogo: UIImageView = {
        let image = RoundedImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    // MARK: - Team label
    private let teamName: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: 12, weight: .regular)
//        label.font = FontFamily.Montserrat.Montserrat_Regular(size: 12)
        label.font = FontFamily.Montserrat.Montserrat_Bold(size: 12)
        return label
    }()
    
    // MARK: - Goal score label
    private let goalScore: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: 12, weight: .regular)
//        label.font = FontFamily.Montserrat.Montserrat_Regular(size: 12)
        label.font = FontFamily.Montserrat.Montserrat_Bold(size: 12)
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        contentView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    // MARK: - Configure
    func configure(_ viewModel: DetailedLatestresultsContentCellVM) {
        self.viewModel = viewModel
        setupContent()
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        contentView.addSubview(teamLogo)
        contentView.addSubview(teamName)
        contentView.addSubview(goalScore)
        
        teamLogo.snp.makeConstraints { make in
            make.height.equalTo(teamLogo.snp.width)
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(20)
        }
        
        teamName.snp.makeConstraints { make in
            make.leading.equalTo(teamLogo.snp.trailing).offset(5)
            make.centerY.equalTo(teamLogo.snp.centerY)
        }
        
        goalScore.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalTo(teamName.snp.centerY)
            make.width.equalTo(15)
        }
    }
    
    // MARK: - Configure content
    private func setupContent() {
        guard let viewModel = viewModel else { fatalError("View model is nil") }
        teamLogo.setImage(with: viewModel.teamLogo ?? "")
        teamName.text = viewModel.teamName
        goalScore.text = "\(viewModel.teamScore ?? 0)"
        
        if viewModel.isTeamLead {
//            teamName.font = .boldSystemFont(ofSize: 12)
//            goalScore.font = .boldSystemFont(ofSize: 12)
            teamName.font = FontFamily.Montserrat.Montserrat_ExtraBold(size: 12)
            goalScore.font = FontFamily.Montserrat.Montserrat_ExtraBold(size: 12)
        }
    }
}
