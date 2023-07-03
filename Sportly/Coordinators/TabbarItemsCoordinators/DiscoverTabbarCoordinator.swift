//
//  DiscoverTabbarCoordinator.swift
//  Sportly
//
//  Created by MN on 26.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

protocol DiscoverTabbarCoordinatorTransitions: AnyObject {}

protocol DiscoverTabbarCoordinatorType {}

class DiscoverTabbarCoordinator: TabbarItemsCoordinatorType {
    
    let rootController = UINavigationController()
    let tabBarItem = UITabBarItem(title: "Discover", image: UIImage(systemName: "star.fill"), tag: 1)
    private weak var transitions: DiscoverTabbarCoordinatorTransitions?
    private var serviceHolder: ServiceHolder
    
    init(transitions: DiscoverTabbarCoordinatorTransitions, serviceHolder: ServiceHolder) {
        self.transitions = transitions
        self.serviceHolder = serviceHolder
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    func start() {
        rootController.tabBarItem = tabBarItem
        let coordinator = DiscoverCoordinator(navigationController: rootController, transitions: self, serviceHolder: serviceHolder)
        coordinator.start()
    }
}

extension DiscoverTabbarCoordinator: DiscoverCoordinatorTransitions {}
