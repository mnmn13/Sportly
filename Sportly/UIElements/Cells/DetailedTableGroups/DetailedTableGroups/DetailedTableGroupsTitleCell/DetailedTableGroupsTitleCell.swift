//
//  DetailedTableGroupsTitleCell.swift
//  Sportly
//
//  Created by MN on 23.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class DetailedTableGroupsTitleCell: UICollectionViewCell {
    
    static let identifier = String(describing: DetailedTableGroupsTitleCell.self)
    
    var viewModel: DetailedTableGroupsTitleCellVM?
    
    // MARK: - Group label
    private lazy var groupLabel: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: 16, weight: .heavy)
        label.font = FontFamily.Montserrat.Montserrat_ExtraBold(size: 16)
        label.textAlignment = .center
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
    func configure(_ viewModel: DetailedTableGroupsTitleCellVM) {
        self.viewModel = viewModel
        configureContent()
        
    }
    
    // MARK: - Constraints
    private func configureConstraints() {
        contentView.addSubview(groupLabel)
        
        groupLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
//            make.top.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Configure content
    private func configureContent() {
        groupLabel.text = viewModel?.group ?? ""
//        contentView.layer.borderColor = UIColor.black.cgColor
//        contentView.layer.borderWidth = 1
        contentView.backgroundColor = UIColor(projColors: .gray)
        contentView.layer.cornerRadius = min(bounds.width, bounds.height) / 2
        layer.masksToBounds = true
    }
}
