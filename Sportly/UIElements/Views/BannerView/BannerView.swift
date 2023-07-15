//
//  BannerView.swift
//  Sportly
//
//  Created by MN on 11.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class BannerView: UIView {
    
    private var viewModel: BannerViewVM?
    
    private let triangle: TriangleView = {
        let triangle = TriangleView()
        triangle.isHidden = true
//        triangle.backgroundColor = .white
        return triangle
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Montserrat.Montserrat_Medium(size: 18)
        label.numberOfLines = 0
        label.textAlignment = .natural
        return label
    }()
    
    private let circle: UIView = {
        let view = RoundedUIView()
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    private let statusView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let checkMarkImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "checkmark")?.withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        image.tintColor = Asset.Colors.bannerGreen.systemColor
        return image
    }()
    
    private let symbolTLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Montserrat.Montserrat_Medium(size: 24)
        label.text = "!"
        label.textColor = Asset.Colors.bannerBlue.systemColor
        label.textAlignment = .center
        return label
    }()
    
    private let symbolRLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Montserrat.Montserrat_Medium(size: 24)
        label.text = "i"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.layer.borderWidth = 2
        setupConstraints()
    }
    
    func configure(_ viewModel: BannerViewVM) {
        self.viewModel = viewModel
        setupContent()
    }
    
    private func setupConstraints() {
        self.addSubview(statusView)
        self.addSubview(textLabel)

        
        self.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
        
        statusView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(10)
//            make.top.equalTo(self.snp.top).offset(10)
//            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(60)
            make.height.equalTo(statusView.snp.width)
        }
        
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(statusView.snp.trailing).offset(20)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
            make.centerY.equalTo(self.snp.centerY)
        }
        setupRoundedIconConstraints()
        setupTriangleIconConstraints()
    }
    
    private func setupRoundedIconConstraints() {
        statusView.addSubview(circle)
        circle.addSubview(checkMarkImage)
        circle.addSubview(symbolRLabel)
        
        circle.snp.makeConstraints { make in
            make.height.equalTo(circle.snp.width)
            make.centerY.equalTo(statusView.snp.centerY)
            make.centerX.equalTo(statusView.snp.centerX)
            make.size.equalTo(40)
        }
        
        checkMarkImage.snp.makeConstraints { make in
            make.centerY.equalTo(circle.snp.centerY)
            make.centerX.equalTo(circle.snp.centerX)
        }
        
        symbolRLabel.snp.makeConstraints { make in
            make.centerY.equalTo(circle.snp.centerY)
            make.centerX.equalTo(circle.snp.centerX)
        }
    }
    
    private func setupTriangleIconConstraints() {
        statusView.addSubview(triangle)
        insertSubview(symbolTLabel, aboveSubview: triangle)
//        triangle.addSubview(symbolTLabel)
//        triangle.addLabel(symbolTLabel)
        
        triangle.snp.makeConstraints { make in
            make.centerY.equalTo(statusView.snp.centerY).offset(-2)
            make.centerX.equalTo(statusView.snp.centerX)
            make.width.equalTo(50)
            make.height.equalTo(triangle.snp.width)
//            make.width.equalTo(200)
//            make.height.equalTo(200)
//            make.size.equalTo(20)
        }
        
        symbolTLabel.snp.makeConstraints { make in
            make.centerY.equalTo(triangle.snp.centerY).offset(2)
            make.centerX.equalTo(triangle.snp.centerX)
//            make.height.equalTo(20)
//            make.width.equalTo(20)
        }
    }
    
    private func setupContent() {
        guard let viewModel = viewModel else { fatalError() }
        textLabel.text = viewModel.message
        switch viewModel.state {
        case .info:
            self.layer.borderColor = Asset.Colors.bannerBlueBorder.systemColor.cgColor
            self.backgroundColor = Asset.Colors.bannerBlueTranslucent.systemColor
            circle.isHidden = false
            statusView.backgroundColor = Asset.Colors.bannerBlue.systemColor
            checkMarkImage.isHidden = true
            symbolTLabel.isHidden = true
        case .success:
            self.layer.borderColor = Asset.Colors.bannerGreenBorder.systemColor.cgColor
            self.backgroundColor = Asset.Colors.bannerGreenBorder.systemColor.withAlphaComponent(0.8)
            circle.isHidden = false
            statusView.backgroundColor = Asset.Colors.bannerGreen.systemColor
            symbolRLabel.isHidden = true
            
        case .warning:
            self.layer.borderColor = Asset.Colors.bannerOrangeBorder.systemColor.cgColor
            self.backgroundColor = Asset.Colors.bannerOrangeTranslucent.systemColor.withAlphaComponent(0.8)
            triangle.isHidden = false
//            triangle.fillColor = .white
            statusView.backgroundColor = Asset.Colors.bannerOrange.systemColor
            symbolTLabel.textColor = Asset.Colors.bannerOrange.systemColor
            symbolTLabel.isHidden = false
        case .error:
            self.layer.borderColor = Asset.Colors.bannerRedBorder.systemColor.cgColor
            self.backgroundColor = Asset.Colors.bannerRedBorder.systemColor.withAlphaComponent(0.8)
            triangle.isHidden = false
            statusView.backgroundColor = Asset.Colors.bannerRed.systemColor
            symbolTLabel.textColor = Asset.Colors.bannerRed.systemColor
        }
    }
}
