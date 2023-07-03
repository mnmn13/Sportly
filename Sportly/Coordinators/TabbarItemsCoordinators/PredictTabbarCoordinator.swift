//
//  PredictTabbarCoordinator.swift
//  Sportly
//
//  Created by MN on 26.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

protocol PredictTabbarCoordinatorTransitions: AnyObject {}

protocol PredictTabbarCoordinatorType {}

class PredictTabbarCoordinator: TabbarItemsCoordinatorType {
    
    let rootController = UINavigationController()
    let tabBarItem = UITabBarItem(title: "Predict", image: UIImage(systemName: "circle.fill"), tag: 2)
    private weak var transitions: PredictTabbarCoordinatorTransitions?
    private var serviceHolder: ServiceHolder
    
    init(transitions: PredictTabbarCoordinatorTransitions, serviceHolder: ServiceHolder) {
        self.transitions = transitions
        self.serviceHolder = serviceHolder
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    func start() {
        rootController.tabBarItem = tabBarItem
        let coordinator = PredictCoordinator(navigationController: rootController, transitions: self, serviceHolder: serviceHolder)
        coordinator.start()
    }
}

extension PredictTabbarCoordinator: PredictCoordinatorTransitions {}
