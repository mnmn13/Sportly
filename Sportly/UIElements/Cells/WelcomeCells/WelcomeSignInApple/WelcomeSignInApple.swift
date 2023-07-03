//
//  WelcomeSignInApple.swift
//  Sportly
//
//  Created by MN on 26.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class WelcomeSignInApple: UITableViewCell {
    
    @IBOutlet weak var signInWithAppleButton: UIButton!
    
    static let identifier = String(describing: WelcomeSignInApple.self)
    var viewModel: WelcomeSignInAppleVM!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(with model: WelcomeSignInAppleVM) {
        self.viewModel = model
        signInWithAppleButton.tintColor = .black
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    
    @IBAction func signInWithAppleButtonAction(_ sender: Any) { viewModel.actionClosure?() }
}
