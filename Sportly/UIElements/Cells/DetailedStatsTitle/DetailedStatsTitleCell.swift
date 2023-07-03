//
//  DetailedStatsTitleCell.swift
//  Sportly
//
//  Created by MN on 21.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class DetailedStatsTitleCell: UITableViewCell {
    
    static let identifier = String(describing: DetailedStatsTitleCell.self)
    
    var viewModel: DetailedStatsTitleVM?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: 26, weight: .heavy)
        label.font = FontFamily.Montserrat.Montserrat_ExtraBold(size: 26)
        label.contentMode = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    // MARK: - Configure view model
    func configure(_ viewModel: DetailedStatsTitleVM) {
        self.viewModel = viewModel
        configureContent()
    }
    
    // MARK: - Constraints
    func configureConstraints() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
//            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    // MARK: - Configure content
    func configureContent() {
        guard let viewModel = viewModel else { fatalError("View model is nil") }
        titleLabel.text = viewModel.title
    }
}
