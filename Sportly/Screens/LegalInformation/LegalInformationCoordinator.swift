//
//  LegalInformationCoordinator.swift
//  Sportly
//
//  Created by MN on 30.05.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

protocol LegalInformationCoordinatorType {}

class LegalInformationCoordinator: LegalInformationCoordinatorType {
    
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start(type: LegalInformationType) {
        if let controller = Storyboard.legalInformation.controller(withClass: LegalInformationViewController.self) {
            let viewModel = LegalInformationViewModel(coordinator: self, legalInformationType: type)
            controller.viewModel = viewModel
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
}
