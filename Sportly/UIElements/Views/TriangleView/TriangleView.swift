//
//  TriangleView.swift
//  Sportly
//
//  Created by MN on 11.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

class TriangleView: UIView {
    
    private let fillColor: UIColor
    private let cornerRadius: CGFloat
    
    init(fillColor: UIColor = .white, cornerRadius: CGFloat = 16) {
        self.fillColor = fillColor
        self.cornerRadius = cornerRadius
        super.init(frame: .zero)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let view = UIView()
        view.backgroundColor = .white
        let triangle = CAShapeLayer()
        triangle.fillColor = UIColor.white.cgColor
        triangle.path = createRoundedTriangle(width: 40, height: 40, radius: 4)
        triangle.position = CGPoint(x: rect.width / 2, y: rect.height / 2)
        layer.addSublayer(triangle)
    }
    
    func createRoundedTriangle(width: CGFloat, height: CGFloat, radius: CGFloat) -> CGPath {
        let point1 = CGPoint(x: -width / 2, y: height / 2)
        let point2 = CGPoint(x: 0, y: -height / 2)
        let point3 = CGPoint(x: width / 2, y: height / 2)

        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: height / 2))
        path.addArc(tangent1End: point1, tangent2End: point2, radius: radius)
        path.addArc(tangent1End: point2, tangent2End: point3, radius: radius)
        path.addArc(tangent1End: point3, tangent2End: point1, radius: radius)
        path.closeSubpath()
        return path
    }
}
