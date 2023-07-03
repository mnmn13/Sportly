//
//  StatsTabbarCoordinator.swift
//  Sportly
//
//  Created by MN on 26.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

protocol StatsTabbarCoordinatorTransitions: AnyObject {}

protocol StatsTabbarCoordinatorType {}

class StatsTabbarCoordinator: TabbarItemsCoordinatorType {
    
    let rootController = UINavigationController()
    let tabBarItem = UITabBarItem(title: "Stats", image: UIImage(systemName: "chart.bar.fill"), tag: 3)
    private weak var transitions: StatsTabbarCoordinatorTransitions?
    private var serviceHolder: ServiceHolder
    
    init(transitions: StatsTabbarCoordinatorTransitions, serviceHolder: ServiceHolder) {
        self.transitions = transitions
        self.serviceHolder = serviceHolder
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    func start() {
        rootController.tabBarItem = tabBarItem
        let coordinator = StatsCoordinator(navigationController: rootController, transitions: self, serviceHolder: serviceHolder)
        coordinator.start()
    }
}

extension StatsTabbarCoordinator: StatsCoordinatorTransitions {}
