//
//  StatsCoordinator.swift
//  Sportly
//
//  Created by MN on 25.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

protocol StatsCoordinatorTransitions: AnyObject {}

protocol StatsCoordinatorType {
    func openDetailedStats(with leagueModel: LeaguesInfoResponse)
}

class StatsCoordinator: StatsCoordinatorType {
    
    private let navigationController: UINavigationController?
    private var transitions: StatsCoordinatorTransitions?
    private var serviceHolder: ServiceHolder
    
    init(navigationController: UINavigationController?, transitions: StatsCoordinatorTransitions?, serviceHolder: ServiceHolder) {
        self.navigationController = navigationController
        self.transitions = transitions
        self.serviceHolder = serviceHolder
    }
    
    func start() {
        if let controller = Storyboard.stats.controller(withClass: StatsViewController.self) {
            let viewModel = StatsViewModel(coordinator: self, serviceHolder: serviceHolder)
            controller.viewModel = viewModel
            navigationController?.setViewControllers([controller], animated: true)
        }
    }
    
    func openDetailedStats(with leagueModel: LeaguesInfoResponse) {
        let controller = DetailedStatsViewController()
        controller.viewModel = DetailedStatsViewModel(coordinator: self, serviceHolder: serviceHolder, leagueModel: leagueModel)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
