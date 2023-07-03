//
//  SkeletonHelper.swift
//  Sportly
//
//  Created by MN on 17.06.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import SkeletonView

class SkeletonHelper {
    
    static let shared = SkeletonHelper()
    
    private init() {}
    
    func showSkeleton(_ view: UIView) {
        view.isSkeletonable = true
        view.showAnimatedSkeleton()
    }
    
    func hideSkeleton(_ view: UIView) {
        view.hideSkeleton()
    }
}
