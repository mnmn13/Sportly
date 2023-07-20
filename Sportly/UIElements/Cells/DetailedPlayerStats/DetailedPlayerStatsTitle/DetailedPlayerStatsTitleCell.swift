//
//  DetailedPlayerStatsTitleCell.swift
//  Sportly
//
//  Created by MN on 30.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class DetailedPlayerStatsTitleCell: UITableViewCell {
    
    static let identifier = String(describing: DetailedPlayerStatsTitleCell.self)
    
    private var viewModel: DetailedPlayerStatsTitleCellVM?
    
    let fontSize: CGFloat = 14
    
    private let statsTypePicture: UIImageView = {
        let image = RoundedImageView()
        return image
    }()
    
    private lazy var statsTypeLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Montserrat.Montserrat_Bold(size: fontSize)
        label.textColor = .black
        return label
    }()
    
    private lazy var seeAllLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Montserrat.Montserrat_Bold(size: fontSize)
        label.textColor = .gray
        label.text = "SEE ALL"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        configureGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    // MARK: - TapGestureRecognizer
    private func configureGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureTapped))
        seeAllLabel.addGestureRecognizer(tapGesture)
        seeAllLabel.isUserInteractionEnabled = true
    }
    
    @objc private func gestureTapped() {
        guard let viewModel = viewModel else { fatalError() }
        viewModel.gestureTapped()
    }
    
    func hideSeparator() {
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 800)
    }
    
    // MARK: - Configure
    func configure(_ viewModel: DetailedPlayerStatsTitleCellVM) {
        self.viewModel = viewModel
        setupContent()
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        contentView.addSubview(statsTypePicture)
        contentView.addSubview(statsTypeLabel)
        contentView.addSubview(seeAllLabel)
        
        statsTypePicture.snp.makeConstraints { make in
            make.height.equalTo(statsTypePicture.snp.width)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(20)
        }
        
        statsTypeLabel.snp.makeConstraints { make in
            make.leading.equalTo(statsTypePicture.snp.trailing).offset(5)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        seeAllLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-15)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    // MARK: - Content
    private func setupContent() {
        guard let viewModel = viewModel else { fatalError() }
        switch viewModel.statsType {
        case .goals:
            statsTypePicture.image = Asset.Assets.ball.image
            statsTypeLabel.text = "GOALS"
        case .assists:
            statsTypePicture.image = Asset.Assets.footballBoots.image
            statsTypeLabel.text = "ASSISTS"
        case .goalsAndAssists:
            statsTypePicture.image = Asset.Assets.player.image
            statsTypeLabel.text = "GOALS & ASSISTS"
        }
    }
}
