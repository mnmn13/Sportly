//
//  DiscoverCoordinator.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

protocol DiscoverCoordinatorTransitions: AnyObject {}

protocol DiscoverCoordinatorType {}

class DiscoverCoordinator: DiscoverCoordinatorType {
    
    private let navigationController: UINavigationController?
    private var transitions: DiscoverCoordinatorTransitions?
    private var serviceHolder: ServiceHolder
    
    init(navigationController: UINavigationController?, transitions: DiscoverCoordinatorTransitions?, serviceHolder: ServiceHolder) {
        self.navigationController = navigationController
        self.transitions = transitions
        self.serviceHolder = serviceHolder
    }
    
    func start() {
        if let controller = Storyboard.discover.controller(withClass: DiscoverViewController.self) {
            let viewModel = DiscoverViewModel(coordinator: self, serviceHolder: serviceHolder)
            controller.viewModel = viewModel
            navigationController?.setViewControllers([controller], animated: true)
        }
    }
}
