//
//  WelcomeSignUpEmailCell.swift
//  Sportly
//
//  Created by MN on 26.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class WelcomeSignUpEmailCell: UITableViewCell {
    
    @IBOutlet weak var signUpWithEmailButton: UIButton!
    
    static let identifier = String(describing: WelcomeSignUpEmailCell.self)
    var viewModel: WelcomeSignUpEmailCellVM!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: WelcomeSignUpEmailCellVM) {
        self.viewModel = model


        signUpWithEmailButton.tintColor = viewModel.buttonColor
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    @IBAction func signUpWithEmailButtonAction(_ sender: Any) {
        viewModel.actionClosure?()
    }
}
