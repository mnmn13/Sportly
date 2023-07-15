//
//  SimpleTFCell.swift
//  Sportly
//
//  Created by MN on 26.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class SimpleTFCell: UITableViewCell {

    static let identifier = String(describing: SimpleTFCell.self)
    
    private var viewModel: SimpleTFCellVM?
    
    private var secureTextEntry: Bool = true
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Montserrat.Montserrat_Regular(size: 8)
        label.isHidden = true
        return label
    }()
    
    private lazy var placeHolder: UITextField = {
        let placeHolder = UITextField()
        placeHolder.delegate = self
        placeHolder.font = FontFamily.Montserrat.Montserrat_Regular(size: 14)
        placeHolder.isSecureTextEntry = false
        placeHolder.autocorrectionType = .no
        placeHolder.returnKeyType = .next
        placeHolder.autocapitalizationType = .none
        placeHolder.tintColor = Asset.Colors.green1.systemColor
        return placeHolder
    }()
    
    private let progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.progress = 1
        bar.progressTintColor = Asset.Colors.gray.systemColor
        return bar
    }()
    
    private let eyeImage: UIImageView = {
        let image = RoundedImageView()
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    // MARK: - Configure
    func configure(_ viewModel: SimpleTFCellVM) {
        self.viewModel = viewModel
        setupContent()
    }
    
    private func bindForProgressState() {
        guard let viewModel = viewModel else { fatalError() }
        viewModel.progressStateCallBack = { [weak self] state in
            guard let self else { return }
            switch state {
            case .undefined:
                self.progressBar.progressTintColor = Asset.Colors.gray.systemColor
            case .confirmed:
                self.progressBar.progressTintColor = Asset.Colors.green1.systemColor
            case .unverified:
                self.progressBar.progressTintColor = Asset.Colors.red.systemColor
            }
        }
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        contentView.addSubview(typeLabel)
        contentView.addSubview(placeHolder)
        contentView.addSubview(progressBar)
        
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading).offset(10)
        }
        
        placeHolder.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.bottom.equalTo(contentView.snp.bottom).offset(5)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.leading.equalTo(contentView.snp.leading).offset(10)
        }
        
        progressBar.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.width.equalTo(4)
        }
    }
    
    // MARK: - Content
    private func setupContent() {
        guard let viewModel = viewModel else { fatalError() }
        typeLabel.text = viewModel.cellType.labelName
        placeHolder.text = viewModel.cellType.labelName
        
        if viewModel.cellType == .passwordCreate || viewModel.cellType == .passwordConfirm { setupTFForPassword() }
    }
    
    private func setupTFForPassword() {
        placeHolder.isSecureTextEntry = secureTextEntry
        eyeImage.image = UIImage(systemName: "eye")
        placeHolder.rightView = eyeImage
        let action = UIGestureRecognizer(target: self, action: #selector(eyeTapped))
        placeHolder.rightView?.addGestureRecognizer(action)
    }
    
    @objc private func eyeTapped() {
        secureTextEntry = !secureTextEntry
        placeHolder.isSecureTextEntry = secureTextEntry
        eyeImage.image = secureTextEntry ? UIImage(systemName: "eye") : UIImage(systemName: "eye.slash")
    }
    
    private func updateTopLabel(_ text: String?) {
        guard let text = text else { typeLabel.isHidden = true; return }
        typeLabel.isHidden = false
    }
    
    private func animateProgressBar() {
        guard let viewModel = viewModel else { fatalError() }
        guard let gradientLayer = progressBar.layer.sublayers?.first as? CAGradientLayer else {
            return
        }
        
        var fromColors = [Asset.Colors.gray.systemColor.cgColor, Asset.Colors.gray3.systemColor.cgColor]
//        var toColors = [Asset.Colors.gray3.systemColor.cgColor, Asset.Colors.gray.systemColor.cgColor]
        
        var toColors: [CGColor] {
            switch viewModel.validationPassed {
            case .none: return [Asset.Colors.gray3.systemColor.cgColor, Asset.Colors.gray.systemColor.cgColor]
            case .some(let bool):
                if bool {
                    return [Asset.Colors.green1.systemColor.cgColor, Asset.Colors.green1.systemColor.cgColor]
                } else {
                    return [Asset.Colors.red.systemColor.cgColor, Asset.Colors.red.systemColor.cgColor]
                }
            }
        }
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.5) // Установите желаемую продолжительность анимации
        CATransaction.setCompletionBlock { [weak self] in
            guard let self else { return }
            if viewModel.validationPassed == nil {
                self.animateProgressBar()
            }
        }
        
        let colorAnimation = CABasicAnimation(keyPath: "colors")
        colorAnimation.fromValue = fromColors
        colorAnimation.toValue = toColors
        
        gradientLayer.colors = toColors
        gradientLayer.add(colorAnimation, forKey: "colorAnimation")
        
        CATransaction.commit()
    }
}

extension SimpleTFCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let viewModel = viewModel else { fatalError() }
        switch viewModel.cellType {
        case .userName: break
        case .email: break
        default: break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        updateTopLabel(textField.text)
        guard let viewModel = viewModel else { fatalError() }
        switch viewModel.cellType {
            
        case .email:
            break
        case .passwordCreate:
            break
        case .passwordConfirm:
            break
        case .userName:
            break
        case .firstName:
            break
        case .lastName:
            break
        }
        return true
    }
}
