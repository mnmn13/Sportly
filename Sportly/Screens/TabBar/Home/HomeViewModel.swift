//
//  HomeViewModel.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

protocol HomeViewModelType {}

class HomeViewModel: HomeViewModelType {
    
    fileprivate let coordinator: HomeCoordinatorType
    
    init(coordinator: HomeCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
    }
    
    
    
}
