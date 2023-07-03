//
//  HomeTabbarCoordinator.swift
//  Sportly
//
//  Created by MN on 26.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

protocol HomeTabbarCoordinatorTransitions: AnyObject {}

protocol HomeTabbarCoordinatorType {}

class HomeTabbarCoordinator: TabbarItemsCoordinatorType {
    
    let rootController = UINavigationController()
    let tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
    private weak var transitions: HomeTabbarCoordinatorTransitions?
    private var serviceHolder: ServiceHolder
    
    init(transitions: HomeTabbarCoordinatorTransitions, serviceHolder: ServiceHolder) {
        self.transitions = transitions
        self.serviceHolder = serviceHolder
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    func start() {
        rootController.tabBarItem = tabBarItem
        let coordinator = HomeCoordinator(navigationController: rootController, transitions: self, serviceHolder: serviceHolder)
        coordinator.start()
    }
}

extension HomeTabbarCoordinator: HomeCoordinatorTransitions {}
