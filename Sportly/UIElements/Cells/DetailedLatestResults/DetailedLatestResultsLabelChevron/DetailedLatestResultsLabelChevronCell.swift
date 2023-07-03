//
//  DetailedLatestResultsLabelChevronCell.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class DetailedLatestResultsLabelChevronCell: UITableViewCell {
    
    static let identifier = String(describing: DetailedLatestResultsLabelChevronCell.self)
    
    private var viewModel: DetailedLatestResultsLabelChevronCellVM?
    
    // MARK: - Round label
    private let roundLabel: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: 15, weight: .heavy)
//        label.font = FontFamily.Montserrat.Montserrat_Regular(size: 15)
        label.font = FontFamily.Montserrat.Montserrat_ExtraBold(size: 15)
        return label
    }()
    
    // MARK: - Chevron image
    private let chevronImage: UIImageView = {
        let chevron = UIImageView()
        chevron.tintColor = .black
        return chevron
    }()
    
    // MARK: - Flags
    private lazy var flag: Bool = false
    private lazy var flag2: Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell tapped methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if !flag {
            flag = true
        } else {
            if !flag2 {
                flag2 = true
            } else {
                guard let viewModelCopy = viewModel else { return }
                viewModel?.chevronSideFlag = !viewModelCopy.chevronSideFlag
                guard let flag = viewModel?.chevronSideFlag else { return }
                didSelectRow(flag)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    // MARK: - Configure
    func configure(_ viewModel: DetailedLatestResultsLabelChevronCellVM) {
        self.viewModel = viewModel
        setupContent()
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        contentView.addSubview(roundLabel)
        contentView.addSubview(chevronImage)
        
        roundLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.lessThanOrEqualTo(chevronImage.snp.leading)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        chevronImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(20)
        }
    }
    
    // MARK: - Configure content
    private func setupContent() {
        guard let viewModel = viewModel else { fatalError("View model is nil") }
        roundLabel.text = viewModel.roundLabel
        chevronImage.image = UIImage(systemName: viewModel.downSideChevron)
    }
    
    // MARK: - Cell tapped action
    private func didSelectRow(_ selected: Bool) {
        guard let viewModelCopy = viewModel else { return }
        UIView.transition(with: chevronImage, duration: 0.3, options: .transitionFlipFromTop, animations: { [weak self] in
            guard let self = self else { return }
            if viewModelCopy.chevronSideFlag {
                self.chevronImage.image = UIImage(systemName: viewModelCopy.downSideChevron)
            } else {
                self.chevronImage.image = UIImage(systemName: viewModelCopy.upSideChevron)
            }
            viewModel?.cellTapped(selected)
        })
    }
}
