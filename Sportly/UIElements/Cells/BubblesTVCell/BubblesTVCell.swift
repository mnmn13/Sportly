//
//  BubblesTVCell.swift
//  Sportly
//
//  Created by MN on 01.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit
import SpriteKit

class BubblesTVCell: UITableViewCell, SKSceneDelegate, SKViewDelegate {
    
    static let identifier = String(describing: BubblesTVCell.self)
    
    var viewModel: BubblesCellVM!
    var magnetic: Magnetic?

    override func awakeFromNib() {
        super.awakeFromNib()
//        setupMagneticView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(_ viewModel: BubblesCellVM) {
        self.viewModel = viewModel
        setupMagneticView()
        self.viewModel.addBubbles(magnetic: magnetic)
    }
    
    private func setupMagneticView() {
        let magneticView = MagneticView(frame: self.contentView.bounds)
        magnetic = magneticView.magnetic
        magneticView.delegate = self
        magnetic?.delegate = self
        magnetic?.backgroundColor = UIColor(projColors: .background)
        self.contentView.addSubview(magneticView)
        magneticSelectTrigger()
        magneticDeselectTrigger()
    }
    
    private func magneticSelectTrigger() {
        magnetic?.didSelect = { [weak self] node in
            guard let self = self else { return }
            
            switch viewModel.bubbleType {
            case .logo(_):
                break
            case .gameLogo:
                guard let nodes = self.magnetic?.selectedChildren else { self.viewModel.eraseNodes(); return }
                self.viewModel.selectedNodes = nodes
                self.viewModel.validate(nodes: nodes)
            case .text(_):
                break
            case .otherLogos:
                break
            case .leagues(_):
                guard let nodes = self.magnetic?.selectedChildren else { self.viewModel.eraseNodes(); return }
                self.viewModel.selectedNodes = nodes
                guard let node = self.magnetic?.childNode(withName: node.text!) else { return }
                
                self.viewModel.validateLeagues(node: node, magnetic: magnetic)
                self.animatedRemove(node)
            case .teams(_):
                guard let nodes = self.magnetic?.selectedChildren else { self.viewModel.eraseNodes(); return }
                self.viewModel.selectedNodes = nodes
                guard let node = self.magnetic?.childNode(withName: node.text!) else { return }
                
                viewModel.validateTeams(node: node, magnetic: magnetic)
                animatedRemove(node)
            }
        }
    }
    
    private func magneticDeselectTrigger() {
        magnetic?.didDeselect = { [weak self] node in
            guard let self = self else { return }
            
            switch viewModel.bubbleType {
            case .gameLogo:
                guard let nodes = self.magnetic?.selectedChildren else { self.viewModel.eraseNodes(); return }
                self.viewModel.selectedNodes = nodes
                self.viewModel.validate(nodes: nodes)
            default: break
            }
        }
    }
    
    private func animatedRemove(_ node: SKNode) {
        let fadeOutAction = SKAction.fadeAlpha(to: 0, duration: 1)
        let removeNodeAction = SKAction.removeFromParent()
        let sequenceAction = SKAction.sequence([fadeOutAction, removeNodeAction])
        
        node.run(sequenceAction)
    }
}
