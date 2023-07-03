//
//  HomeCoordinator.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

protocol HomeCoordinatorTransitions: AnyObject {}

protocol HomeCoordinatorType {}

class HomeCoordinator: HomeCoordinatorType {
    
    private weak var navigationController: UINavigationController?
    private weak var transitions: HomeCoordinatorTransitions?
    private var serviceHolder: ServiceHolder
    
    init(navigationController: UINavigationController?, transitions: HomeCoordinatorTransitions?, serviceHolder: ServiceHolder) {
        self.navigationController = navigationController
        self.transitions = transitions
        self.serviceHolder = serviceHolder
    }
    
    func start() {
        if let controller = Storyboard.home.controller(withClass: HomeViewController.self) {
            let viewModel = HomeViewModel(coordinator: self, serviceHolder: serviceHolder)
            controller.viewModel = viewModel
            navigationController?.setViewControllers([controller], animated: true)
        }
    }
}
