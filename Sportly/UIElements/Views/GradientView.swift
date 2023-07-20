//
//  GradientView.swift
//  Sportly
//
//  Created by MN on 18.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class GradientView: UIView {

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    private var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupGradient()
    }

    private func setupGradient() {
        let startColor = UIColor.clear.cgColor
        let midColor = UIColor.black.withAlphaComponent(0.2).cgColor
        let endColor = UIColor.black.withAlphaComponent(0.4).cgColor

        gradientLayer.colors = [startColor, midColor, endColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
    }
}
