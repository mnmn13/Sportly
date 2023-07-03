//
//  UIImageExtension.swift
//  Sportly
//
//  Created by MN on 27.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImage {
    static func loadImage(with urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let url = URL(string: urlString) {
            // Check if the image is already cached
            if let cacheImage = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: urlString) {
                completion(cacheImage)
                return
            }

            // If the image is not cached, download and cache it
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result {
                case .success(let value):
                    completion(value.image)
                case .failure(let error):
                    print("Error retrieving image: \(error)")
                    completion(nil)
                }
            }
        } else {
            completion(nil)
        }
    }
}

