//
//  UIColor.swift
//  Sportly
//
//  Created by MN on 11.05.2023.
//

import UIKit

public func RGBAColor(_ red: Float, _ green: Float, _ blue: Float, _ alpha: Float) -> UIColor {
    let color = UIColor(red: CGFloat(red / 255.0), green: CGFloat(green / 255.0), blue: CGFloat(blue / 255.0), alpha: CGFloat(alpha))
    return color
}

public func RGBColor(_ red: Float, _ green: Float, _ blue: Float) -> UIColor {
    return RGBAColor(red, green, blue, 1.0)
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
    
    convenience init(projColors: ProjColors) {
        switch projColors {
        case .green1: self.init(named: "green1")!
        case .green2: self.init(named: "green2")!
        case .gray: self.init(named: "gray")!
        case .purple: self.init(named: "purple")!
        case .red: self.init(named: "red")!
        case .logoBG: self.init(named: "logoBG")!
        case .grayPV: self.init(named: "grayPV")!
        case .background: self.init(named: "background")!
        }
    }
    
}

enum ProjColors {
    case red
    case green1
    case green2
    case gray
    case purple
    case logoBG
    case grayPV
    case background
}


//public let projGreen1 = UIColor(named: "green1")
//public let projGreen2 = UIColor(named: "green2")
//public let projGray = UIColor(named: "gray")
//public let projPurple = UIColor(named: "purple")
//public let projRed = UIColor(named: "red")
