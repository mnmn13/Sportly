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
        return label
    }()
    
    private lazy var playerImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var scoreView: UIView = {
        let view = RoundedUIView()
        view.backgroundColor = Asset.Colors.green1.systemColor
        view.isHidden = true
        return view
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
        contentView.addSubview(playerNumberLabel)
        contentView.addSubview(playerImage)
        playerImage.addSubview(scoreView)
        
        playerNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.trailing.equalTo(contentView.snp.trailing)
        }
        
        playerImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
        }
        
        scoreView.snp.makeConstraints { make in
            make.top.equalTo(playerImage.snp.top).offset(-15)
            make.leading.equalTo(playerImage.snp.leading).offset(-15)
            make.width.equalTo(20)
            make.height.equalTo(scoreView.snp.width)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(scoreView.snp.top).offset(-15)
            make.leading.equalTo(scoreView.snp.leading).offset(-15)
            make.width.equalTo(20)
        }
    }
    
    // MARK: - Configure content
    private func configureContent() {
        guard let viewModel = viewModel else { return }
        playerNumberLabel.text = "\(viewModel.playerNumber)"
        playerImage.setImage(with: viewModel.image)
        if let score = viewModel.playerScore {
            scoreView.isHidden = false
            scoreLabel.text = "\(score)"
        }
    }
}
