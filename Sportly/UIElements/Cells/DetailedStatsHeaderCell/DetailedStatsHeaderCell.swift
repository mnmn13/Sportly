//
//  DetailedStatsHeaderCell.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class DetailedStatsHeaderCell: UITableViewCell {
    
    static let identifier = String(describing: DetailedStatsHeaderCell.self)
    
    private var viewModel: DetailedStatsHeaderCellVM?
    
    private let leagueLogo: UIImageView = {
       let imageView = RoundedImageView()
//        imageView.contentMode = .scaleAspectFill
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let leagueLabel: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: 20, weight: .heavy)
        label.font = FontFamily.Montserrat.Montserrat_ExtraBold(size: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    // MARK: - Configure viewModel and content
    func configure(_ viewModel: DetailedStatsHeaderCellVM) {
        self.viewModel = viewModel
        configureContent()
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        contentView.addSubview(leagueLogo)
        contentView.addSubview(leagueLabel)
        
        leagueLogo.snp.makeConstraints { make in
            make.height.equalTo(leagueLogo.snp.width)
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalToSuperview().offset(25)
            make.size.equalTo(50)
        }
        
        leagueLabel.snp.makeConstraints { make in
            make.top.equalTo(leagueLogo.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().offset(10)
        }
    }
    
    // MARK: - Configure content
    func configureContent() {
        guard let viewModel = viewModel else { fatalError("ViewModel is nil") }
        leagueLogo.setImage(with: viewModel.leagueLogo ?? "")
        leagueLabel.text = viewModel.leagueName
        layoutIfNeeded()
    }
}
