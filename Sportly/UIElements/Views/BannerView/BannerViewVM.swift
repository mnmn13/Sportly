//
//  BannerViewVM.swift
//  Sportly
//
//  Created by MN on 11.07.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct BannerViewVM {
    
    let state: BannerViewState
    let message: String
}

enum BannerViewState {
    case info
    case success
    case warning
    case error
}
