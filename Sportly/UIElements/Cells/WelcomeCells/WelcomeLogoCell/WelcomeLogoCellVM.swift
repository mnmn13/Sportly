//
//  WelcomeLogoCellVM.swift
//  Sportly
//
//  Created by MN on 26.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

struct WelcomeLogoCellVM {
    
//    let image = UIImage.blurImage(UIImage(named: "SportlyLogo")!)
//    let image: UIImage? = {
//        guard let ciImage = CIImage(image: UIImage(named: "SportlyLogo")!) else { return nil }
//        let blurFilter = CIFilter(name: "CIGaussianBlur")
//        blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
//        blurFilter?.setValue(20, forKey: kCIInputRadiusKey)
//        guard let outputImage = blurFilter?.outputImage else { return nil }
//        return UIImage(ciImage: outputImage)
//    }()
    
    let image = UIImage(named: "SportlyLogo2")
    let bgColor = UIColor(projColors: .logoBG)
    
    
//    func blurImage(targetImage: UIImage, blurAmount: CGFloat) -> UIImage? {
//        guard let ciImage = CIImage(image: targetImage) else { return nil }
//        let blurFilter = CIFilter(name: "CIGaussianBlur")
//        blurFilter?.setValue(ciImage, forKey: kCIInputImageKey)
//        blurFilter?.setValue(blurAmount, forKey: kCIInputRadiusKey)
//        guard let outputImage = blurFilter?.outputImage else { return nil }
//        return UIImage(ciImage: outputImage)
//    }
    
    
}
