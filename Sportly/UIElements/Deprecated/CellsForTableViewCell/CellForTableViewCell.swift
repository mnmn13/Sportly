//
//  CellForTableViewCell.swift
//  Sportly
//
//  Created by MN on 14.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class CellForTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: CellForTableViewCell.self)
    
    var viewModel: CellForTableViewCellVM?
    
    private let leagueLogo: UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    private let leagueLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        label.textColor = .black
        return label
    }()
    
    private let chevronImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")!
        imageView.contentMode = .right
        imageView.tintColor = .darkGray
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLeagueLogoConstraints()
        setupLeagueLogoLabelConstraints()
        setupChevronConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        contentView.layoutMargins = .zero
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    func configure(viewModel: CellForTableViewCellVM) {
        self.viewModel = viewModel
        configureContent()
    }
    //MARK: - Constraints
    private func setupLeagueLogoConstraints() {
        leagueLogo.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(leagueLogo)
        leagueLogo.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView).offset(15)
            make.size.equalTo(45)
        }
    }
    
    private func setupLeagueLogoLabelConstraints() {
        contentView.addSubview(leagueLabel)
        leagueLabel.snp.makeConstraints { make in
            make.leading.equalTo(leagueLogo.snp.trailing).offset(8)
            make.centerY.equalTo(leagueLogo.snp.centerY)
//            make.trailing.lessThanOrEqualTo(chevronImage).offset(-10).priority(.high)
        }
        
//        leagueLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//        leagueLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setupChevronConstraints() {
        contentView.addSubview(chevronImage)
        chevronImage.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-15)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(20)
        }
    }
    //MARK: - Configure data
    private func configureContent() {
        guard let viewModel = viewModel else { fatalError("ViewModel is nil") }
        leagueLogo.setImage(with: viewModel.logo)
        leagueLabel.text = viewModel.leagueTitle
    }
    
}
