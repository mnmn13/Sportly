//
//  PlayerCardView.swift
//  Sportly
//
//  Created by MN on 01.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class PlayerCardView: UIView {
    
    private let playerPhoto: String
    private let playerNumber: Int
    private let score: Int?
    
    private lazy var playerNumberLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var playerImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var scoreView: UIView = {
        let view = RoundedUIView()
        
        if let score = score {
            let label = UILabel()
            label.text = "\(score)"
            label.textAlignment = .center
            view.addSubview(label)
            view.backgroundColor = Asset.Colors.green1.systemColor
            label.snp.makeConstraints { make in
                make.centerX.equalTo(view.snp.centerX)
                make.centerY.equalTo(view.snp.centerY)
                make.width.equalTo(20)
            }
        }
        
        return view
    }()
    
    init(playerPhoto: String, playerNumber: Int, score: Int?) {
        self.playerPhoto = playerPhoto
        self.playerNumber = playerNumber
        self.score = score
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setNeedsUpdateConstraints() {
        
        self.addSubview(playerNumberLabel)
        self.addSubview(playerImage)
        playerImage.addSubview(scoreView)
        
        playerNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.trailing.equalTo(self.snp.trailing)
        }
        
        playerImage.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
        }
        
        scoreView.snp.makeConstraints { make in
            make.top.equalTo(playerImage.snp.top).offset(-15)
            make.leading.equalTo(playerImage.snp.leading).offset(-15)
        }
        
        super.setNeedsUpdateConstraints()
    }
    
    
    
    
    
}
