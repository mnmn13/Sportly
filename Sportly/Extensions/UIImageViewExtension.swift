//
//  UIImageViewExtension.swift
//  Sportly
//
//  Created by MN on 08.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    // Set Image with URL
    
    func setImage(with url: URL) {
        let size = bounds.size != .zero ? bounds.size : .init(width: 300, height: 300)
        let processor = DownsamplingImageProcessor(size: size)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url,
                         placeholder: UIImage(named: "placeholderImage"),
                         options: [.processor(processor),
                                   .scaleFactor(UIApplication.shared.keyWindow?.screen.scale ?? 3),
                                   .transition(.fade(0.5)),
                                   .cacheOriginalImage]) { result in
            switch result {
            case .success(let value):
                print("Task done for: \(url.path)")
                self.image = value.image
                ImageCache.default.store(value.image, forKey: url.path)
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
    func setImage(with url: String) {
        guard let url = URL(string: url) else { return }
        setImage(with: url)
    }
}

extension UIImageView {
    
    func makeRounded() {
        
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
