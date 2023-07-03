//
//  WelcomeLogoCell.swift
//  Sportly
//
//  Created by MN on 26.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class WelcomeLogoCell: UITableViewCell {

    @IBOutlet weak var logo: UIImageView!
    
    var viewModel: WelcomeLogoCellVM!
    static let identifier = String(describing: WelcomeLogoCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization cod
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(with model: WelcomeLogoCellVM) {
        self.viewModel = model
        logo.image = viewModel.image
        selectionStyle = .none
//        backgroundColor = viewModel.bgColor
        backgroundColor = .clear
    }
    
}
