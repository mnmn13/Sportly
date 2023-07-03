//
//  ProfileTabbarCoordinator.swift
//  Sportly
//
//  Created by MN on 26.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

protocol ProfileTabbarCoordinatorTransitions: AnyObject {}

protocol ProfileTabbarCoordinatorType {}

class ProfileTabbarCoordinator: TabbarItemsCoordinatorType {
    
    let rootController = UINavigationController()
    let tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), tag: 4)
    private weak var transitions: ProfileTabbarCoordinatorTransitions?
    private var serviceHolder: ServiceHolder
    
    init(transitions: ProfileTabbarCoordinatorTransitions, serviceHolder: ServiceHolder) {
        self.transitions = transitions
        self.serviceHolder = serviceHolder
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    func start() {
        rootController.tabBarItem = tabBarItem
        let coordinator = ProfileCoordinator(navigationController: rootController, transitions: self, serviceHolder: serviceHolder)
        coordinator.start()
    }
}

extension ProfileTabbarCoordinator: ProfileCoordinatorTransitions {}
