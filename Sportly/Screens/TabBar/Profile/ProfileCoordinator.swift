//
//  ProfileCoordinator.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

protocol ProfileCoordinatorTransitions: AnyObject {}

protocol ProfileCoordinatorType {}

class ProfileCoordinator: ProfileCoordinatorType {
    
    private let navigationController: UINavigationController?
    private var transitions: ProfileCoordinatorTransitions?
    private var serviceHolder: ServiceHolder
    
    init(navigationController: UINavigationController?, transitions: ProfileCoordinatorTransitions?, serviceHolder: ServiceHolder) {
        self.navigationController = navigationController
        self.transitions = transitions
        self.serviceHolder = serviceHolder
    }
    
    func start() {
        if let controller = Storyboard.profile.controller(withClass: ProfileViewController.self) {
            let viewModel = ProfileViewModel(coordinator: self, serviceHolder: serviceHolder)
            controller.viewModel = viewModel
            navigationController?.setViewControllers([controller], animated: true)
        }
    }
}
