//
//  WelcomeCoordinator.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

protocol WelcomeCoordinatorTransitions: AnyObject {
    func openEmailSignUp()
}

protocol WelcomeCoordinatorType {
    func openEmailSignUp()
    func openTerms(type: LegalInformationType)
}

class WelcomeCoordinator: WelcomeCoordinatorType {
    
    private let navigationController: UINavigationController?
    private weak var transitions: WelcomeCoordinatorTransitions?
    private var serviceHolder: ServiceHolder
    
    init(navigationController: UINavigationController?, transitions: WelcomeCoordinatorTransitions?, serviceHolder: ServiceHolder) {
        self.navigationController = navigationController
        self.transitions = transitions
        self.serviceHolder = serviceHolder
    }
    
    func start() {
        if let controller = Storyboard.welcome.controller(withClass: WelcomeViewController.self) {
            let viewModel = WelcomeViewModel(coordinator: self, serviceHolder: serviceHolder)
            controller.viewModel = viewModel
            navigationController?.setViewControllers([controller], animated: true)
        }
    }
    
    func openEmailSignUp() {
        transitions?.openEmailSignUp()
    }
    
    func openTerms(type: LegalInformationType) {
        let coordinator = LegalInformationCoordinator(navigationController: navigationController)
        coordinator.start(type: type)
    }
}
