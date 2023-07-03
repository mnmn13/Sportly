//
//  SignUp1Coordinator.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

protocol SignUp1CoordinatorTransitions: AnyObject {
    func goToSignUp2(user: UserRegistration)
}
protocol SignUp1CoordinatorType {
    func backClicked()
    func goToSignUp2(user: UserRegistration)
}

class SignUp1Coordinator: SignUp1CoordinatorType {
    
    private let navigationController: UINavigationController?
    private var transitions: SignUp1CoordinatorTransitions?
    private var serviceHolder: ServiceHolder
    
    init(navigationController: UINavigationController?, transitions: SignUp1CoordinatorTransitions?, serviceHolder: ServiceHolder) {
        self.navigationController = navigationController
        self.transitions = transitions
        self.serviceHolder = serviceHolder
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    func start() {
        if let controller = Storyboard.signUp1.controller(withClass: SignUp1ViewController.self) {
            let viewModel = SignUp1ViewModel(coordinator: self, serviceHolder: serviceHolder)
            controller.viewModel = viewModel
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func backClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    func goToSignUp2(user: UserRegistration) {
        transitions?.goToSignUp2(user: user)
    }
    
}


