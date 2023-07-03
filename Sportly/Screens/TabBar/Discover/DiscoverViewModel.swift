//
//  DiscoverViewModel.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

protocol DiscoverViewModelType {}

class DiscoverViewModel: DiscoverViewModelType {
    fileprivate let coordinator: DiscoverCoordinatorType
    
    init(coordinator: DiscoverCoordinator, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
    }
}
