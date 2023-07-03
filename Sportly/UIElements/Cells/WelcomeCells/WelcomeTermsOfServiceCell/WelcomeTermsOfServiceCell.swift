//
//  WelcomeTermsOfServiceCell.swift
//  Sportly
//
//  Created by MN on 26.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class WelcomeTermsOfServiceCell: UITableViewCell {
    
    @IBOutlet weak var termsLabel: UILabel!
    static let identifier = String(describing: WelcomeTermsOfServiceCell.self)
    var viewModel: WelcomeTermsOfServiceCellVM!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: WelcomeTermsOfServiceCellVM) {
        self.viewModel = model
        termsLabel.text = viewModel.text
        termsLabel.numberOfLines = 0
        selectionStyle = .none
        setupLabel()
    }
    
    private func setupLabel() {
        let fullText = "By continuing, you agree to Sportly's\n Terms of Service and Privacy Policy"
        let attributedText = NSMutableAttributedString(string: fullText)

        let termsRange = (fullText as NSString).range(of: "Terms of Service")
        let termsLinkAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17, weight: .bold),
            .foregroundColor: UIColor.black,
            .link: "terms"
        ]
        attributedText.setAttributes(termsLinkAttributes, range: termsRange)

        let privacyRange = (fullText as NSString).range(of: "Privacy Policy")
        let privacyLinkAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17, weight: .bold),
            .link: "privacy",
            .foregroundColor: UIColor.black
        ]
        attributedText.setAttributes(privacyLinkAttributes, range: privacyRange)

        termsLabel.attributedText = attributedText

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        termsLabel.addGestureRecognizer(tapGesture)
        termsLabel.isUserInteractionEnabled = true
    }
    
    @objc private func labelTapped(_ gesture: UITapGestureRecognizer) {
        guard let label = gesture.view as? UILabel else { return }
        
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: label.bounds.size)
        let textStorage = NSTextStorage(attributedString: label.attributedText ?? NSAttributedString())
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        let location = gesture.location(in: label)
        let characterIndex = layoutManager.characterIndex(for: location, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
//        if let link = label.attributedText?.attribute(.link, at: characterIndex, effectiveRange: nil) as? String {
//            // Открыть страницу, связанную с указанной ссылкой
//            UIApplication.shared.open(URL(string: link)!)
//        }
        
        if let action = label.attributedText?.attribute(.link, at: characterIndex, effectiveRange: nil) as? String {
                // Вызвать свою функцию или метод вместо открытия ссылки
                performCustomAction(action)
            }
    }
    
    func performCustomAction(_ action: String) {
        if action == "terms" {
            showTermsPage()
        } else if action == "privacy" {
            showPrivacyPage()
        }
    }

    func showTermsPage() {
        viewModel.termsOfServiceCallBack?(.termsOfService)
    }

    func showPrivacyPage() {
        viewModel.termsOfServiceCallBack?(.privacyPolicy)
    }
}
