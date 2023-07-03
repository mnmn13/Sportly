//
//  WelcomeTitleCell.swift
//  Sportly
//
//  Created by MN on 26.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class WelcomeTitleCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = String(describing: WelcomeTitleCell.self)
    
    private var viewModel: WelcomeTitleCellVM!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: WelcomeTitleCellVM) {
        self.viewModel = model
        titleLabel.text = viewModel.title
        backgroundColor = .clear
        selectionStyle = .none
    }
    
}
