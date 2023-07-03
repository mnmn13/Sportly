//
//  PlaceholderTVCell.swift
//  Sportly
//
//  Created by MN on 27.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class PlaceholderTVCell: UITableViewCell {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var progressView: UIProgressView!
    
    let button = UIButton(type: .custom)
    
    static let identifier = String(describing: PlaceholderTVCell.self)
    var viewModel: PlaceholderTVCellVM!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupTF() {
        textField.delegate = self
        
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.returnKeyType = .next
        textField.layer.cornerRadius = 15
        textField.isSecureTextEntry = false
        textField.borderStyle = .none
        textField.tintColor = UIColor(projColors: .green1)
    }
    
    func setupForPassword() {
        button.setTitle("Show", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitleColor(.lightGray, for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(textField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(5), height: CGFloat(5))
        button.addTarget(self, action: #selector(switchTextEntry), for: .touchUpInside)
        textField.isSecureTextEntry = true
        textField.rightView = button
//        textField.rightViewMode = .always

    }
    
    @objc func switchTextEntry() {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        if textField.isSecureTextEntry {
            button.setTitle("Show", for: .normal)
            viewModel.validate(value: viewModel.bufferValue)
        } else {
            button.setTitle("Hide", for: .normal)
            viewModel.validate(value: viewModel.bufferValue)
        }
    }
    
    func setupPV() {
        progressView.progress = 1
        progressView.tintColor = viewModel.normalPVColor
        bindForPVColor()
    }
    
    private func bindForPVColor() {
        viewModel.PVColor = { [weak self] color in
            guard let self = self else { return }
            switch color {
            case .grey:
                self.progressView.tintColor = self.viewModel.normalPVColor
            case .green:
                self.progressView.tintColor = self.viewModel.greenPVColor
            case .red:
                self.progressView.tintColor = self.viewModel.redPVColor
            }
        }
    }
    
    private func bindForPasswordValidCB() {
        viewModel.callBackService?.passwordCallBack = { [weak self] password in
            guard let self = self else { return }
            self.viewModel.password = password
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // Вызовите метод обновления видимости кнопки при каждом изменении выделения текста
        updateRightViewVisibility()
    }
    
    private func updateRightViewVisibility() {
        guard let text = textField.text, !text.isEmpty else {
            textField.rightViewMode = .never
            return
        }
        
        textField.rightViewMode = .always
    }
    
    func configure(with model: PlaceholderTVCellVM) {
        self.viewModel = model
        setupTF()
        setupPV()
        selectionStyle = .none
        textField.placeholder = viewModel.cellType.placeHolder
        switch viewModel.cellType {
        case .createPassword:
            setupForPassword()
        case .confirmPassword:
            bindForPasswordValidCB()
            setupForPassword()
        default: break
        }
    }
}

extension PlaceholderTVCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
//        viewModel.validate(value: text)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let range = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: range, with: string)
            viewModel.validate(value: updatedText)
            viewModel.bufferValue = updatedText
        }
        return true
    }
}
