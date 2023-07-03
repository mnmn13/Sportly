//
//  WelcomeWithoutRegCell.swift
//  Sportly
//
//  Created by MN on 26.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class WelcomeWithoutRegCell: UITableViewCell {
    
    static let identifier = String(describing: WelcomeWithoutRegCell.self)
    var viewModel: WelcomeWithoutRegCellVM!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: WelcomeWithoutRegCellVM) {
        self.viewModel = model
        selectionStyle = .none
    }
    
}
