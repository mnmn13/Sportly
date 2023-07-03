//
//  WelcomeOfCell.swift
//  Sportly
//
//  Created by MN on 26.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class WelcomeOfCell: UITableViewCell {
    
    @IBOutlet weak var orLabel: UILabel!
    
    static let identifier = String(describing: WelcomeOfCell.self)
    var viewModel: WelcomeOfCellVM!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(with model: WelcomeOfCellVM) {
        self.viewModel = model
        orLabel.text = viewModel.labelText
        selectionStyle = .none
    }
}
