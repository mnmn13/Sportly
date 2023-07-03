//
//  MainFlowCoordinator.swift
//  Sportly
//
//  Created by MN on 15.05.2023.
//

import UIKit

protocol MainFlowCoordinatorTransitions: AnyObject {}

protocol MainFlowCoordinatorType {}

class MainFlowCoordinator {
    
    let serviceHolder: ServiceHolder
    private let window: UIWindow
    private let rootNav: UINavigationController = UINavigationController()
    private weak var transitions: MainFlowCoordinatorTransitions?
    
    init(window: UIWindow, transitions: MainFlowCoordinatorTransitions?, serviceHolder: ServiceHolder) {
        self.window = window
        self.transitions = transitions
        self.serviceHolder = serviceHolder
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    func start() {
//        let coordinator = StandingsCoordinator(serviceHolder: serviceHolder, navigationController: rootNav, transitions: self)
//        coordinator.start()
//
//            window.rootViewController = rootNav
//            window.makeKeyAndVisible()
    }
}

//extension MainFlowCoordinator: StandingsCoordinatorTransitions {}
