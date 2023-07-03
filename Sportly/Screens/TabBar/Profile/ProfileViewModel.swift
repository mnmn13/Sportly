//
//  ProfileViewModel.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

protocol ProfileViewModelType {}

class ProfileViewModel: ProfileViewModelType {
    fileprivate let coordinator: ProfileCoordinatorType
    init(coordinator: ProfileCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
    }
}
