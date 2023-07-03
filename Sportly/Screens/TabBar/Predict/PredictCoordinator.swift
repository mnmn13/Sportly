//
//  PredictCoordinator.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

protocol PredictCoordinatorTransitions: AnyObject {}

protocol PredictCoordinatorType {}

class PredictCoordinator: PredictCoordinatorType {
    
    private let navigationController: UINavigationController?
    private var transitions: PredictCoordinatorTransitions?
    private var serviceHolder: ServiceHolder
    
    init(navigationController: UINavigationController?, transitions: PredictCoordinatorTransitions?, serviceHolder: ServiceHolder) {
        self.navigationController = navigationController
        self.transitions = transitions
        self.serviceHolder = serviceHolder
    }
    
    func start() {
        if let controller = Storyboard.predict.controller(withClass: PredictViewController.self) {
            let viewModel = PredictViewModel(coordinator: self, serviceHolder: serviceHolder)
            controller.viewModel = viewModel
            navigationController?.setViewControllers([controller], animated: true)
        }
    }
}
