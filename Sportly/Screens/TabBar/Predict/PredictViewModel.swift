//
//  PredictViewModel.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

protocol PredictViewModelType {}

class PredictViewModel: PredictViewModelType {
    fileprivate let coordinator: PredictCoordinatorType
    
    init(coordinator: PredictCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
    }
}
