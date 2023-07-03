//
//  LogosAndLabelCell.swift
//  Sportly
//
//  Created by MN on 20.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class LogosAndLabelCell: UITableViewCell {
    
    static let identifier = String(describing: LogosAndLabelCell.self)
    
    private var viewModel: LogosAndLabelVM?
    
    private var borderWidth: CGFloat = 1
    private var SVSpacing: CGFloat = 1
    private var SVSize: Int = 40
    
    private lazy var firstRankLogo: UIImageView = {
        let imageView = RoundedImageView()
//        imageView.makeRounded()
//        imageView.layer.borderColor = UIColor(named: "gray3")?.cgColor
        imageView.layer.borderColor = Asset.Colors.gray3.systemColor.cgColor
        imageView.layer.borderWidth = borderWidth
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let firstRankLabel: UILabel = {
        let label = UILabel()
        label.text = "1st"
        label.contentMode = .center
//        label.font = .systemFont(ofSize: 8, weight: .regular)
        label.font = FontFamily.Montserrat.Montserrat_Regular(size: 8)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var secondRankLogo: UIImageView = {
        let imageView = RoundedImageView()
//        imageView.layer.borderColor = UIColor(named: "gray3")?.cgColor
        imageView.layer.borderColor = Asset.Colors.gray3.systemColor.cgColor
        imageView.layer.borderWidth = borderWidth
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let secondRankLabel: UILabel = {
        let label = UILabel()
        label.text = "2nd"
        label.contentMode = .center
//        label.font = .systemFont(ofSize: 8, weight: .regular)
        label.font = FontFamily.Montserrat.Montserrat_Regular(size: 8)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var thirdRankLogo: UIImageView = {
        let imageView = RoundedImageView()
//        imageView.layer.borderColor = UIColor(named: "gray3")?.cgColor
        imageView.layer.borderColor = Asset.Colors.gray3.systemColor.cgColor
        imageView.layer.borderWidth = borderWidth
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let thirdRankLabel: UILabel = {
        let label = UILabel()
        label.text = "3rd"
//        label.font = .systemFont(ofSize: 8, weight: .regular)
        label.font = FontFamily.Montserrat.Montserrat_Regular(size: 8)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private let oherRanksLabel: UILabel = {
       let label = UILabel()
//        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.font = FontFamily.Montserrat.Montserrat_Bold(size: 10)
        label.contentMode = .center
        label.textColor = .white
        return label
    }()
    
    private let nextMatchLabel: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.font = FontFamily.Montserrat.Montserrat_Bold(size: 18)
//        label.textColor = UIColor(named: "gray2")!
        label.textColor = Asset.Colors.gray2.systemColor
        return label
    }()
    
    private let spaceLabel: UILabel = {
       let label = UILabel()
        label.text = "4th"
//        label.font = .systemFont(ofSize: 8, weight: .regular)
        label.font = FontFamily.Montserrat.Montserrat_Regular(size: 8)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
//        label.textColor = UIColor(projColors: .gray)
        label.textColor = Asset.Colors.gray.systemColor
        label.isHidden = false
        return label
    }()
    
    private lazy var firstRankSV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstRankLogo, firstRankLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = SVSpacing
        return stackView
    }()
    
    private lazy var secondRankSV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [secondRankLogo, secondRankLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = SVSpacing
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private lazy var thirdRankSV: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [thirdRankLogo, thirdRankLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = SVSpacing
        
        return stackView
    }()
    
    private lazy var otherRanks: UIView = {
        let view = RoundedUIView()
//        view.layer.borderColor = UIColor(named: "gray3")?.cgColor
        view.layer.borderColor = Asset.Colors.gray3.systemColor.cgColor
        view.layer.borderWidth = borderWidth
//        view.backgroundColor = UIColor(named: "gray3")
        view.backgroundColor = Asset.Colors.gray3.systemColor
        view.addSubview(oherRanksLabel)
        return view
    }()
    
    private lazy var otherRanksSV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [otherRanks, spaceLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = SVSpacing
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        firstRankLogo.layer.cornerRadius = firstRankLogo.bounds.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    // MARK: - Configure
    func configure(_ viewModel: LogosAndLabelVM) {
        self.viewModel = viewModel
        configureContent()
    }
    
    private func setupConstraints() {
        
        //AddSubviews
        contentView.addSubview(firstRankSV)
        contentView.addSubview(secondRankSV)
        contentView.addSubview(thirdRankSV)
//        contentView.addSubview(otherRanks)
        contentView.addSubview(otherRanksSV)
        contentView.addSubview(nextMatchLabel)
        
        otherRanks.addSubview(oherRanksLabel)
        
        //Image view
        
        firstRankLogo.snp.makeConstraints { make in
            make.height.equalTo(firstRankLogo.snp.width)
        }
        
        secondRankLogo.snp.makeConstraints { make in
            make.height.equalTo(secondRankLogo.snp.width)
        }
        
        thirdRankLogo.snp.makeConstraints { make in
            make.height.equalTo(thirdRankLogo.snp.width)
        }
        
        otherRanks.snp.makeConstraints { make in
            make.height.equalTo(otherRanks.snp.width)
            make.size.equalTo(32)
        }
        
        oherRanksLabel.snp.makeConstraints { make in
            make.centerY.equalTo(otherRanks.snp.centerY)
            make.centerX.equalTo(otherRanks.snp.centerX)
        }
        
        //FirstRank SV
        firstRankSV.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(12)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(SVSize)
        }
        
        //SecondRank SV
        secondRankSV.snp.makeConstraints { make in
            make.leading.equalTo(firstRankSV.snp.trailing).offset(-8)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(SVSize)
        }
        //ThirdRank SV
        thirdRankSV.snp.makeConstraints { make in
            make.leading.equalTo(secondRankSV.snp.trailing).offset(-8)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(SVSize)
        }
        
        //OtherRanks SV
        otherRanksSV.snp.makeConstraints { make in
            make.leading.equalTo(thirdRankSV.snp.trailing).offset(-8)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(SVSize)
        }
        
        //NextMatch label
        nextMatchLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-15)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    private func configureContent() {
        guard let viewModel = viewModel else { fatalError("ViewModel is nil") }
        // Images
        firstRankLogo.setImage(with: viewModel.firstLogo ?? "")
        secondRankLogo.setImage(with: viewModel.secondLogo ?? "")
        thirdRankLogo.setImage(with: viewModel.thirdLogo ?? "")
        
        //Labels
        oherRanksLabel.text = "+\(viewModel.moreRanks ?? 0)"
        nextMatchLabel.text = "Next game Oct 10"
        
        contentView.layoutIfNeeded()
    }
}
