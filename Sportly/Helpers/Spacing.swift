//
//  Spacing.swift
//  Sportly
//
//  Created by MN on 14.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

struct Spacing {
    
    var width: CGFloat?
    var height: CGFloat?
    
    init(width: CGFloat? = nil, height: CGFloat? = nil) {
        self.width = width
        self.height = height
    }
    ///Returns UIView with initial spacing
    ///Basically, only one parameter is used during initialization so that the StackView can be more flexible.
    func getSpacingView(width: CGFloat?, height: CGFloat?) -> UIView {
        var spacingView = UIView()
        spacingView.backgroundColor = .clear
        spacingView.translatesAutoresizingMaskIntoConstraints = false
        if width != nil && height == nil {
            guard let spacing = width else { fatalError("You must fill in the spacing field correctly"); return .init() }
            spacingView.widthAnchor.constraint(equalToConstant: spacing).isActive = true
        } else if width == nil && height != nil {
            guard let spacing = height else { fatalError("You must fill in the spacing field correctly"); return .init() }
            spacingView.heightAnchor.constraint(equalToConstant: spacing).isActive = true
        } else {
            guard let width = width, let height = height else { fatalError("You must fill in the width and height field correctly"); return .init() }
            spacingView.widthAnchor.constraint(equalToConstant: width).isActive = true
            spacingView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        return spacingView
    }
    

    
    
}
public func getSpacing(width: CGFloat?, height: CGFloat?) -> UIView {
    let spacing = Spacing(width: width, height: height)
    return spacing.getSpacingView(width: width, height: height)
}
