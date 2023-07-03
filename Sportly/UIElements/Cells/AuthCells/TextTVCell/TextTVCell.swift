//
//  TextTVCell.swift
//  Sportly
//
//  Created by MN on 28.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class TextTVCell: UITableViewCell {
    
    @IBOutlet weak var textLabelOutlet: UILabel!
    static let identifier = String(describing: TextTVCell.self)
    
    var viewModel: TextTVCellVM!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: TextTVCellVM) {
        self.viewModel = model
        selectionStyle = .none
        switch viewModel.cellType {
        case .title:
            textLabelOutlet.text = viewModel.text
            textLabelOutlet.font = .systemFont(ofSize: 40, weight: .heavy)
            textLabelOutlet.textAlignment = .left
            textLabelOutlet.numberOfLines = 0
        case .upperTFText:
            break
        }
    }
    
}
