//
//  WelcomeLoginCell.swift
//  Sportly
//
//  Created by MN on 26.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class WelcomeLoginCell: UITableViewCell {
    
    @IBOutlet var logInLabel: UILabel!
    
    static let identifier = String(describing: WelcomeLoginCell.self)
    var viewModel: WelcomeLoginCellVM!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: WelcomeLoginCellVM) {
        self.viewModel = model
        logInLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
        logInLabel.isUserInteractionEnabled = true
        selectionStyle = .none
//        logInLabel = LabelButon()
        logInLabel.text = "Log in"
//        logInLabel.onClick = { [weak self] in self?.viewModel.actionClosure?() }
    }
    
    @objc func labelTapped() {
        viewModel.actionClosure?()
    }
    
}
