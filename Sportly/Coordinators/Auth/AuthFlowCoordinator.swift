//
//  AuthFlowCoordinator.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//

import UIKit

protocol AuthFlowCoordinatorTransitions: AnyObject {
    func userDidLogin()
    func startWithoutLogin()
    func startPreFlow()
}

class AuthFlowCoordinator {
    
    private let window: UIWindow
    private let rootNav: UINavigationController = UINavigationController()
    private weak var transitions: AuthFlowCoordinatorTransitions?
    private let serviceHolder: ServiceHolder
    
    init(window: UIWindow, transitions: AuthFlowCoordinatorTransitions, serviceHolder: ServiceHolder) {
        self.window = window
        self.transitions = transitions
        self.serviceHolder = serviceHolder
    }
    
    func start() {
        let coordinator = WelcomeCoordinator(navigationController: rootNav, transitions: self, serviceHolder: serviceHolder)
        coordinator.start()
        window.rootViewController = rootNav
        window.makeKeyAndVisible()
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
}

extension AuthFlowCoordinator: WelcomeCoordinatorTransitions {
    
    func openEmailSignUp() {
        let coordinator = SignUp1Coordinator(navigationController: rootNav, transitions: self, serviceHolder: serviceHolder)
        coordinator.start()
    }
}

extension AuthFlowCoordinator: SignUp1CoordinatorTransitions {
    func goToSignUp2(user: UserRegistration) {
        let coordinator = SignUp2Coordinator(navigationController: rootNav, transitions: self, serviceHolder: serviceHolder)
        coordinator.start(user: user)
    }
}
extension AuthFlowCoordinator: SignUp2CoordinatorTransitions {
    
    func startPreFlow() {
        transitions?.startPreFlow()
    }
    
}

