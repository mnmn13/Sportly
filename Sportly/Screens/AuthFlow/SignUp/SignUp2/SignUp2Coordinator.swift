//
//  SignUp2Coordinator.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

protocol SignUp2CoordinatorTransitions: AnyObject {
    func startPreFlow()
}
protocol SignUp2CoordinatorType {
    func startPreFlow()
}

class SignUp2Coordinator: SignUp2CoordinatorType {
    
    private let navigationController: UINavigationController?
    private var transitions: SignUp2CoordinatorTransitions?
    private var serviceHolder: ServiceHolder
    
    init(navigationController: UINavigationController?, transitions: SignUp2CoordinatorTransitions?, serviceHolder: ServiceHolder) {
        self.navigationController = navigationController
        self.transitions = transitions
        self.serviceHolder = serviceHolder
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    func start(user: UserRegistration) {
        if let controller = Storyboard.signUp2.controller(withClass: SignUp2ViewController.self) {
            let viewModel = SignUp2ViewModel(coordinator: self, serviceHolder: serviceHolder, user: user)
            controller.viewModel = viewModel
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func backClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    func startPreFlow() {
        transitions?.startPreFlow()
    }
}
