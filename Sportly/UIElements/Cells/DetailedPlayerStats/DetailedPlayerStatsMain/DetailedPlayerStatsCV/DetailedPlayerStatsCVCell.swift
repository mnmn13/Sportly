//
//  DetailedPlayerStatsCVCell.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class DetailedPlayerStatsCVCell: UICollectionViewCell {
    
    static let identifier = String(describing: DetailedPlayerStatsCVCell.self)
    
    var viewModel: DetailedPlayerStatsCVCellVM?
    
    private lazy var playerNumberLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Montserrat.Montserrat_ExtraBold(size: 54)
        label.textColor = Asset.Colors.gray3.systemColor
        return label
    }()
    
    private lazy var playerImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        return image
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = FontFamily.Montserrat.Montserrat_Bold(size: 22)
        return label
    }()
    
    private lazy var scoreView: UIView = {
        let view = RoundedUIView()
        view.backgroundColor = Asset.Colors.green1.systemColor
        view.isHidden = true
        return view
    }()
    
    private let gradientView: UIView = {
        let view = GradientView()
        return view
    }()
    
    private let playerName: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Montserrat.Montserrat_Bold(size: 16)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
        
    }
    
    // MARK: - Configure
    func configure(_ viewModel: DetailedPlayerStatsCVCellVM) {
        self.viewModel = viewModel
        configureContent()
    }
    
    // MARK: - Constraints
    private func configureConstraints() {
        setupPlayerImageConstraints()
        setupScoreLabelConstraints()
        setupPlayerNumberConstraints()
        setupGradientViewConstraints()
        setupPlayerNameConstraints()
    }
    
    private func setupPlayerImageConstraints() {
        contentView.addSubview(playerImage)
        playerImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
        }
    }
    
    private func setupScoreLabelConstraints() {
        playerImage.addSubview(scoreView)
        scoreView.addSubview(scoreLabel)
        scoreView.snp.makeConstraints { make in
            make.top.equalTo(playerImage.snp.top).offset(15)
            make.leading.equalTo(playerImage.snp.leading).offset(15)
            make.width.equalTo(40)
            make.height.equalTo(scoreView.snp.width)
        }
        scoreLabel.snp.makeConstraints { make in
            make.centerX.equalTo(scoreView.snp.centerX)
            make.centerY.equalTo(scoreView.snp.centerY)
        }
    }
    
    private func setupPlayerNumberConstraints() {
        contentView.addSubview(playerNumberLabel)
        playerNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(playerImage.snp.top)
            make.trailing.equalTo(playerImage.snp.trailing)
        }
    }
    
    private func setupGradientViewConstraints() {
        contentView.addSubview(gradientView)
        gradientView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.3)
        }
        contentView.bringSubviewToFront(gradientView)
    }
    
    private func setupPlayerNameConstraints() {
        gradientView.addSubview(playerName)
        playerName.snp.makeConstraints { make in
            make.leading.equalTo(gradientView.snp.leading).offset(15)
            make.trailing.equalTo(gradientView.snp.trailing).offset(-15)
            make.centerY.equalTo(gradientView.snp.centerY)
        }
    }
    
    // MARK: - Configure content
    private func configureContent() {
        guard let viewModel = viewModel else { return }
        playerNumberLabel.text = "\(viewModel.playerNumber)"
        playerImage.setImage(with: viewModel.image)
        playerName.text = viewModel.playerName
        if let score = viewModel.playerScore {
            scoreView.isHidden = false
            scoreLabel.text = "\(score)"
        }
//        layoutIfNeeded()
        contentView.backgroundColor = .clear
    }
    

}
